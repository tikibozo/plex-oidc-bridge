# Changelog

## [0.6.5](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.4...v0.6.5) (2026-06-15)


### Bug Fixes

* **security:** patch OpenSSL CVE-2026-45447 in base image ([#24](https://github.com/tikibozo/plex-oidc-bridge/issues/24)) ([82927cd](https://github.com/tikibozo/plex-oidc-bridge/commit/82927cd5859cd957a30236a0885a5647038402dd))

## [0.6.4](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.3...v0.6.4) (2026-06-14)


### Bug Fixes

* **deps:** update golang ([#15](https://github.com/tikibozo/plex-oidc-bridge/issues/15)) ([97f9683](https://github.com/tikibozo/plex-oidc-bridge/commit/97f968376f996b97c9aef61ef7adfcde3b8a7549))

## [0.6.3](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.2...v0.6.3) (2026-06-14)


### Bug Fixes

* **deps:** update alpine docker tag to v3.24 ([#21](https://github.com/tikibozo/plex-oidc-bridge/issues/21)) ([8507840](https://github.com/tikibozo/plex-oidc-bridge/commit/85078402233fd8141fc1f665a51d6d8360d220d6))

## [0.6.2](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.1...v0.6.2) (2026-06-08)


### Bug Fixes

* rebuild image on Go 1.26.4 to remediate CVE-2026-42504 ([1b7eedc](https://github.com/tikibozo/plex-oidc-bridge/commit/1b7eedc1c86c4687697d38931935425bd9619ed5))

## [0.6.1](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.0...v0.6.1) (2026-05-31)


### Bug Fixes

* **deps:** update module github.com/golang-jwt/jwt/v5 to v5.3.1 ([#8](https://github.com/tikibozo/plex-oidc-bridge/issues/8)) ([ce5eb2b](https://github.com/tikibozo/plex-oidc-bridge/commit/ce5eb2bf7fc4c0fcc3ef561d8368b9e08a833c02))

## [0.6.0](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.5.1...v0.6.0) (2026-05-19)


### Features

* run container as non-root (uid 10001) with a HEALTHCHECK ([3a2360d](https://github.com/tikibozo/plex-oidc-bridge/commit/3a2360df44eee966bfc7ed887a9d5ab66a17c6ee))

## [0.5.1](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.5.0...v0.5.1) (2026-05-18)


### Miscellaneous Chores

* release 0.5.1 ([ea2bd82](https://github.com/tikibozo/plex-oidc-bridge/commit/ea2bd82fa2958b61744d45cebac2b01ac7eeb1fd))

## 0.5.0 (2026-05-18)


### Miscellaneous Chores

* set up release-please semver automation ([9dbe5c0](https://github.com/tikibozo/plex-oidc-bridge/commit/9dbe5c0ac116832b38dffbe644255f18bdc176b7))
