# Coding Style & Quality Standards

コード品質の基準としきい値。プロセス（レビュー手順、リファクタリングパターン）は対応するスキルを参照。

## 命名規則

### Variables & Functions
- Use descriptive, clear names
- camelCase for variables and functions
- Avoid abbreviations unless standard (e.g., API, URL)

### Classes & Components
- PascalCase
- Noun-based names

### Constants
- UPPER_SNAKE_CASE
- Descriptive, not abbreviated

### Boolean Variables
- Prefix with `is`, `has`, `should`, `can`
- Examples: `isValid`, `hasPermission`, `shouldRetry`

## 禁止事項

### Magic Numbers

```javascript
// ❌ Don't allow
if (status === 3) { }

// ✅ Require
const STATUS_APPROVED = 3
if (status === STATUS_APPROVED) { }
```

### Duplicate Code

```javascript
// ❌ Don't allow (3+ instances)
function formatUserName(user) {
  return user.firstName + " " + user.lastName
}
function formatAdminName(admin) {
  return admin.firstName + " " + admin.lastName
}

// ✅ Require
function formatFullName(person) {
  return person.firstName + " " + person.lastName
}
```

### Deep Nesting

```javascript
// ❌ Don't allow (>3 levels)
if (a) {
  if (b) {
    if (c) {
      if (d) { }
    }
  }
}

// ✅ Require guard clauses
if (!a) return
if (!b) return
if (!c) return
if (d) { }
```

### God Objects

```javascript
// ❌ Don't allow classes doing everything
class UserManager {
  createUser() { }
  sendEmail() { }
  formatDate() { }
  calculateTax() { }
}

// ✅ Require separated responsibilities
class UserService { }
class EmailService { }
```

## コード品質しきい値

| Metric | Warning | Must Fix |
|--------|---------|----------|
| Function size | > 30 lines | > 50 lines |
| Cyclomatic complexity | > 10 | > 15 |
| Class methods | > 10 | > 15 |
| Code duplication | 2 instances | 3+ instances |
| Parameter count | > 3 | > 5 |

## リファクタリング基準

### 前提条件

- テストカバレッジ 80%+ 必須
- 全テスト通過状態で開始
- リファクタリングと機能追加は別コミット

### 禁止事項

```text
❌ Never: Refactor without tests
❌ Never: Mix refactoring with feature changes
❌ Never: Large, sweeping changes in one commit
```

> リファクタリングパターンと手順は `skills/refactoring` を参照

## コードレビュー基準

### チェック項目

1. **Correctness** - Logic, edge cases, error handling
2. **Performance** - N+1, unnecessary loops, data structures
3. **Maintainability** - Readability, naming, single responsibility
4. **Documentation** - Complex logic comments, public API docs

### 重大度

| Level | 基準 | 対応 |
|-------|------|------|
| CRITICAL | Production failure, security, data loss | Must fix |
| HIGH | Bug, performance, best practice violation | Strongly fix |
| MEDIUM | Code quality, readability | Recommend fix |
| LOW | Style, minor improvements | Consider |

### 承認基準

| 重大度 | 承認 |
|--------|------|
| CRITICAL/HIGH | ❌ Block |
| MEDIUM only | ⚠️ Conditional |
| LOW only | ✅ Approve |

> レビュープロセスと出力フォーマットは `skills/code-review` を参照

## Immutability

```text
✅ ALWAYS use const by default
⚠️ Use let only when reassignment is needed
❌ NEVER use var
```

## Error Handling

```javascript
// ✅ Always provide context
throw new Error(`Failed to process order ${orderId}: ${reason}`)

// ❌ Never throw generic errors
throw new Error('Error')
```

## Input Validation

```javascript
// ✅ Always validate at boundaries
function processUser(user) {
  if (!user || !user.email) {
    throw new Error('Invalid user data')
  }
}

// ❌ Never trust input
function processUser(user) {
  sendEmail(user.email)  // Assumes existence
}
```

## 注意事項

### Over-Refactoring
- Refactor for perfection → Stop when clean enough
- Abstractions for single use → Extract only when reused

### Premature Optimization
- Optimize without measurements → Profile first
- Sacrifice readability → Readability first

### Breaking API Compatibility
- Change public APIs without versioning
- Remove methods without deprecation
