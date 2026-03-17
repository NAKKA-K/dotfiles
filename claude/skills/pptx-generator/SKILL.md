---
name: pptx-generator
description: >
  PPTX スライドを生成する汎用スキル。スタイルの更新とスライド生成を統合している。
  ユーザーが PPTX テンプレートを提供して「このスタイルで作って」「スタイルを変えて」
  「このテンプレートを使って」と言った場合はスタイル更新モードで動作する。
  「スライドを作って」「PPTX を生成して」「プレゼンを作って」「レポートをスライド化して」
  と言った場合はスライド生成モードで動作する。
  スタイルの変更、テンプレートの切り替え、新しいデザインでのスライド作成を依頼された場合も
  このスキルを使うこと。
---

# PPTX Generator (Style-Configurable)

汎用的な PPTX スライドジェネレーター。スタイルの更新とスライド生成の2つのモードを持つ。
複数のスタイルを `styles/` ディレクトリ配下にフォルダ単位で管理し、
`active_style.json` で切り替える。

## 前提条件

以下のパッケージが必要。

- python-pptx
- python-docx
- lxml
- requests
- Pillow

未インストールの場合は事前にインストールする: `uv sync` 

## ディレクトリ構成

    SKILL.md                このファイル
    active_style.json       アクティブスタイル名 ({"active": "<name>"})
    styles/
      <style-name>/         スタイルごとのフォルダ
        template.pptx       テンプレート PPTX
        style_config.json   スタイル設定
    scripts/
      pptx_helpers.py       ヘルパー関数群（active_style.json 経由でスタイルを読み込む）
      style_analyzer.py     PPTX 解析 → 新スタイルフォルダ自動生成
      generate_pptx.py      生成スクリプト（毎回上書き）

スキル実行時にまず **scripts/pptx_helpers.py** を Read ツールで読み、利用可能な
関数とその引数を把握すること。スタイルの詳細が必要な場合は
**styles/<active>/style_config.json**（特に `content_guidelines`）を参照する
（`active_style.json` でアクティブ名を確認）。

## スタイル管理

### スタイルの一覧確認

`active_style.json` を読んで現在のアクティブスタイルを確認する。
`styles/` 配下のフォルダ一覧が利用可能なスタイル。
ヘルパー関数 `list_styles()` でプログラム的にも取得可能。

### スタイルの切り替え

`active_style.json` の `"active"` を変更するだけで切り替わる。
スクリプト内で `reload_style("other-style")` を呼ぶと動的に切替可能。

## スクリプト生成場所とインポート方法

生成する Python スクリプトは **scripts/generate_pptx.py** に保存する（毎回上書き）。
保存先の絶対パス:

    <この SKILL.md と同階層>/scripts/generate_pptx.py

スクリプト先頭は以下のように書く:

    from pptx_helpers import *

インポート後は `TEMPLATE_PATH` でアクティブスタイルのテンプレート絶対パスが取得できる。
`SCRIPTS_DIR`、`SKILL_DIR`、`STYLES_DIR`、`STYLE` でそれぞれ scripts/、スキルルート、
styles/、現在のスタイル設定 dict が取得できる。

---

## Mode A: スタイル作成

ユーザーが「このスタイルで作って」「テンプレートを変えて」などと言った場合、
または新しい PPTX ファイルを提供した場合にこのモードで動作する。
**既存スタイルは上書きされず、新しいフォルダが作成される。**

### Step A-1: ユーザーから PPTX とスタイル名を受け取る

スタイルソースとなる PPTX ファイルのパスと、スタイル名を確認する。
スタイル名が未指定の場合は PPTX ファイル名（拡張子なし）がデフォルト。

### Step A-2: PPTX を解析して新スタイルフォルダを作成する

`style_analyzer.py` を使って PPTX を解析し、`styles/<style-name>/` に出力する:

    cd <SKILL_DIR>/scripts
    python style_analyzer.py "<path-to-pptx>" "<style-name>"

このスクリプトは以下を自動的に行う:
1. PPTX のレイアウト・プレースホルダー・フォント・色・位置を解析
2. `styles/<style-name>/style_config.json` を生成（`available_layouts`, `content_guidelines` 含む）
3. 提供された PPTX を `styles/<style-name>/template.pptx` としてコピー
4. `active_style.json` を更新してこのスタイルをアクティブに設定

