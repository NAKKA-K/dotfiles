# セキュリティ基準 - フル原文

セキュリティ基準（OWASP Top 10ベース）。スキャン手順と検証プロセスは `skills/security-review` を参照。

## OWASP Top 10 チェックリスト

### A01: アクセス制御の不備（Broken Access Control）

- すべてのエンドポイントで認可チェックを行う
- direct object reference を露出させない
- rate limiting を実装する
- CORS を適切に設定する
- ディレクトリトラバーサルを防止する

### A02: 暗号化の失敗（Cryptographic Failures）

- 通信中のデータを暗号化する（TLS）
- 保存データを暗号化する
- 強度の高いアルゴリズムを使う（セキュリティ用途で MD5、SHA1 を使わない）
- 適切な鍵管理を行う
- ログ・エラーに機密データを含めない

### A03: インジェクション（Injection）

- パラメータ化クエリ（SQL）を使う
- 入力検証とサニタイズを行う
- 出力エンコーディングを行う
- コマンドインジェクションを防止する
- テンプレートインジェクションを防止する

### A04: 安全でない設計（Insecure Design）

- 脅威モデリングを実施する
- セキュリティ要件を定義する
- セキュアなアーキテクチャパターンを使う
- ビジネスロジックの悪用を防止する

### A05: セキュリティの誤設定（Security Misconfiguration）

- デフォルト認証情報を変更する
- 不要な機能を無効化する
- エラーメッセージで情報を漏らさない
- セキュリティヘッダーを設定する
- 依存関係を最新に保つ

### A06: 脆弱なコンポーネント（Vulnerable Components）

- 依存関係を CVE スキャンする
- 古いライブラリを使わない
- 依存関係を最小限にする
- ライセンスを遵守する

### A07: 認証の失敗（Authentication Failures）

- 強固なパスワードポリシーを設ける
- ブルートフォース対策を行う
- セキュアなセッション管理を行う
- 必要に応じて MFA をサポートする
- セキュアにパスワードを保存する（bcrypt、argon2）

### A08: データ整合性の失敗（Data Integrity Failures）

- 署名付きアップデート・ダウンロードを使う
- CI/CD パイプラインのセキュリティを確保する
- デシリアライズの安全性を確保する
- 整合性検証を行う

### A09: ロギング・監視の失敗（Logging & Monitoring Failures）

- セキュリティイベントをログに記録する
- ログに機密データを含めない
- ログの完全性を保護する
- アラートを設定する

### A10: SSRF（Server-Side Request Forgery）

- URL を検証する
- 外部リクエストの allowlist を設ける
- 内部ネットワークへのアクセスをブロックする
- レスポンス処理をセキュアにする

## 禁止事項

### コード内のシークレット

```javascript
// ❌ 禁止
const apiKey = "sk-abc123"
const password = "password123"

// ✅ 必須
const apiKey = process.env.API_KEY
const password = process.env.DB_PASSWORD
```

### 弱い暗号化

```python
# ❌ 禁止
password_hash = hashlib.md5(password.encode()).hexdigest()

# ✅ 必須
password_hash = bcrypt.hashpw(password.encode(), bcrypt.gensalt())
```

### SQL インジェクション

```javascript
// ❌ 禁止
const query = "SELECT * FROM users WHERE id = " + userId

// ✅ 必須
const query = "SELECT * FROM users WHERE id = ?"
db.execute(query, [userId])
```

### 未検証の入力

```javascript
// ❌ 禁止
app.get('/user/:id', (req, res) => {
  const user = db.getUser(req.params.id)
  res.send(user)
})

// ✅ 必須
app.get('/user/:id', (req, res) => {
  const id = parseInt(req.params.id)
  if (!id || id < 1) return res.status(400).send('Invalid ID')
  const user = db.getUser(id)
  res.send(user)
})
```

## 必須セキュリティヘッダー

すべての Web アプリケーションで設定必須。

```text
Content-Security-Policy: default-src 'self'
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-XSS-Protection: 1; mode=block
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), microphone=()
```

## 承認基準

### 重大度別判断

| Severity | Action |
|----------|--------|
| CRITICAL | ❌ デプロイをブロック |
| HIGH | ❌ デプロイをブロック |
| MEDIUM (> 5) | ⚠️ 計画を要求 |
| LOW | ✅ デプロイ可 |

### Zero Tolerance（1つでもあればブロック）

- ハードコードされた認証情報
- SQL インジェクション脆弱性
- コマンドインジェクション脆弱性
- 認証バイパス
- 暗号化されていないデータの露出
- クリティカルなセキュリティヘッダーの欠落

## セキュリティ対応プロトコル

セキュリティ問題発見時。

1. **STOP** - 即座に作業停止
2. **Review** - `skills/security-review` でスキャン
3. **Fix** - CRITICAL を最優先で修正
4. **Rotate** - 露出したシークレットをローテーション
5. **Audit** - 類似問題がないかコードベース全体を確認
