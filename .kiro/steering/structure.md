# Project Structure

- 標準的なRails構成をベースにしたOpenID Connect Provider

# Organization Philosophy

- Rails標準ディレクトリ構成:
  - Convention over Configuration
  - Railsのデフォルトに従う
- 機能追加はGemベース:
  - Devise、Doorkeeper等の標準的なGemを利用
  - カスタマイズはinitializerで設定

# Directory Patterns

## アプリケーションコード (`volumes/backend/app/`)

- Rails標準MVC構成

### Controllers

- 場所: `app/controllers/`
- パターン:
  - ApplicationController をベースに継承
  - Devise コントローラーの拡張はパラメータサニタイザーで対応

### Models

- 場所: `app/models/`
- パターン:
  - ApplicationRecord を継承
  - Devise モジュールを User モデルに include

### Views

- 場所: `app/views/`
- パターン:
  - Devise テンプレートをカスタマイズ
  - レイアウトは `layouts/application.html.erb`

## 設定 (`volumes/backend/config/`)

- 場所: `config/initializers/`
- 重要ファイル:
  - `devise.rb`: ユーザー認証設定
  - `doorkeeper.rb`: OAuth 2.0 設定
  - `doorkeeper_openid_connect.rb`: OIDC 設定
  - `session_store.rb`: Redis セッション設定

## 証明書 (`volumes/backend/certs/`)

- 場所: `certs/`
- 用途:
  - OIDC 署名用秘密鍵（`private.pem`）
- 注意:
  - `.gitignore` 対象
  - セットアップ時に生成

## Docker設定

- 場所: `containers/`
- パターン:
  - `Dockerfile`: 開発用
  - `Dockerfile.prod`: 本番用
  - `scripts/`: エントリーポイントスクリプト

# Naming Conventions

- ファイル:
  - snake_case（Rails標準）
- クラス:
  - PascalCase
- メソッド/変数:
  - snake_case
- ルーティング:
  - RESTful（Devise/Doorkeeper 提供）

# Import Organization

- Rails autoload / zeitwerk を使用
- 明示的な require は不要（標準パスの場合）

# Code Organization Principles

- Gem優先:
  - 機能追加は既存Gemの設定で対応
  - カスタムコードは最小限に
- 設定ファイルでの拡張:
  - initializer でGemの挙動をカスタマイズ
- テンプレート上書き:
  - Devise ビューは `app/views/devise/` で上書き

---
_created_at: 2026-01-25_
