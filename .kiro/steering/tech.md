# Technology Stack

- Rails 8.x 系の Web アプリケーション
- OpenID Connect Provider としての認証基盤

# Architecture

- モノリシックRailsアプリケーション
- フルスタック（Hotwire: Turbo + Stimulus）
- SSR + 従来型MVC

# Core Technologies

- 言語:
  - Ruby 3.x
- フレームワーク:
  - Rails 8.0.2
- データベース:
  - MySQL 8.0
- キャッシュ/セッション:
  - Redis

# Key Libraries

- 認証:
  - Devise（ユーザー認証）
  - Doorkeeper（OAuth 2.0）
  - doorkeeper-openid_connect（OIDC拡張）
- フロントエンド:
  - Hotwire（Turbo, Stimulus）
  - Propshaft（アセット管理）
  - Importmap（JSモジュール）
- バックグラウンド:
  - Solid Queue / Solid Cache / Solid Cable

# Development Standards

## コード品質

- RuboCop:
  - rubocop-rails
  - rubocop-performance
  - rubocop-rspec

## テスト

- RSpec（テストフレームワーク）
- FactoryBot（テストデータ）
- Capybara + Selenium（E2E）
- Shoulda Matchers（マッチャー拡張）

# Development Environment

## 必須ツール

- Docker / Docker Compose
- OpenSSL（秘密鍵生成）
- mkcert（ローカル証明書）

## コンテナ構成

| サービス | 用途 |
| --- | --- |
| nginx | リバースプロキシ |
| backend | Rails アプリケーション |
| backend-db | MySQL |
| backend-redis | Redis |

## 主要コマンド

```bash
# コンテナ起動
just up

# コンテナ停止
just down

# テスト実行
docker compose run --rm backend rspec

# Rails コンソール
docker compose run --rm backend rails c
```

# Key Technical Decisions

- セッション管理:
  - Redis Session Store 使用
  - サーバーサイドセッション
- トークン設定:
  - Access Token: 2時間有効
  - ID Token: 10分有効
  - Refresh Token: 有効
  - reuse_access_token: 有効
- HTTPS強制:
  - リダイレクトURIはHTTPS必須
  - ローカル開発もHTTPS（mkcert）
- 認可スキップ:
  - 信頼されたアプリケーションとして認可画面をスキップ

---
_created_at: 2026-01-25_
