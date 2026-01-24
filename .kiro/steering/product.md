# Product Overview

- OpenID Connect Provider (OP) 実装
- 学習目的で構築された認証プロバイダー
- price-monitoring アプリケーションの認証基盤として運用

# Core Capabilities

- OIDC認証フロー:
  - Authorization Code Grant
  - Refresh Token対応
  - ID Token発行
- ユーザー管理:
  - 登録・ログイン・パスワードリセット
  - トラッキング（ログイン履歴）
- OAuth 2.0 スコープ:
  - `openid`（デフォルト）
  - `email`, `profile`（オプション）

# Target Use Cases

- シングルサインオン（SSO）:
  - price-monitoring の認証バックエンド
  - 将来的な複数アプリケーション対応
- OIDC仕様の学習・実験

# Value Proposition

- 自己ホスト型認証基盤:
  - 外部認証サービスへの依存なし
  - 完全なコントロール
- 本番環境での運用実績:
  - 自宅Kubernetes環境で稼働
  - ArgoCD による GitOps デプロイ

# Integration Points

- Relying Party (RP):
  - price-monitoring（フロントエンド/バックエンド）
- 標準エンドポイント:
  - `/.well-known/openid-configuration`
  - `/oauth/authorize`
  - `/oauth/token`
  - `/oauth/userinfo`

---
_created_at: 2026-01-25_
