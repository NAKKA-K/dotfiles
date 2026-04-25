# Plan Writing ガイドライン

design-planning スキルの Documentation フェーズ用のリファレンス資料。

## 概要

実装プランは、**コードベースの予備知識もドメイン知識もないエンジニア**が、混乱せずに実行できるように書く。

- 各タスクに必要な情報をすべて含める
- 正確なファイルパス、コード、検証コマンドを提供する
- 2 〜 5 分で完了できる粒度に分割する

> TDD のサイクル、コミット運用、コード品質基準は `~/.claude/rules/` を参照。

## プラン文書のフォーマット

**保存先:** `.local/YYYY-MM-DD-<topic>-plan.md`

### ヘッダ

```markdown
# [機能名] Implementation Plan

**Goal:** [何を作るのか、1 文で]

**Architecture:** [アプローチの概要、2 〜 3 文]

**Tech Stack:** [使用する技術・ライブラリ]

**References:**
- TDD: `~/.claude/rules/testing.md`
- jj: `~/.claude/rules/jj-practice.md`

---
```

### タスク構造

タスクの種類に応じて構造を選ぶ。

#### Type A: 機能実装（TDD）

```markdown
### Task N: [コンポーネント名]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Process:** `~/.claude/rules/testing.md` の TDD サイクルに従う

1. 失敗するテストを書く
2. テストを実行し、失敗することを確認する
3. 最小限の実装を書く
4. テストを実行し、合格することを確認する
5. コミット (`jj describe -m "feat: ..." && jj new`)

**Test Code:**
\`\`\`python
def test_specific_behavior():
    result = function(input)
    assert result == expected
\`\`\`

**Implementation Code:**
\`\`\`python
def function(input):
    return expected
\`\`\`

**Verification:**
Run: `pytest tests/path/test.py::test_name -v`
Expected: PASS
```

#### Type B: 設定／インフラ

```markdown
### Task N: [設定名]

**Files:**
- Modify: `pyproject.toml`

**Steps:**
1. 変更を適用する
2. 挙動を検証する
3. コミットする

**Changes:**
\`\`\`toml
[tool.pytest]
testpaths = ["tests"]
\`\`\`

**Verification:**
Run: `pytest --collect-only`
Expected: tests/ 配下のテストが収集される
```

#### Type C: ドキュメント

```markdown
### Task N: [ドキュメント名]

**Files:**
- Create: `docs/api.md`

**Steps:**
1. ドキュメントを作成または更新する
2. リンクと整合性を確認する
3. コミットする

**Content:**
\`\`\`markdown
# API Reference
...
\`\`\`
```

## タスク粒度のガイド

**目安: 2 〜 5 分で完了できる粒度**

| 粒度 | 判断 |
|------|------|
| 1 つのテスト + 1 つの関数 | OK |
| 1 つの設定ファイル変更 | OK |
| 複数ファイルにまたがる変更 | 分割を検討 |
| 「auth 機能を実装」 | 大きすぎる - 必ず分割 |

**分割が必要な兆候:**

- タスク説明に「and」や「〜と〜」が含まれる
- 検証ステップが複数必要
- 失敗時のロールバックが複雑になる

## アンチパターン

| パターン | 問題 | 修正方針 |
|----------|------|----------|
| 粒度が粗すぎる | 実行者が迷子になり、ロールバックも難しい | 2 〜 5 分単位に分割する |
| 曖昧な指示 | 「適切に処理する」「必要に応じて」 | 具体的なコードを書く |
| パスがない | 「テストを追加」 | `tests/auth/test_login.py` |
| 検証手順がない | 成功・失敗を判別できない | 必ずコマンドと期待結果を含める |
| 暗黙の前提 | 実行者にコンテキストがない | 前提と依存関係を文書化する |
| コード断片のみ | 「この行を追加」 | 変更前後の完全なコードブロック |

## 品質チェックリスト

プランを確定する前に確認する。

- [ ] 各タスクが 2 〜 5 分で完了できる
- [ ] ファイルパスが完全である（`src/auth/login.py` 形式）
- [ ] コードが完全である（「validation を追加」ではなく実コード）
- [ ] 検証コマンドと期待結果が明示されている
- [ ] タスクの依存関係が明確（順序の理由）
- [ ] 前提条件が文書化されている（必要なパッケージ、環境変数など）
- [ ] TDD タスクは `~/.claude/rules/testing.md` を参照している

## 良い例 / 悪い例

### 悪い例: 曖昧で粒度が粗い

```markdown
### Task 1: User Authentication

認証機能を実装する。エラーは適切に処理し、
パスワードはセキュアに保存する。
テストも追加する。
```

**問題点:** 粒度が粗すぎる、「適切に」が曖昧、パスがない、検証がない

### 良い例: 具体的で実行可能

```markdown
### Task 1: Password Hash Functions

**Files:**
- Create: `src/auth/password.py`
- Test: `tests/auth/test_password.py`

**Process:** `~/.claude/rules/testing.md` の TDD サイクルに従う

**Test Code:**
\`\`\`python
import pytest
from src.auth.password import hash_password, verify_password

def test_hash_password_returns_different_value():
    password = "secret123"
    hashed = hash_password(password)
    assert hashed != password
    assert len(hashed) == 60  # bcrypt format

def test_verify_password_returns_true_for_correct():
    password = "secret123"
    hashed = hash_password(password)
    assert verify_password(password, hashed) is True

def test_verify_password_returns_false_for_incorrect():
    hashed = hash_password("secret123")
    assert verify_password("wrong", hashed) is False
\`\`\`

**Implementation Code:**
\`\`\`python
import bcrypt

def hash_password(password: str) -> str:
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

def verify_password(password: str, hashed: str) -> bool:
    return bcrypt.checkpw(password.encode(), hashed.encode())
\`\`\`

**Verification:**
Run: `pytest tests/auth/test_password.py -v`
Expected: 3 passed

**Dependencies:**
- `bcrypt` パッケージが必要（`pyproject.toml` に既に含まれている前提）
```
