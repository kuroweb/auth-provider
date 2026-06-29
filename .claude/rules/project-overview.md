---
paths:
  - '**/*'
---
# プロジェクト概要

## 目的

- OpenID Connect Provider を実装し、認証基盤として運用する。
- Rails / OIDC / 認証認可まわりの学習と実運用を両立する。
- `price-monitoring` の relying party に対して認証機能を提供する。

## システム構成

- Backend: Rails 8 + Devise + Doorkeeper + doorkeeper-openid_connect
- Data Store: MySQL / Redis
- Proxy: Nginx
- 開発環境: Docker Compose
- 本番環境: Kubernetes + ArgoCD

## 連携対象

- `price-monitoring` Frontend: OIDC の認可要求元
- `price-monitoring` Backend: token request / token validation の連携先

## 主要エンドポイント

- Discovery: `/.well-known/openid-configuration`
- Authorization: `/oauth/authorize`
- Token: `/oauth/token`
- UserInfo: `/oauth/userinfo`

## 開発時の前提

- ローカル URL は `https://dev.auth-provider.com`
- 署名用秘密鍵は `volumes/backend/certs/private.pem` を利用する。
- ローカル HTTPS 証明書は `volumes/nginx/certs/` 配下に配置する。