**常にアクティブスタイルを更新する**（`--no-activate` は使用しない）。
ユーザーが明示的に「アクティブにしないで」と指示した場合のみ `--no-activate` を付ける。

### Step A-3: 設定を確認・調整する

自動生成された `styles/<style-name>/style_config.json` をユーザーに提示して確認を得る。
特に以下の項目は手動調整が必要な場合がある:

- **layouts.title / layouts.content**: 解析のヒューリスティックが正しくない場合がある。
  ユーザーに「どのレイアウトをタイトル用・コンテンツ用に使うか」確認する
- **placeholders**: コンテンツレイアウトのプレースホルダー割り当て
  (title/body/url の idx) を確認する
- **bullet**: 箇条書きスタイル（文字・フォント・インデント）を確認する
- **title_slide_textboxes**: タイトルスライドのテキストボックス位置。
  元の PPTX にテキストボックスがない場合はデフォルト値になる
- **content_guidelines**: スライド生成時の Claude 向けガイドライン。
  `lines_per_slide_min/max`（1スライドあたりの行数目安）、`bold_detail`（太字ルール）、
  `section_pattern`（セクション構成パターン）をスタイルに合わせて調整する

必要に応じて `styles/<style-name>/style_config.json` を Edit ツールで修正する。

### Step A-4: 完了報告

作成されたスタイルの要約をユーザーに報告する:
- スタイル名と保存先パス
- 使用レイアウト名
- 主要フォント
- プレースホルダー構成
- アクティブスタイルとして設定されたかどうか

---

## Mode B: スライド生成

ユーザーが「スライドを作って」などと言った場合にこのモードで動作する。
アクティブスタイル（`active_style.json` で指定）を使用して生成する。

### Step B-1: 入力の特定

ユーザーからコンテンツソースを受け取る:
- docx レポート
- テキストによる直接指示
- その他のドキュメント

シリーズ物（号数付き）の場合、前回の PPTX があれば `extract_issue_number` で
自動抽出して +1 する。

### Step B-2: コンテンツの読み取りと整理

docx の場合は `read_docx_with_hyperlinks` 関数で読み取る。

**コンテンツ忠実性の原則（重要）**:
- ソースに書かれている内容のみをスライドに反映する
- ソースにない見出し・説明・補足を勝手に追加しない
- 自己紹介・署名・メタ情報など、本文と無関係な記述はスライドに含めない

コンテンツを以下の観点で整理する:
- 重要度の高いトピックを選定（1トピック1-2スライド）
- 各トピックに対して: タイトル、本文（見出し+箇条書き）、出典 URL を構成

#### ソース内の画像・図の処理

ソース文書に画像参照や mermaid 図が含まれる場合、スライドへの掲載有無を
AskUserQuestionTool でユーザーに確認する。ユーザーが掲載を希望した場合のみ、
以下の手順で処理する。

**画像ファイルの検出**:
- markdown の `![](path)` 記法から画像パスを抽出する
- 相対パスの場合はソースファイルのディレクトリを基準に解決する
- 画像ファイルの存在を確認する

