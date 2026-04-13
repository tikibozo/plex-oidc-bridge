# Plex OIDC Bridge

A lightweight OIDC (OpenID Connect) Provider that uses Plex for authentication. Designed specifically to bridge Plex users into identity flows like **Cloudflare Access**, **Tailscale**, or any other OIDC-compatible client.

## About this fork

This is a fork of [`blacktirion/plex-oidc-bridge`](https://github.com/blacktirion/plex-oidc-bridge) (upstream inactive since January 2026). It stays functionally compatible with upstream and adds:

- **Server-scoped friend filter** — optionally restrict authentication to Plex users who are shared on a specific Plex server (plus the server owner). Upstream authenticates **any** Plex user and pushes access control to downstream apps. With this fork you can enforce it at the OIDC layer. See [Friend filter](#friend-filter-this-fork) below.
- **Log-injection hardening** — `sanitizeForLog` now strips CR/LF/TAB in addition to truncating, preventing forged log lines via crafted `client_id` / `redirect_uri`.
- **Security CI** — `govulncheck`, CodeQL (Go), `gitleaks`, `gosec`, `staticcheck`, and Trivy image scanning on push, PR, and weekly. See `.github/workflows/security.yml`.
- **Reproducible base image** — `Dockerfile` pins `alpine:3.21` by digest instead of `alpine:latest`.
- **Dependabot** — weekly updates for Go modules, Docker base image, and GitHub Actions.

Published to `ghcr.io/tikibozo/plex-oidc-bridge:latest`.

## IMPORTANT DISCLAIMERS
1. This project is not affiliated with Plex, Inc. or Cloudflare, Inc. in any way. Use at your own risk. This software is provided "as is", without warranty of any kind.
2. This software is an **AUTHENTICATION** provider only. It does not provide authorization or user management features. You are responsible for configuring your identity platform to manage access control. This software is an easy way to capture Plex identities and use them in your existing OIDC flows. If you are unsure of the differences between authentication and authorization, please research those topics before using this software.
3. You should have a basic understanding of OIDC, OAuth2, and Plex authentication flows to use this software effectively.
4. Always run this software behind HTTPS (e.g., Cloudflare Tunnel, nginx reverse proxy with TLS, etc.) to protect user credentials and tokens. Anyone who can access this service and its signing keys can impersonate authenticated users; protect it accordingly.
5. Review the source code before use to ensure it meets your security requirements. Additionally, this software is for personal or homelab use only and should not be used in production or enterprise environments. It may lack the security features and compliance required for such use cases.
6. Plex may, at any time and without notice, change their authentication mechanisms or APIs, which could break this software. Attempts to update the software will be made on a best effort basis, but no guarantees are made.


## Features

- **Plex Authentication**: Users sign in via the standard Plex OAuth PIN flow.
- **OIDC Discovery**: Fully compliant `/.well-known/openid-configuration`.
- **JWKS Endpoint**: Automatically manages RSA signing keys for JWT verification.
- **Cloudflare Compatible**: Specifically tested with Cloudflare Access for homelab and media server security
- **Stable Identity**: Uses Plex `uuid` as the `sub` (subject) claim for stability, with email fallback.
- **Test Mode**: Optional built-in verification flow (`/test`) to verify the login process.

## Quick Start

### 1. Build & Run locally
```bash
# Build the binary
go build -o plex-bridge .

# Set your external URL (important for OIDC redirects)
export PUBLIC_URL="http://localhost:8080"
export ENABLE_TEST_ENDPOINTS="true"
export ALLOWED_REDIRECT_URIS="http://localhost:8080/test/callback"
export TRUST_PROXY_HEADERS="true"

# Start the bridge
./plex-bridge
```

### 2. Verify with Test Mode
Open your browser to `http://localhost:8080/test`. 
This will walk you through a complete Plex login and display the resulting OIDC claims (Email, Username, UUID, etc.).

## Docker Deployment

The recommended way to run this in a homelab is using Docker or Docker Compose.

### Running with Docker CLI
```bash
docker build -t plex-oidc-bridge .

docker run -d \
  -p 8080:8080 \
  -e PUBLIC_URL="https://auth.example.com" \
  -e ALLOWED_REDIRECT_URIS="https://example.com/callback,https://another.com/redirect" \
  -e TRUST_PROXY_HEADERS="true" \
  -v ./config:/app/config \
  --name plex-bridge \
  plex-oidc-bridge
```

### Running with Docker Compose
```yaml
services:
  plex-bridge:
    image: ghcr.io/tikibozo/plex-oidc-bridge:latest
    container_name: plex-auth-bridge
    ports:
      - "8080:8080"
    volumes:
      - ./config:/app/config
    environment:
      - PUBLIC_URL=https://auth.example.com
      - PORT=8080
      - ALLOWED_REDIRECT_URIS=https://example.com/callback,https://another.com/redirect
      - TRUST_PROXY_HEADERS=true
    restart: unless-stopped
```

## First Run & Setup

On the first run, the bridge will generate an OIDC Client ID and Secret if you don't provide them. 
**Secrets are never printed to logs for security reasons.** Retrieve your credentials from the configuration file:

```bash
# View the generated Client ID and Secret
cat config/clients.json
```

You will see output like this, which you can copy/paste into Cloudflare Access or your identity platform of choice:

```json
{
  "client_id": "AbCdEfGhIjKlMnOpQrStUvWx",
  "client_secret": "aBcDeFgHiJkLmNoPqRsTuVwXyZ123456"
}
```

Your OIDC endpoints are:
- **Auth URL**: `https://auth.example.com/authorize`
- **Token URL**: `https://auth.example.com/token`
- **JWKS URL (Certs)**: `https://auth.example.com/.well-known/jwks.json`
- **Discovery URL**: `https://auth.example.com/.well-known/openid-configuration`

## Configuration Parameters

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `PUBLIC_URL` | Env (Required) | - | The public HTTPS URL where this bridge is accessible (e.g., `https://auth.example.com`). The server will not start if this is unset. Used for discovery endpoints and OIDC redirects. |
| `PORT` | Env (Optional) | `8080` | The internal port the bridge listens on. |
| `ENABLE_TEST_ENDPOINTS` | Env (Optional) | `false` | Set to `"true"` to enable the `/test` debugging endpoints. |
| `ALLOWED_REDIRECT_URIS` | Env (Required) | *(none)* | Comma-separated whitelist of allowed `redirect_uri` values (must be `https`). If not set, authorization requests are rejected. |
| `TRUST_PROXY_HEADERS` | Env (Optional) | `false` | Set to `"true"` only if running behind a trusted reverse proxy (Cloudflare Tunnel, nginx, etc.). When enabled, rate limiting uses `X-Forwarded-For` and `X-Real-IP` headers instead of direct connection IP. |
| `SESSION_TTL_MINUTES` | Env (Optional) | `10` | TTL for Plex/OIDC session (PIN) state before it expires. |
| `AUTH_CODE_TTL_MINUTES` | Env (Optional) | `10` | TTL for issued authorization codes before they expire. |
| `OIDC_CLIENT_ID` | Env (Optional) | Generated | If set, forces the specific Client ID. If not set, one is generated and saved to `/app/config/clients.json`. |
| `OIDC_CLIENT_SECRET` | Env (Optional) | Generated | If set, forces the specific Client Secret. |
| `PLEX_SERVER_TOKEN` | Env (Optional, this fork) | *(unset — filter disabled)* | Plex server **owner** auth token. When set, only users shared on the configured server (plus the owner) can authenticate. See [Friend filter](#friend-filter-this-fork). |
| `PLEX_SERVER_ID` | Env (Required if `PLEX_SERVER_TOKEN` set, this fork) | - | The server's `machineIdentifier`. Used to query shared users for this specific server. |
| `PLEX_FRIEND_CACHE_TTL_SECONDS` | Env (Optional, this fork) | `300` | How long to cache the shared-users list between Plex API refreshes. |

### Persistence
The bridge stores generated keys and configuration in `/app/config`. You should mount this volume to persist your RSA signing keys and Client credentials.
- `oidc.key`: The RSA private key for signing tokens.
- `clients.json`: Stores the generated Client ID and Secret.

### How Parameters Work
- **`PUBLIC_URL`**: This tells the bridge how to construct its own URLs. If you are using a Cloudflare Tunnel or Reverse Proxy, set this to your public domain.

## Cloudflare Access Configuration

To use this bridge with Cloudflare Access/Zero Trust:

1.  **Identity Provider**: Add a new **Generic OIDC** provider.
2.  **Get Your Credentials**: Retrieve your Client ID and Secret from `config/clients.json` (never from logs).
3.  **Configuration**:
    *   **Name**: Plex
    *   **App ID**: `<Client ID from config/clients.json>`
    *   **App Secret**: `<Client Secret from config/clients.json>`
    *   **Auth URL**: `https://your-bridge-url.com/authorize`
    *   **Token URL**: `https://your-bridge-url.com/token`
    *   **Certificate URL**: `https://your-bridge-url.com/.well-known/jwks.json`
4.  **Scopes**: Ensure `openid`, `email`, and `profile` are requested.

## Friend filter (this fork)

By default (if `PLEX_SERVER_TOKEN` is unset), this fork behaves identically to upstream: **any** Plex user can complete authentication. Access control is left to the downstream application.

When `PLEX_SERVER_TOKEN` and `PLEX_SERVER_ID` are set, the bridge adds a server-scoped allowlist check after Plex authentication succeeds but before minting an authorization code:

1. At startup, the bridge calls `https://plex.tv/api/v2/user` with the owner token to resolve the **owner's Plex user ID**. The owner is always allowed through.
2. At startup and every `PLEX_FRIEND_CACHE_TTL_SECONDS`, the bridge calls `https://plex.tv/api/servers/{PLEX_SERVER_ID}/shared_servers` and builds a set of allowed Plex user IDs.
3. On each `/callback`, after the user authenticates with Plex, their numeric Plex user ID is checked against the allowlist. Match → authorization code issued. No match → HTTP 403 with a clear error.

### Semantics

- **Match key is the numeric Plex user ID**, not email — home/managed users share the owner's email and usernames can change.
- **Fail-closed on cold start**: if the initial shared-users fetch fails and no cache has ever loaded, `/callback` returns 503 rather than falling open.
- **Stale cache on refresh failure**: if a refresh fails *after* a prior successful load, the last-known list is served and a warning is logged. A transient Plex API outage won't deny your friends.
- **Unchanged behavior when `PLEX_SERVER_TOKEN` is unset** — the bridge is drop-in compatible with upstream.

### Finding your `PLEX_SERVER_ID`

Once you have an owner token, list your owned servers and grab the `clientIdentifier`:

```bash
curl -s 'https://plex.tv/api/v2/resources?includeHttps=1' \
  -H 'Accept: application/json' \
  -H "X-Plex-Token: $PLEX_SERVER_TOKEN" \
  -H 'X-Plex-Client-Identifier: plex-oidc-bridge-docker' \
  | jq '.[] | select(.owned==true and (.provides|contains("server"))) | {name, clientIdentifier}'
```

### Finding your `PLEX_SERVER_TOKEN`

See Plex's guide: [Finding an authentication token (X-Plex-Token)](https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/). Use the token tied to your Plex **account** (the one that owns the server), not a server-only token.

### Example compose snippet

```yaml
services:
  plex-oidc-bridge:
    image: ghcr.io/tikibozo/plex-oidc-bridge:latest
    container_name: plex-oidc-bridge
    restart: unless-stopped
    volumes:
      - ./config:/app/config
    env_file:
      - .env.plex-oidc-bridge   # keep PLEX_SERVER_TOKEN out of compose, mode 600
    environment:
      - PUBLIC_URL=https://auth.example.com
      - ALLOWED_REDIRECT_URIS=https://app.example.com/oauth/callback
      - TRUST_PROXY_HEADERS=true
```

`.env.plex-oidc-bridge` (chmod 600):

```env
PLEX_SERVER_TOKEN=xxxxxxxxxxxxxxxxxxxx
PLEX_SERVER_ID=abcdef0123456789abcdef0123456789abcdef01
```

### Rotation

If the owner token needs to be rotated (e.g. Plex password change, "sign out of all devices"), update the value in `.env.plex-oidc-bridge` and `docker compose up -d plex-oidc-bridge`. The bridge re-resolves the owner ID and refreshes the allowlist on boot.

### Defense-in-depth

The friend filter is an authentication-layer gate. Downstream apps should still apply their own authorization (roles, per-user approvals, etc.) where appropriate — the two controls are complementary.

## License

MIT
