---
name: security-review
description: Security vulnerability detection and review based on OWASP Top 10. Use when implementing authentication/authorization, handling user input or file uploads, creating API endpoints, working with secrets/credentials, implementing payment features, storing/transmitting sensitive data, integrating third-party APIs, or before finalizing any code changes.
---

# Security Review Skill

Systematically review code for security vulnerabilities based on OWASP Top 10.

## Execution Procedure

### Step 1: Identify Scope

```bash
# List relevant source files
find . -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.py" \) \
  -not -path "*/node_modules/*" -not -path "*/.git/*" | head -50

# Check for env files and gitignore
ls -la .env* 2>/dev/null || true
grep -E "(env|secret|key)" .gitignore 2>/dev/null || true
```

### Step 2: Scan for Hardcoded Secrets (A02)

```bash
# Search for hardcoded secrets
grep -rn --include="*.ts" --include="*.js" --include="*.py" \
  -E "(password|secret|token|api_key|private_key)\s*[=:]\s*['\"][^'\"]+['\"]" . \
  --exclude-dir={node_modules,.git,dist,build}
```

### Step 3: Detect Injection Vulnerabilities (A03)

```bash
# SQL string concatenation
grep -rn --include="*.ts" --include="*.js" --include="*.py" \
  -E "(SELECT|INSERT|UPDATE|DELETE).*\+" . \
  --exclude-dir={node_modules,.git,dist,build}

# Command injection patterns
grep -rn --include="*.ts" --include="*.js" --include="*.py" \
  -E "(exec|spawn|system|eval)\(" . \
  --exclude-dir={node_modules,.git,dist,build}
```

### Step 4: Check Authentication (A01, A07)

```bash
# Find auth-related files
find . -type f \( -name "*auth*" -o -name "*login*" -o -name "*session*" \) \
  -not -path "*/node_modules/*"

# Token storage in localStorage (XSS vulnerable)
grep -rn --include="*.ts" --include="*.tsx" --include="*.js" \
  -E "localStorage\.(set|get)Item.*token" . \
  --exclude-dir={node_modules,.git,dist,build}
```

### Step 5: Check Dependencies (A06)

```bash
# npm/yarn
npm audit --json 2>/dev/null || yarn audit --json 2>/dev/null || true

# Python
pip-audit 2>/dev/null || safety check 2>/dev/null || true
```

## OWASP Top 10 Checklist

### A01: Broken Access Control

- [ ] Authorization on all endpoints
- [ ] No direct object reference exposure
- [ ] Rate limiting implemented
- [ ] CORS properly configured

### A02: Cryptographic Failures

- [ ] No hardcoded secrets
- [ ] Secrets in environment variables
- [ ] Strong algorithms (no MD5/SHA1 for security)
- [ ] No sensitive data in logs

### A03: Injection

- [ ] Parameterized queries
- [ ] Input validation
- [ ] Output encoding
- [ ] No command injection

### A05: Security Misconfiguration

- [ ] Security headers configured
- [ ] Error messages don't leak info
- [ ] Debug mode disabled in production

### A07: Authentication Failures

- [ ] Tokens in httpOnly cookies
- [ ] Strong password hashing
- [ ] Brute force protection

### A09: Logging Failures

- [ ] No sensitive data in logs
- [ ] Security events logged

### A10: SSRF

- [ ] URL validation
- [ ] Allowlist for external hosts

## Input Validation Patterns

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

## Output Format

```text
[SEVERITY] Vulnerability title
File: path/to/file.ext:line
Category: OWASP category (e.g., A03:Injection)
Issue: Description of the vulnerability
Risk: Potential impact if exploited
Fix: Remediation steps
<vulnerable code>  // BAD
<secure code>      // GOOD
```

### Severity Levels

- **CRITICAL**: Actively exploitable, immediate risk
- **HIGH**: Exploitable with some effort, significant impact
- **MEDIUM**: Limited exploitability or impact
- **LOW**: Minor issue, defense in depth

## Pre-Deployment Checklist

- [ ] No hardcoded secrets
- [ ] All user inputs validated
- [ ] SQL queries parameterized
- [ ] User content sanitized
- [ ] CSRF protection enabled
- [ ] Tokens in httpOnly cookies
- [ ] Authorization checks implemented
- [ ] Rate limiting enabled
- [ ] HTTPS enforced
- [ ] Security headers configured
- [ ] No sensitive data in error messages
- [ ] No sensitive data in logs
- [ ] Dependencies have no known vulnerabilities

## Reference

For security standards and detection patterns, see `~/.claude/rules/security.md`.