**mermaid 図の変換**:
- ソース内の ` ```mermaid ` コードブロックを検出する
- `mmdc` コマンドで PNG に変換する:

      mmdc -i /tmp/mermaid_N.mmd -o /tmp/mermaid_N.png -w 1200 -b transparent

**画像配置の判断（アスペクト比ベース）**:
- PIL で画像サイズを取得し、アスペクト比（幅/高さ）を算出する
- **横長画像（比率 > 2.0）**: テキスト下部に全幅配置
  - `resize_placeholder(slide, PH_BODY_IDX, height=2000000)` でテキスト領域を短縮
  - `add_image_to_slide()` で下部に配置し、水平中央揃えにする
  - 配置例: `top=3300000, max_width=7800000, max_height=1300000`
  - 配置後に `pic.left = Emu((9144000 - pic.width) // 2)` で中央揃え
- **縦長・正方形画像（比率 <= 2.0）**: 右サイド配置
  - `add_content_slide_with_image()` を使用する
  - テキストは短めにして画像と重ならないようにする

#### URL からの og:image 自動取得

- ソース URL から `fetch_and_download_og_image()` で og:image を取得する（`requests` ライブラリ経由、ブラウザ不使用）
- 画像が取得できたスライドは `add_content_slide_with_image()` で構成
- スクリプト末尾で `cleanup_img_cache()` を呼んでキャッシュを削除する

### Step B-3: スライド構成の決定

ユーザーにスライド構成案を提示し、承認を得る。

現在のスタイル設定に基づいてレイアウト名を使用する:
- タイトル/セクションヘッダー: `LAYOUT_TITLE` (現在: `STYLE["layouts"]["title"]["name"]`)
- コンテンツスライド: `LAYOUT_CONTENT` (現在: `STYLE["layouts"]["content"]["name"]`)

### Step B-4: PPTX 生成スクリプトの作成と実行

ヘルパー関数を活用した Python スクリプトを **scripts/generate_pptx.py** に生成して実行する。

主要な関数:

- `load_template()` - テンプレートを読み込み
- `get_layout(prs, LAYOUT_TITLE)` / `get_layout(prs, LAYOUT_CONTENT)` - レイアウト取得
- `add_title_slide(prs, layout, title, issue_num, date_str)` - タイトルスライド（号数・日付テキストボックス付き。`title_slide_textboxes` が設定されているスタイル専用。設定がないスタイルでは使用しないこと）
- `add_content_slide(prs, layout, title, body_items=items, source_links=links)` - コンテンツ
  - body_items: `{"text": "...", "type": "bullet|heading|sub_bullet|empty"}` のリスト
  - source_links: `[("表示名", "https://..."), ...]`
- `add_content_slide_with_image(prs, layout, title, image_path, body_items, source_links)` - 画像付き
- `add_table_slide(prs, layout, title, headers, rows, url=url)` - テーブル
- `add_section_header(prs, layout, title)` - セクションヘッダー
- `add_next_meeting_slide(prs, layout, meeting_str)` - 次回日程
- `remove_placeholder(slide, idx)` - 不要なプレースホルダーを削除

画像関連:
- `fetch_og_image(page_url)` - og:image URL を取得
- `download_image(url, filename=None)` - 画像をダウンロード
- `fetch_and_download_og_image(page_url, filename=None)` - og:image 取得+ダウンロード
- `add_image_right(slide, image_path)` - 右側に画像を追加
- `cleanup_img_cache()` - キャッシュ削除

スタイル管理:
- `list_styles()` - 利用可能なスタイル名の一覧を取得
- `reload_style(style_name)` - 指定スタイルに動的切替

ソース URL の扱い:
- 各スライドには `source_links` で青色クリッカブルハイパーリンクを設定する
- ソースが不要なスライドは `remove_placeholder(slide, PH_URL_IDX)` で削除

python-pptx のプレースホルダー操作に関する注意:
- プレースホルダーの位置・サイズはレイアウトから継承されている場合がある
- `shape.width` 等を設定すると継承値がリセットされる
- サイズ変更は `resize_placeholder` を使い、プレースホルダーを直接操作しないこと

### Step B-5: 出力の検証

`verify_output` 関数で生成結果を確認する。

画像付きスライドがある場合は、CLI ツールで PDF 変換 → PNG 化し、Read ツールで確認する
（ブラウザは使わない）:

    soffice --headless --convert-to pdf "<output>.pptx" --outdir /tmp/pptx_preview
    pdftoppm -png -r 150 /tmp/pptx_preview/<output>.pdf /tmp/pptx_preview/slides/slide

Read ツールで各スライド画像を確認し、テキストと画像の重なり・位置ずれがないことを検証する。

---

## 現在のスタイル確認

`active_style.json` でアクティブスタイル名を確認し、
`styles/<active>/style_config.json` でスタイル設定を読む。

スタイルの主要項目:
- `style_name`: スタイル名
- `layouts`: 使用するレイアウト名
- `fonts`: フォント設定
- `bullet`: 箇条書きスタイル
- `placeholders`: プレースホルダー idx 割り当て
- `title_slide_textboxes`: タイトルスライドの号数・日付テキストボックス設定（任意）

**タイトルスライドの構成はスタイルによって異なる**:
- `title_slide_textboxes` が設定されているスタイル: `add_title_slide()` を使い、号数・日付テキストボックスを追加する（例: dev-urandom）
- `title_slide_textboxes` が設定されていない、または汎用スタイルの場合: `add_slide()` + `set_text_in_placeholder()` でタイトルテキストのみ設定する。号数・日付は追加しない
