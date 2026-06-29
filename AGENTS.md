# 基本ルール

## エージェント設定

- Rules は `.rulesync/rules/` を正本とし、rulesync で管理する（`rulesync generate` で `.cursor/rules/`、`AGENTS.md`、`CLAUDE.md` などへ展開）。生成物は直接編集しない。
- Rules を変更するときは `.rulesync/rules/` を修正してから `rulesync generate` を実行する。
- 正本と生成物が矛盾する場合は `.rulesync/` を正とする。

## 実装方針

- OpenID Connect Provider としての責務を崩さず、認証・認可基盤に閉じた変更に留める。
- 変更は必要最小限にし、既存の Rails / Docker Compose / justfile の運用に合わせる。
- 認証・トークン・セッション・秘密鍵まわりの変更では、影響範囲と安全性を先に確認する。

## 開発ワークフロー

### 開発・運用環境

- 開発環境は Docker Compose を基本とする。
- 本番環境は自宅 Kubernetes（Master 1 / Worker 3）を利用する。
- CI/CD は GitHub Actions と ArgoCD の GitOps で運用する。

### ローカル開発ワークフロー

1. 秘密鍵とローカル証明書を作成する。
2. ループバックエイリアスと `/etc/hosts` を設定する。
3. `docker compose build` でイメージを準備する。
4. `just up` でコンテナを起動する。
5. `just ps` と `just logs` で状態を確認する。
6. 実装・修正は OIDC Provider の責務境界を維持して行う。
7. 変更範囲に応じてテストやコンソール確認を行う。
8. 作業後は `just down` で停止する。

### 主要コマンド

- `just up`: Docker Compose の全サービスをバックグラウンド起動
- `just down`: Docker Compose の全サービス停止
- `just ps`: コンテナ稼働状態の確認
- `just logs`: 全サービスのログをフォロー表示
- `just restart-all`: 全サービスを再起動
- `just restart <container-name>`: 指定コンテナのみ再起動
- `just attach <container-name>`: 指定コンテナにアタッチ
- `just rspec`: `spring` コンテナ経由で RSpec 実行
- `docker compose run --rm backend rails c`: Rails コンソール起動
- `docker compose run --rm backend rails db:migrate`: マイグレーション実行

### 実装時の判断基準

- まず `just ps` で実行環境を確認し、未起動なら `just up` を優先する。
- 不具合調査は `just logs` で事実確認してから修正に入る。
- Rails や RSpec などのコマンドはホストではなく Docker コンテナ経由で実行する。
- OIDC の endpoint、token、scope、session に影響する変更では relying party との整合を確認する。
- 秘密鍵、証明書、認証情報は生成手順と保管場所を崩さない。

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
