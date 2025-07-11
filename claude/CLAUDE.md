# Claude Code グローバル設定

このファイルは、すべてのプロジェクトで Claude Code が動作する際のガイダンスを提供する。

## Claude Code行動原則

### 全体ガイドライン

- 常に日本語で会話する。技術用語は英単語を使用しても構わない
- 憶測で回答しない
- 調査した結果、わからなかったことはわからないと回答する
- 必要があれば質問をする
- 文体は基本的に常体を使用する
    - ただし、編集対象の文章が敬体の場合は、その文体に合わせる

### 禁止事項ガイドライン

ユーザーの指示なく、以下の作業を行わない

- 次のタスクを開始
- `~/.ssh`にアクセス

### タスク開始時の必須確認事項

Claude Codeは、コーディングタスクを開始する前に以下を必ず確認・実行する：

1. **TDD適用判断**: タスクがTDD適用対象か例外ケースかを判断
2. **適用対象の場合**: 🔴 Red（失敗するテスト）から開始することを明示
3. **例外ケースの場合**: 理由を明記して直接実装を開始

### 実装進行中の行動原則

- TDD適用時は必ずRed-Green-Blueサイクルを順守
- 各段階でのコミットを適切なメッセージで実行
- ユーザーからの指摘があった場合は即座にTDDサイクルに戻る

### ファイル・コンテンツ変更時の必須確認事項

Claude Codeは、任意のファイル、Issue、Pull Requestを変更する前に以下を必ず実行する：

#### 既存内容の確認義務
- **完全読み取り**: 変更対象の現在の内容を必ず事前に読み取り、正確に把握する
- **ユーザー追加分の特定**: ユーザーが独自に追加したコンテンツ（スクリーンショット、コメント、説明等）を特定する
- **変更必要箇所の限定**: 実際に変更が必要な箇所のみを特定する

#### 差分変更の原則
- **部分修正**: 全体を上書きするのではなく、必要な部分のみを追加・修正する
- **保護対象の維持**: ユーザーが追加したすべてのコンテンツを完全に保持する
- **最小限変更**: 指示された変更のみを行い、不要な修正は行わない

#### 禁止事項
- **全体上書き**: ファイルやPRの内容を全て書き換えることを禁止
- **ユーザーコンテンツ削除**: ユーザーが追加したスクリーンショット、画像、コメント等の削除を禁止
- **無確認変更**: 既存内容を確認せずに変更することを禁止

### 通知設定

タスクを進めるにあたって、以下の状況となった時には音声通知でユーザーに知らせること

- **タスク完了時**: `afplay /System/Library/Sounds/Glass.aiff` （必須：タスクが完了したら必ず実行する）
- **ユーザー確認必要時**: `afplay /System/Library/Sounds/Ping.aiff`
- **エラー/問題発生時**: `afplay /System/Library/Sounds/Basso.aiff`

## 開発フロー

### Issue管理

#### Issue確認・作成手順

問題とは、目標と現状のギャップであり、目標達成のために解決すべき事柄である。
まず Issue で問題を整理し、解決のための具体的なアクション（課題）を定義する。
その課題の単位が Pull Request である。

Issueが指定された場合は内容を確認し、TODOを整理して上から順番に解決を進める。
勝手に次のタスクを始めてはいけない。

Issueが存在しない場合はGitHub Issueを作成する。
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

### Branch・PR・Merge戦略

#### 開発ワークフロー

Issue → Branch → PR → Merge の基本フローに従う。

1. **Branch作成**: タスクに応じた適切な名前でbranchを作成する。branch名はkebab-caseにする（例：`add-dbt-resources`）
2. **TDD適用判断**: 実装開始前に、このタスクがTDD適用対象かを判断する
3. **実装・テスト**: TDD適用時はRed-Green-Blueサイクルを徹底し、適宜commitする。関係のないファイルは追加しない
4. **品質チェック**: Lintツールとテストの成功を確認
5. **Git Push**: 作成したbranchをremote repositoryにpushする
6. **Pull Request作成**: Draft Pull Requestで作成

#### Pull Request作成

タイトルはユーザーが Claude Code に指示したタスクの内容と実装した変更を簡潔にまとめる。

**テンプレートの利用**：
- プロジェクトにPULL_REQUEST_TEMPLATE.mdがある場合は、そのテンプレートを元にdescriptionを作成する
- テンプレートがない場合は、以下の構造でdescriptionをまとめる

Pull Requestは必ずDraft Pull Requestで作成する。

