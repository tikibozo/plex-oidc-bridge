# Changelog

## [0.6.12](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.11...v0.6.12) (2026-09-06)


### Bug Fixes

* **deps:** update golang docker tag to v1.27.1 ([#43](https://github.com/tikibozo/plex-oidc-bridge/issues/43)) ([4d016d7](https://github.com/tikibozo/plex-oidc-bridge/commit/4d016d7b0bb06d7c1df8db43a45b5ec1a3ad16ad))

## [0.6.11](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.10...v0.6.11) (2026-08-23)


### Bug Fixes

* **deps:** update golang docker tag to v1.27.0 ([#40](https://github.com/tikibozo/plex-oidc-bridge/issues/40)) ([e784a4e](https://github.com/tikibozo/plex-oidc-bridge/commit/e784a4e9898d0309e33963a9a08c6cb03da9c1c7))

## [0.6.10](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.9...v0.6.10) (2026-08-16)


### Bug Fixes

* **deps:** update golang:1.26.6-alpine docker digest to 3889b42 ([#37](https://github.com/tikibozo/plex-oidc-bridge/issues/37)) ([1dddde2](https://github.com/tikibozo/plex-oidc-bridge/commit/1dddde2b032fffdd95454fc5e85020e08d546e4a))

## [0.6.9](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.8...v0.6.9) (2026-08-16)


### Bug Fixes

* **deps:** update golang docker tag to v1.26.6 ([#35](https://github.com/tikibozo/plex-oidc-bridge/issues/35)) ([cc55ec4](https://github.com/tikibozo/plex-oidc-bridge/commit/cc55ec4958a2085f30ce8d5ddb490692e8258cbf))

## [0.6.8](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.7...v0.6.8) (2026-07-27)


### Bug Fixes

* **deps:** update golang docker tag to v1.26.5 ([#32](https://github.com/tikibozo/plex-oidc-bridge/issues/32)) ([9406a2c](https://github.com/tikibozo/plex-oidc-bridge/commit/9406a2c13d61d7614c31d82dafa46fbb9b959a1e))

## [0.6.7](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.6...v0.6.7) (2026-06-22)


### Bug Fixes

* **deps:** update golang ([#27](https://github.com/tikibozo/plex-oidc-bridge/issues/27)) ([2cc4d1a](https://github.com/tikibozo/plex-oidc-bridge/commit/2cc4d1afff1e4f860ddb5f0ed324ad7260b67dea))

## [0.6.6](https://github.com/tikibozo/plex-oidc-bridge/compare/v0.6.5...v0.6.6) (2026-06-21)


### Bug Fixes

* **deps:** update alpine:3.24 docker digest to 28bd5fe ([#26](https://github.com/tikibozo/plex-oidc-bridge/issues/26)) ([5c1f63c](https://github.com/tikibozo/plex-oidc-bridge/commit/5c1f63c52841246253cd24921589433832a12568))

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
