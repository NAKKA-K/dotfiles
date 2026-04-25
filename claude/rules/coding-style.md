# コーディングスタイル・品質基準

コード品質の基準としきい値。プロセス（レビュー手順、リファクタリングパターン）は対応するスキルを参照。

## 命名規則

### 変数・関数

- 説明的で明確な名前を使う
- 変数・関数は camelCase
- 標準的な略語（API、URL など）以外の略語は避ける

### クラス・コンポーネント

- PascalCase
- 名詞ベースの名前

### 定数

- UPPER_SNAKE_CASE
- 説明的にし、略さない

### Boolean 変数

- `is`、`has`、`should`、`can` を接頭辞に付ける
- 例: `isValid`、`hasPermission`、`shouldRetry`

## 禁止事項

### マジックナンバー

```javascript
// ❌ 禁止
if (status === 3) { }

// ✅ 必須
const STATUS_APPROVED = 3
if (status === STATUS_APPROVED) { }
```

### 重複コード

```javascript
// ❌ 禁止（3 箇所以上の重複）
function formatUserName(user) {
  return user.firstName + " " + user.lastName
}
function formatAdminName(admin) {
  return admin.firstName + " " + admin.lastName
}

// ✅ 必須
function formatFullName(person) {
  return person.firstName + " " + person.lastName
}
```

### 深いネスト

```javascript
// ❌ 禁止（3 階層を超えるネスト）
if (a) {
  if (b) {
    if (c) {
      if (d) { }
    }
  }
}

// ✅ guard clause を必須とする
if (!a) return
if (!b) return
if (!c) return
if (d) { }
```

### God Object

```javascript
// ❌ すべての責務を抱え込むクラスは禁止
class UserManager {
  createUser() { }
  sendEmail() { }
  formatDate() { }
  calculateTax() { }
}

// ✅ 責務を分離する
class UserService { }
class EmailService { }
```

## コード品質しきい値

| 指標 | 警告 | 必修正 |
|------|------|--------|
| 関数のサイズ | 30 行超 | 50 行超 |
| 循環的複雑度 | 10 超 | 15 超 |
| クラスのメソッド数 | 10 超 | 15 超 |
| コード重複 | 2 箇所 | 3 箇所以上 |
| 引数の数 | 3 超 | 5 超 |

## リファクタリング基準

### 前提条件

- テストカバレッジ 80%+ 必須
- 全テスト通過状態で開始
- リファクタリングと機能追加は別コミット

### 禁止事項

```text
❌ Never: テストなしのリファクタリング
❌ Never: リファクタリングと機能変更の混在
❌ Never: 1 コミットで広範囲を一気に変更
```

> リファクタリングパターンと手順は `skills/refactoring` を参照

## コードレビュー基準

### チェック項目

1. **正確性（Correctness）** - ロジック、エッジケース、エラーハンドリング
2. **パフォーマンス（Performance）** - N+1、不要なループ、データ構造
3. **保守性（Maintainability）** - 可読性、命名、単一責務
4. **ドキュメント（Documentation）** - 複雑なロジックへのコメント、公開 API のドキュメント

### 重大度

| Level | 基準 | 対応 |
|-------|------|------|
| CRITICAL | 本番障害、セキュリティ、データ損失 | 必修正 |
| HIGH | バグ、パフォーマンス、ベストプラクティス違反 | 強く修正推奨 |
| MEDIUM | コード品質、可読性 | 修正推奨 |
| LOW | スタイル、軽微な改善 | 検討 |

### 承認基準

| 重大度 | 承認 |
|--------|------|
| CRITICAL/HIGH | ❌ Block |
| MEDIUM のみ | ⚠️ 条件付き |
| LOW のみ | ✅ Approve |

> レビュープロセスと出力フォーマットは `skills/code-review` を参照

## イミュータビリティ

```text
✅ ALWAYS デフォルトで const を使う
⚠️ 再代入が必要な場合のみ let を使う
❌ NEVER var は使わない
```

## エラーハンドリング

```javascript
// ✅ 常にコンテキストを与える
throw new Error(`Failed to process order ${orderId}: ${reason}`)

// ❌ 汎用的なエラーを投げない
throw new Error('Error')
```

## 入力検証

```javascript
// ✅ 境界では必ず検証する
function processUser(user) {
  if (!user || !user.email) {
    throw new Error('Invalid user data')
  }
}

// ❌ 入力を信用しない
function processUser(user) {
  sendEmail(user.email)  // 存在を仮定している
}
```

## 注意事項

### 過剰なリファクタリング

- 完璧を求めたリファクタリング → 十分にきれいになったら止める
- 一度しか使わない抽象化 → 再利用が発生してから抽出する

### 早すぎる最適化

- 計測なしの最適化 → 先にプロファイルを取る
- 可読性を犠牲にする → 可読性を優先する

### API 互換性の破壊

- バージョニングなしに公開 API を変更する
- deprecation なしにメソッドを削除する
