
# Claude Code グローバル設定

このファイルは、すべてのプロジェクトで Claude Code が動作する際のガイダンスを提供する。

## 禁止事項ガイドライン

ユーザーの指示なく、以下の作業を行わない

- 次のタスクを開始
- `~/.ssh`にアクセス

## 全体ガイドライン

- 常に日本語で会話する。技術用語は英単語を使用しても構わない。
- 憶測で回答しない。
- 調査した結果、わからなかったことはわからないと回答する。
- 必要があれば質問をする。
- 文体は基本的に常体を使用する。
  - ただし、編集対象の文章が敬体の場合は、その文体に合わせる。
- GitHub Pull Request を作る時は Draft Pull Request で作成する。

## 文章作成ガイドライン

Claude Code が生成する文章（Markdown 出力、Issue、Pull Request の説明文など）に適用されるルール。

### 表記ルール

- 数字の箇条書き（1. 2. 3.）で見出しを表現しない
- **太字**で見出しを表現しない
- Markdown の見出し記法（#, ##, ###）を適切に使用する
- 箇条書きで文章の流れを表現しない
- 数字の箇条書きと通常の箇条書き（- または *）を同一階層で併用しない
- 文章をコロン（:）で終わらせて箇条書きに続けない。文章は句点で終わらせる

## タスクガイドライン

問題とは、目標と現状のギャップであり、目標達成のために解決すべき事柄である。
まず Issue で問題を整理し、解決のための具体的なアクション（課題）を定義する。
その課題の単位が Pull Request である。

### 問題の整理 (Issue)

#### 1. Issueの確認

まずはissueを指定された場合は中身を確認する。
TODOを整理して、上から順番に解決を進める。
この時、勝手にTODOの次タスクを始めてはいけない。

もしIssueが存在しない場合はGitHub Issueを作成してください。
タイトルはユーザーが Claude Code に指示した問題の内容を簡潔にまとめる。
プロジェクトに GitHub Issue template があればそれに従い、なければ以下の構造で description をまとめる。

```markdown
## 概要

背景と目的を踏まえた Issue の概要を簡潔に記述する。

## 背景

この Issue の背景となっている問題について記述し、具体的な課題に落とし込めている場合はその課題も記述する。

## 目的

なぜこのIssueに取り組むのか、背景を踏まえて記述する。

## 実現方法

実現方法を簡易的にまとめて記述する。

### ToDo

詳細に対応手順をリスト形式で記述する。

```

### 課題の解決

#### 1. Branch 作成

Git stage 上の変更を確認し、タスクに応じた適切な名前で branch を作成する。
branch 名は kebab-case にする（例：`add-dbt-resources`）。

#### 2. 関連ファイルを Git stage に登録する

実行しているToDoの内容から、そのタスクに関連する変更されたファイルを Git stage に登録する。
関係のないファイルは追加しない。

#### 3. Git Commit

Git stage 上の変更を確認し、タスクに応じた適切な commit message を作成する。
commit message は [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) に従う。

#### 4. Claude Code による コードレビュー

Claude Code により今までの変更をコードレビューする。
もし修正箇所があればToDoにして、ユーザーにそれぞれ解決すべきかどうか質問する。
解決が必要であれば自動的に修正する。
その後、課題解決の 「2. 関連ファイルを Git stage に登録する」に戻ってサイクルを回す。

#### 5. Git Push

作成した branch を remote repository に push する。

#### 6. Pull Request 作成

タイトルはユーザーが Claude Code に指示したタスクの内容と実装した変更を簡潔にまとめる。

**テンプレートの利用**：
- プロジェクトにPULL_REQUEST_TEMPLATE.mdがある場合は、そのテンプレートを元にdescriptionを作成する
- テンプレートがない場合は、以下の構造でdescriptionをまとめる

Pull Request の作成をする場合、必ず Draft Pull Request で作成してください。

```markdown
## 概要

どの GitHub Issue に関わる Pull Request か `- refs IssueURL` 記述する。
背景・目的・実装内容を踏まえた Pull Request 全体の概要を簡潔に記述する。

## 背景

関連する GitHub Issue へのリンクをまず記述する。
その後、GitHub Issue の内容に基づいた背景を簡潔にまとめる。

GitHub Issue に紐づけない場合はリンクは記載しない。
この Pull Request の背景となっている問題について記述し、具体的な課題に落とし込めている場合はその課題も記述する。

## 目的

関連する GitHub Issue の目的に基づいた目的を簡潔にまとめる。
関連する GitHub Issue がない場合は、この Pull Request に取り組む目的を背景を踏まえて記述する。

## 実装内容

Pull Request のコード内容と、ユーザーが Claude Code に指示したタスクの内容をもとに、実装内容をまとめる。
細かいコードの変更内容ではなく、背景と目的を踏まえた上での実装の概要をまとめる。

## ブランチ環境URL

ブランチ環境が利用可能な場合は、該当するURLを記載する。

## 検証内容

確認したことを記述する。
Claude Code が確認できず、ユーザーが確認すべき項目はToDo形式で記述する。

```

## GitHub 連携ガイドライン

### Issue・Pull Request の参照

Issue や Pull Request を参照する際は、リスト形式で記載する。
GitHub上でプレビューが表示されるため、視認性が向上する。

例：
```markdown
- #123
- #456
- #789
```

### GitHub Copilot レビューの活用

前提: プロジェクトに .github/copilot-instructions.md がある場合はこのルールを無視してください。無い場合は適用してください。

Pull Request を作成する際、プロジェクトにPULL_REQUEST_TEMPLATE.mdがある場合は、そのテンプレートからGitHub Copilotレビュー用のコメントを取得して活用する。
テンプレートがない場合は、以下の標準的なCopilotレビュー用コメントを含める。

```markdown
<!-- GitHub Copilot コードレビューへの指示:
    このプルリクエストをレビューしてコメントする際には日本語でお願いします。
    レビューする際には、以下のprefix(接頭辞)を付けましょう。
    [must] → かならず変更してね
    [imo] → 自分の意見だとこうだけど修正必須ではないよ(in my opinion)
    [nits] → ささいな指摘(nitpick)
    [q] → 質問(question)
    [fyi] → 参考情報
-->
```
