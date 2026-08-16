# Synology has slightly older Docker versions sometimes, but standard BuildKit is usually fine.
# Use a multi-stage build to keep the image small.

# Stage 1: Build
FROM golang:1.26.6-alpine@sha256:3889b425f035be855a72fb4755265311293b6d414521f0a519d819df32222d83 AS builder

WORKDIR /app

# Copy dependency files
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY *.go ./

# Tidy and build
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -o plex-oidc-bridge .

# Stage 2: Runtime
FROM alpine:3.24@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

# Pull patched OS packages (e.g. libcrypto3/libssl3) from the Alpine repo. The
# pinned base image lags fresh CVE fixes between Alpine's periodic rebuilds, so
# upgrade in place to keep the Trivy gate green without unpinning the base.
RUN apk upgrade --no-cache

# Run as a non-root user. Fixed uid/gid 10001 so bind-mounted config
# volumes can be chowned predictably: `chown -R 10001:10001 ./config`.
RUN addgroup -g 10001 -S app \
    && adduser -u 10001 -S -G app app

WORKDIR /app

# Copy the binary and create the config dir owned by the non-root user
COPY --from=builder --chown=app:app /app/plex-oidc-bridge .
RUN mkdir -p /app/config && chown -R app:app /app

# Expose the port the app runs on
EXPOSE 8080

# Environment variables that can be overridden
ENV PORT=8080
ENV PUBLIC_URL=""
ENV OIDC_CLIENT_ID=""

# Volume for persistence
VOLUME ["/app/config"]

# Liveness: the OIDC discovery endpoint is public and requires the app to
# be fully started (keys + config loaded). busybox wget ships with alpine.
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
    CMD wget -q -O - "http://127.0.0.1:${PORT:-8080}/.well-known/openid-configuration" >/dev/null 2>&1 || exit 1

USER app

# Run the binary
CMD ["./plex-oidc-bridge"]
