---
name: refactoring
description: コードのリファクタリング指針、デッドコード検出、技術的負債の解消。次のような場合に使用する。method/function が 30 行を超える、class のメソッドが 10 を超える、コードの重複が検出された（3 箇所以上）、循環的複雑度が 10 を超える、技術的負債のクリーンアップが要求された、レガシーコードのモダナイズが必要。
---

# Refactoring Skill

挙動を保ちながらコード構造を改善するための体系的なアプローチ。

## 安全のための前提条件

リファクタリング前に必ず確認する。

- [ ] テストが存在し、合格している（カバレッジ 80% 超）
- [ ] 変更による影響範囲を理解している
- [ ] ロールバック可能（現状をコミット済み）
- [ ] 時間的な余裕がある（締切直前は避ける）

## よくあるリファクタリングパターン

### Extract Method/Function

**適用条件**: メソッドが 20 〜 30 行を超え、論理ブロックに意味のある名前を付けられる場合。

```text
Before:
def process_order(order):
    # validation logic (10 lines)
    # calculation logic (15 lines)
    # save logic (10 lines)

After:
def process_order(order):
    validate_order(order)
    total = calculate_total(order)
    save_order(order, total)
```

### Extract Class/Module

**適用条件**: クラスのメソッド数が 10 〜 15 を超え、同じデータを扱う明確なサブセットがある場合。

```text
Before:
class User:
    def save()
    def validate()
    def send_email()
    def format_name()

After:
class User:
    def save()
    def validate()

class UserMailer:
    def send_email()

class UserFormatter:
    def format_name()
```

### Replace Nested Conditionals with Guard Clauses

**適用条件**: if 文が複数階層にネストしている場合。

```text
Before:
if valid:
    if authorized:
        if has_stock:
            process()

After:
if not valid: return
if not authorized: return
if not has_stock: return
process()
```

### Inline Method

**適用条件**: メソッド本体がメソッド名と同程度に明快で、呼び出しが 1 箇所のみの場合。

```text
Before:
def get_rating():
    return more_than_five_late_deliveries()

def more_than_five_late_deliveries():
    return self.late_deliveries > 5

After:
def get_rating():
    return self.late_deliveries > 5
```

### Replace Conditional with Polymorphism

**適用条件**: オブジェクトの型に対する switch / if-else があり、同じパターンが繰り返されている場合。

```text
Before:
if type == "dog":
    make_bark_sound()
elif type == "cat":
    make_meow_sound()

After:
class Dog:
    def make_sound(): return "bark"

class Cat:
    def make_sound(): return "meow"

animal.make_sound()
```

## コードスメルの検出

### Bloaters（肥大化）

| Smell | しきい値 |
|-------|----------|
| Long Method | 30 行超 |
| Large Class | 15 メソッド超 |
| Long Parameter List | 引数 4 超 |
| Primitive Obsession | 関連データが構造化されていない |

### Couplers（結合）

| Smell | 兆候 |
|-------|------|
| Feature Envy | 内部より外部参照が多い |
| Inappropriate Intimacy | private／internal にアクセスしている |
| Message Chains | a.b().c().d() |

### Dispensables（不要物）

| Smell | 兆候 |
|-------|------|
| Dead Code | 呼び出し元がない |
| Duplicate Code | 同じロジックが 3 箇所以上 |
| Speculative Generality | 使われていない抽象化 |

## デッドコード検出

### 検索パターン

```bash
# 未使用の関数・メソッドを検出
grep -r "def function_name" --include="*.py"
grep -r "function_name(" --include="*.py"

# 静的解析ツールを利用する
# TypeScript: ts-prune
# JavaScript: knip, depcheck
# Python: vulture
```

### 安全な削除手順

1. 利用箇所を検索する（Grep／Glob）
2. テストでの参照を確認する
3. 動的呼び出し（リフレクション等）を確認する
4. 削除候補としてマークする（TODO／DEPRECATED）
5. 確認後に削除する
6. テスト実行で検証する

## リファクタリングのワークフロー

### Phase 1: 現状把握

```bash
# 静的解析の実行
npx ts-prune  # TypeScript のデッドコード
npx knip      # 未使用の依存／エクスポート

# 複雑度の確認
npx eslint --rule 'complexity: ["error", 10]' src/
```

### Phase 2: 計画

以下を含むリファクタリング計画を作成する。

- 対象ファイルと具体的な変更内容
- リスクレベル（Low／Medium／High）
- 変更前後で必要なテスト
- ロールバック手順

### Phase 3: 実行

1. 1 度に 1 件ずつリファクタリングする
2. 各変更の後にテストを実行する
3. 各変更が成功するごとにコミットする
4. 機能変更とリファクタリングを混ぜない

### Phase 4: 検証

- [ ] 全テスト合格
- [ ] パフォーマンス低下なし
- [ ] 新しい warning／error なし
- [ ] 必要に応じてドキュメントを更新

## 出力フォーマット

### Refactoring Report

```markdown
# Refactoring Report: [TARGET]

## Current State
- Total Lines: X
- Avg Method Length: X lines
- Max Method Length: X lines
- Cyclomatic Complexity: X

## Code Smells Detected
| Smell | Location | Severity |
|-------|----------|----------|
| Long Method | file:line | High |

## Refactoring Plan

### Phase 1: Quick Wins (Low Risk)
1. `processOrder` から `validateOrder` を抽出 (file:line)
   - Pattern: Extract Method
   - Tests Required: order.test.ts

### Phase 2: Structural Changes (Medium Risk)
...

## Dead Code Candidates
| Code | Location | Confidence |
|------|----------|------------|
| unusedHelper | utils.ts:42 | High |

## Estimated Impact
- Lines Removed: X
- Complexity Reduction: X%
```

## 避けるべきアンチパターン

### 過剰なリファクタリング

- 完璧を求めたリファクタリング
- 一度しか使わない抽象化を作る
- 「エレガンス」のために可読性を犠牲にする

### 早すぎる最適化

- 計測なしの最適化
- パフォーマンスのために可読性を犠牲にする

### 破壊的変更

- バージョニングなしの公開 API 変更
- deprecation なしの公開メソッド削除

## 参照

コード品質のしきい値と承認基準は `~/.claude/rules/coding-style.md` を参照。
