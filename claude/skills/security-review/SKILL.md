---
name: security-review
description: OWASP Top 10 に基づくセキュリティ脆弱性の検出とレビュー。次のような場合に使用する。認証・認可の実装、ユーザー入力やファイルアップロードの取り扱い、API エンドポイントの作成、シークレット・認証情報の取り扱い、決済機能の実装、機密データの保存・送信、サードパーティ API との統合、コード変更を確定する前。
---

# Security Review Skill

OWASP Top 10 に基づき、コードのセキュリティ脆弱性を体系的にレビューする。

## 実行手順

### Step 1: スコープを特定する

```bash
# 関連するソースファイルをリストアップ
find . -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.py" \) \
  -not -path "*/node_modules/*" -not -path "*/.git/*" | head -50

# env ファイルと gitignore を確認
ls -la .env* 2>/dev/null || true
grep -E "(env|secret|key)" .gitignore 2>/dev/null || true
```

### Step 2: ハードコードされたシークレットをスキャンする (A02)

```bash
# ハードコードされたシークレットを検索
grep -rn --include="*.ts" --include="*.js" --include="*.py" \
  -E "(password|secret|token|api_key|private_key)\s*[=:]\s*['\"][^'\"]+['\"]" . \
  --exclude-dir={node_modules,.git,dist,build}
```

### Step 3: インジェクション脆弱性を検出する (A03)

```bash
# SQL の文字列連結
grep -rn --include="*.ts" --include="*.js" --include="*.py" \
  -E "(SELECT|INSERT|UPDATE|DELETE).*\+" . \
  --exclude-dir={node_modules,.git,dist,build}

# コマンドインジェクションのパターン
grep -rn --include="*.ts" --include="*.js" --include="*.py" \
  -E "(exec|spawn|system|eval)\(" . \
  --exclude-dir={node_modules,.git,dist,build}
```

### Step 4: 認証を確認する (A01, A07)

```bash
# 認証関連ファイルを探す
find . -type f \( -name "*auth*" -o -name "*login*" -o -name "*session*" \) \
  -not -path "*/node_modules/*"

# localStorage に保存されているトークン（XSS 脆弱性）
grep -rn --include="*.ts" --include="*.tsx" --include="*.js" \
  -E "localStorage\.(set|get)Item.*token" . \
  --exclude-dir={node_modules,.git,dist,build}
```

### Step 5: 依存関係を確認する (A06)

```bash
# npm/yarn
npm audit --json 2>/dev/null || yarn audit --json 2>/dev/null || true

# Python
pip-audit 2>/dev/null || safety check 2>/dev/null || true
```

## OWASP Top 10 チェックリスト

### A01: アクセス制御の不備（Broken Access Control）

- [ ] すべてのエンドポイントで認可を行う
- [ ] direct object reference を露出させない
- [ ] rate limiting を実装する
- [ ] CORS を適切に設定する

### A02: 暗号化の失敗（Cryptographic Failures）

- [ ] ハードコードされたシークレットがない
- [ ] シークレットを環境変数で管理する
- [ ] 強度の高いアルゴリズムを使う（セキュリティ用途で MD5／SHA1 を使わない）
- [ ] ログに機密データを含めない

### A03: インジェクション（Injection）

- [ ] パラメータ化クエリを使う
- [ ] 入力検証を行う
- [ ] 出力エンコーディングを行う
- [ ] コマンドインジェクションがない

### A05: セキュリティの誤設定（Security Misconfiguration）

- [ ] セキュリティヘッダーを設定する
- [ ] エラーメッセージで情報を漏らさない
- [ ] 本番では debug モードを無効化する

### A07: 認証の失敗（Authentication Failures）

- [ ] httpOnly cookie にトークンを保存する
- [ ] 強度の高いパスワードハッシュを使う
- [ ] ブルートフォース対策を行う

### A09: ロギングの失敗（Logging Failures）

- [ ] ログに機密データを含めない
- [ ] セキュリティイベントをログに記録する

### A10: SSRF

- [ ] URL を検証する
- [ ] 外部ホストの allowlist を設ける

## 入力検証パターン

### TypeScript (Zod)

```typescript
import { z } from 'zod'

const CreateUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1).max(100),
  age: z.number().int().min(0).max(150),
})

const validated = CreateUserSchema.parse(input)
```

### Python (Pydantic)

```python
from pydantic import BaseModel, EmailStr, conint, constr

class CreateUserRequest(BaseModel):
    email: EmailStr
    name: constr(min_length=1, max_length=100)
    age: conint(ge=0, le=150)
```

## 出力フォーマット

```text
[SEVERITY] 脆弱性のタイトル
File: path/to/file.ext:line
Category: OWASP カテゴリ（例: A03:Injection）
Issue: 脆弱性の説明
Risk: 悪用された場合の影響
Fix: 修正手順
<vulnerable code>  // BAD
<secure code>      // GOOD
```

### 重大度レベル

- **CRITICAL**: 実際に悪用可能、即時のリスク
- **HIGH**: ある程度の労力で悪用可能、影響大
- **MEDIUM**: 悪用可能性または影響が限定的
- **LOW**: 軽微な問題、多層防御の観点

## デプロイ前チェックリスト

- [ ] ハードコードされたシークレットがない
- [ ] すべてのユーザー入力を検証している
- [ ] SQL クエリがパラメータ化されている
- [ ] ユーザー由来のコンテンツがサニタイズされている
- [ ] CSRF 対策が有効になっている
- [ ] httpOnly cookie にトークンを保存している
- [ ] 認可チェックが実装されている
- [ ] rate limiting が有効になっている
- [ ] HTTPS が強制されている
- [ ] セキュリティヘッダーが設定されている
- [ ] エラーメッセージに機密データが含まれていない
- [ ] ログに機密データが含まれていない
- [ ] 既知の脆弱性を持つ依存関係がない

## 参照

セキュリティ基準と検出パターンは `~/.claude/rules/security.md` を参照。