```markdown
## 概要

どの GitHub Issue に関わる Pull Request か `- refs IssueURL` 記述する。
背景・目的・実装内容を踏まえた Pull Request 全体の概要を簡潔に記述する。

## 背景

GitHub Issue の内容に基づいた背景を簡潔にまとめる。

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

### TDD戦略

#### t-wada流TDD（Test-Driven Development）の実施

全ての機能実装において、原則として以下のt-wada流TDDサイクルに従う：

- 🔴 **Red**: 失敗するテストを書く
- 🟢 **Green**: テストを通す最小限の実装
- 🔵 **Refactor**: リファクタリング

#### TDD適用の基本原則

- **APIの新規追加**: TDD実施必須
- **ビジネスロジックの変更**: TDD実施必須
- **バグ修正**: まず再現テストを書き、その後修正

#### TDD例外ケース

以下のケースではTDDを適用せず、直接実装を進めることができる：

1. **READ ONLY API**: 読み取り専用APIの実装
2. **ドキュメント・設定ファイル変更**: Markdown、設定ファイル、README等の編集
3. **コメント追加・削除**: コード内コメントの変更のみ
4. **デバッグ用ログ追加**: 既存機能を変更しないログ出力の追加
5. **定数値・設定値変更**: ロジックを変更しない値の調整
6. **軽微なリファクタリング**: 外部仕様を変更しない変数名変更等
7. **緊急バグ修正**: 本番環境で発生した緊急事態対応（ただし修正後にテスト追加必須）

#### コミット戦略

**基本原則**
- Conventional Commitsに従ったコミットメッセージ記述
- 型・スコープ・記述ルールの統一（日本語記述、技術用語は英語併用可）
- 1つのコミットには1つの論理的変更のみを含める
- 関連するファイルでも、異なる責務の変更は分離する
- 各コミットが独立してレビュー可能であること

**TDD時のコミットルール**
TDDサイクルを明確に追跡するため、各段階で以下のコミットメッセージ形式を使用する：

- 🔴 テストを書いたら: `test: [機能名] のテストを追加`
- 🟢 テストを通したら: `feat: [機能名] を実装`
- 🔵 リファクタリングしたら: `refactor: [説明]`

**TDD適用時の詳細コミット手順**
1. 🔴 **Red段階**: 失敗するテストのみをコミット
2. 🟢 **Green段階**: テストを通す最小限の実装のみをコミット
3. 🔵 **Refactor段階**:
   - 実装コードのリファクタリング
   - テストコードのリファクタリング
   - 呼び出し元の調整
   - を別々にコミット

**複数ファイル変更時のコミット順序**
1. 核となる機能実装（usecase/repository層）
2. インターフェース変更に伴う呼び出し元修正
3. unit testの追加・修正
4. integration testの追加・修正
5. ドキュメント・コメントの更新
6. generated codeの更新（必要な場合）

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

前提: プロジェクトに .github/copilot-instructions.md がある場合は**このルールを無視してください**。プロジェクトに .github/copilot-instructions.md が無い場合はこのルールを適用してください。

```markdown
<!-- GitHub Copilot コードレビューへの指示:
    このプルリクエストをレビューしてコメントする際には日本語でお願いします。
    レビューする際には、以下のprefix(接頭辞)を付けましょう。
    [must] → プログラムに重大な影響を及ぼすため必ず変更してね
    [imo] → 修正した方が良いと私は思うけど、必須ではないよ(in my opinion)
    [nits] → ささいな内容の修正指摘 (nitpick)
    [q] → 質問 (question)
    [fyi] → 参考情報
-->
```

### 基本ルール

- **ヘッダーはh2から始めること**
- **読み取り**: IssueやPRから情報を読み取ることを指示されたら`gh`コマンドを利用すること
- **URLはコードスパンで囲まず**、リンクとして機能するように平文で記載すること

## 品質・文章基準

### 文章作成ガイドライン

Claude Code が生成する文章（Markdown 出力、Issue、Pull Request の説明文など）に適用されるルール。

#### 表記ルール

- 数字の箇条書き（1. 2. 3.）で見出しを表現しない
- **太字**で見出しを表現しない
- Markdown の見出し記法（#, ##, ###）を適切に使用する
- 箇条書きで文章の流れを表現しない
- 数字の箇条書きと通常の箇条書き（- または *）を同一階層で併用しない
- 文章をコロン（:）で終わらせて箇条書きに続けない。文章は句点で終わらせる

### コード品質基準

#### コーディング規約
- プロジェクト共通のコード品質ツール設定に従う
- エラーハンドリングの統一原則に従う

#### 開発思想・姿勢
- 憶測で実装せず、不明点は早期質問する
- 既存パターンを学習し準拠した実装を行う
- 最小限実装から段階的拡張を基本とする
- プロジェクト文脈を重視し、技術的正しさとプロジェクト方針を両立させる

#### 品質チェック手順

コードレビューを行う前に、必ずLintツールとテストが成功することを確認する。
プロジェクトに応じて以下のようなコマンドを実行する：
- `npm run lint`、`yarn lint`
- `npm test`、`yarn test`
- `make lint`、`make test`
- その他プロジェクト固有の品質チェックコマンド

品質チェックが完了後、変更内容をClaude Codeがコードレビューする。
修正箇所があればToDoにし、ユーザーに解決すべきかどうか質問する。
解決が必要であれば自動的に修正し、Git stageへの登録に戻る。

#### テスト実装戦略
- PR作成時の自動テスト実行
- 機能の重要度・影響範囲に応じた選択的テスト実装
- ビジネスロジックの重要度に基づくテスト優先度決定


