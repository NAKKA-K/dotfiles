# Security Standards - Full Raw Content

セキュリティ基準（OWASP Top 10ベース）。スキャン手順と検証プロセスは `skills/security-review` を参照。

## OWASP Top 10 チェックリスト

### A01: Broken Access Control
- Authorization checks on all endpoints
- No direct object reference exposure
- Rate limiting implemented
- CORS properly configured
- Directory traversal prevention

### A02: Cryptographic Failures
- Data encrypted in transit (TLS)
- Data encrypted at rest
- Strong algorithms (no MD5, SHA1 for security)
- Proper key management
- No sensitive data in logs/errors

### A03: Injection
- Parameterized queries (SQL)
- Input validation and sanitization
- Output encoding
- Command injection prevention
- Template injection prevention

### A04: Insecure Design
- Threat modeling performed
- Security requirements defined
- Secure architecture patterns
- Business logic abuse prevention

### A05: Security Misconfiguration
- Default credentials changed
- Unnecessary features disabled
- Error messages don't leak info
- Security headers configured
- Dependencies up to date

### A06: Vulnerable Components
- Dependencies scanned for CVEs
- No outdated libraries
- Minimal dependency footprint
- License compliance

### A07: Authentication Failures
- Strong password policy
- Brute force protection
- Secure session management
- MFA support (if applicable)
- Secure password storage (bcrypt, argon2)

### A08: Data Integrity Failures
- Signed updates/downloads
- CI/CD pipeline security
- Deserialization safety
- Integrity verification

### A09: Logging & Monitoring Failures
- Security events logged
- No sensitive data in logs
- Log integrity protected
- Alerting configured

### A10: Server-Side Request Forgery (SSRF)
- URL validation
- Allowlist for external requests
- Internal network access blocked
- Response handling secured

## 禁止事項

### Secrets in Code

```javascript
// ❌ Never allow
const apiKey = "sk-abc123"
const password = "password123"

// ✅ Require
const apiKey = process.env.API_KEY
const password = process.env.DB_PASSWORD
```

### Weak Cryptography

```python
# ❌ Never allow
password_hash = hashlib.md5(password.encode()).hexdigest()

# ✅ Require
password_hash = bcrypt.hashpw(password.encode(), bcrypt.gensalt())
```

### SQL Injection

```javascript
// ❌ Never allow
const query = "SELECT * FROM users WHERE id = " + userId

// ✅ Require
const query = "SELECT * FROM users WHERE id = ?"
db.execute(query, [userId])
```

### Unvalidated Input

```javascript
// ❌ Never allow
app.get('/user/:id', (req, res) => {
  const user = db.getUser(req.params.id)
  res.send(user)
})

// ✅ Require
app.get('/user/:id', (req, res) => {
  const id = parseInt(req.params.id)
  if (!id || id < 1) return res.status(400).send('Invalid ID')
  const user = db.getUser(id)
  res.send(user)
})
```

## 必須セキュリティヘッダー

すべての Web アプリケーションで設定必須：

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
| CRITICAL | ❌ Block deployment |
| HIGH | ❌ Block deployment |
| MEDIUM (> 5) | ⚠️ Require plan |
| LOW | ✅ Can deploy |

### Zero Tolerance（1つでもあればブロック）

- Hardcoded credentials
- SQL injection vulnerabilities
- Command injection vulnerabilities
- Authentication bypass
- Data exposure without encryption
- Missing critical security headers

## セキュリティ対応プロトコル

セキュリティ問題発見時：

1. **STOP** - 即座に作業停止
2. **Review** - `skills/security-review` でスキャン
3. **Fix** - CRITICAL を最優先で修正
4. **Rotate** - 露出したシークレットをローテーション
5. **Audit** - 類似問題がないかコードベース全体を確認
