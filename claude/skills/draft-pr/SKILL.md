---
name: draft-pr
description: ドラフトPull Requestを作成するスキル。ユーザーが「PR作成」「draft PR作成」「ドラフトのPRを作る」「pull requestを作成して」などを依頼したとき、または作業ブランチでの実装が完了してPRが必要な場面で使用する。現在のブランチの変更とGitHub Issueの内容を参照し、`gh pr create --draft` でドラフトPRを作成する。
---

# Draft PR

現在のブランチの変更とGitHub Issueを参考に、プロジェクト規約に準拠したドラフトPRを作成する。

## ワークフロー

### 1. Issue番号の特定

引数でIssue番号が指定されていればそれを使用。未指定の場合:

1. ブランチ名から抽出（例: `feature/123-add-feature` → `#123`）
2. コミットメッセージから `#123` 形式の参照を検索
3. それでも見つからない場合はAskUserQuestionでユーザーに確認

### 2. ブランチ状態の確認

```bash
git branch --show-current
git status
DEFAULT=$(gh repo view --json defaultBranchRef -q .defaultBranchRef.name)
git log ${DEFAULT}..HEAD --oneline
git diff ${DEFAULT}...HEAD --stat
```

確認事項:
- 未コミットの変更がある場合はコミットを提案
- リモートへのプッシュ状況を確認

### 3. Issue情報の取得

Issue番号が特定できた場合:

```bash
gh issue view <Issue番号> --json title,body,labels,url
```

抽出する情報: タイトル・背景・目的・実現方法/ToDo・ラベル

### 4. PRテンプレートの確認

```bash
test -f .github/PULL_REQUEST_TEMPLATE.md && cat .github/PULL_REQUEST_TEMPLATE.md
```

- テンプレートがある場合: その構造に従う
- テンプレートがない場合: 以下の標準構造を使用

```markdown
## 概要

- refs #<Issue番号>

<背景・目的・実装内容を踏まえた概要>

## 背景

<Issue内容に基づいた背景>

## 目的

<Issue目的に基づいた目的>

## 実装内容

<変更内容の概要（細かいコード変更ではなく、背景・目的を踏まえた実装の概要）>

## 検証内容

- [ ] <確認事項>
```

### 5. ドラフトPRの作成

**必須**: `--draft` フラグを必ず使用する（省略禁止）。

```bash
gh pr create --draft --title "<PRタイトル>" --body "$(cat <<'EOF'
<PR説明文>
EOF
)"
```

PRタイトルの方針:
- Issueタイトルと実装内容を組み合わせて簡潔に
- 70文字以内

### 6. 完了通知

```bash
afplay /System/Library/Sounds/Glass.aiff
```

作成したPRのURL・番号・関連IssueをユーザーにreportしてPRの内容確認・次のステップを案内する。

## 重要なルール

- **`--draft` フラグは絶対に省略しない** (CLAUDE.md必須規約)
- Issue参照は `- refs #123` のようにリスト形式（GitHubプレビュー表示のため）
- URLはコードスパンで囲まず平文で記載（リンクとして機能させる）
- 見出しはh2（##）から始める
- `git push` の実行はユーザーの承認を得てから行う（permissionがask設定のため）

## エラーハンドリング

| 状況 | 対処 |
|------|------|
| Issue番号不明 | AskUserQuestionで確認、またはIssueなしでPR作成するか確認 |
| 変更なし | ユーザーに通知 |
| リモートブランチ未存在 | push前にユーザーの承認を得る |
| gh CLI認証エラー | `gh auth status` で確認、`gh auth login` を案内 |
