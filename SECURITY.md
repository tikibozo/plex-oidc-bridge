# Security Policy

`plex-oidc-bridge` is an authentication component. Issues that affect the
integrity of the OIDC/Plex auth flow are taken seriously, and this is a
community-maintained fork with best-effort support.

## Supported versions

Fixes land on the latest released minor and the `:latest` / newest release
tags. Older minors are not back-patched.

| Version | Supported          |
| ------- | ------------------ |
| 0.5.x   | :white_check_mark: |
| < 0.5   | :x:                |

Pin a specific release (e.g. `:0.5.0`, ideally by digest) for reproducible
deployments; track `:0.5` or `:latest` to pick up fixes on the next pull.

## Reporting a vulnerability

**Do not open a public issue for security problems.**

Use GitHub's private vulnerability reporting:
**Security → Report a vulnerability** on
<https://github.com/tikibozo/plex-oidc-bridge/security/advisories/new>.

Please include affected version/tag or digest, a description and impact, and
reproduction steps. Expect an acknowledgement within ~7 days (best effort);
fixes ship as a patch release with an advisory once a fix is available.

## What's in place

Every push, pull request, and a weekly schedule run `govulncheck`, CodeQL
(Go), `gitleaks`, `gosec`, and `staticcheck`; published images are blocked on
HIGH/CRITICAL findings by a pre-publish Trivy scan. Dependency and base-image
updates are automated. This reduces but does not eliminate risk — independent
reports are still valued.
