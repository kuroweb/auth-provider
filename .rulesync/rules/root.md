---
root: true
targets: ["*"]
description: "auth-provider の基本ルール"
globs: ["**/*"]
---

# 基本ルール

## エージェント設定

- Rules は `.rulesync/rules/` を正本とし、rulesync で管理する（`rulesync generate` で `.cursor/rules/`、`AGENTS.md`、`CLAUDE.md` などへ展開）。生成物は直接編集しない。
- Rules を変更するときは `.rulesync/rules/` を修正してから `rulesync generate` を実行する。
- 正本と生成物が矛盾する場合は `.rulesync/` を正とする。

## 実装方針

- OpenID Connect Provider としての責務を崩さず、認証・認可基盤に閉じた変更に留める。
- 変更は必要最小限にし、既存の Rails / Docker Compose / justfile の運用に合わせる。
- 認証・トークン・セッション・秘密鍵まわりの変更では、影響範囲と安全性を先に確認する。
