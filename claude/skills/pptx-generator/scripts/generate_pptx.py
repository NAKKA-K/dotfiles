import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from pptx_helpers import *
from pptx.util import Pt, Emu
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN

OUTPUT_PATH = "/Users/sh-nakamura/dev/my/docs/geek_fest_2026/geek_fest_2026.pptx"

prs = load_template()
delete_all_slides(prs)

layout_title = get_layout(prs, LAYOUT_TITLE)   # TITLE_1_1
layout_content = get_layout(prs, LAYOUT_CONTENT)  # TITLE_1

# ─── Slide 1: Title ───────────────────────────────────────────────────────────
slide = prs.slides.add_slide(layout_title)
set_text_in_placeholder(
    slide, PH_TITLE_IDX,
    "「何を作るか」でなく「何を解くか」\n事業をエンジニアリングし、AIと共に進化する",
    alignment=PP_ALIGN.CENTER,
)
add_textbox(
    slide,
    left=TITLE_ISSUE_LEFT, top=TITLE_ISSUE_TOP,
    width=TITLE_ISSUE_WIDTH, height=TITLE_ISSUE_HEIGHT,
    text="なっかー / fluct 副部長・テックリード",
    alignment=PP_ALIGN.CENTER,
)
add_textbox(
    slide,
    left=TITLE_DATE_LEFT, top=TITLE_DATE_TOP,
    width=TITLE_DATE_WIDTH, height=TITLE_DATE_HEIGHT,
    text="CARTA TECH GEEK FEST 2026",
    alignment=PP_ALIGN.RIGHT,
)

# ─── Slide 2: 自己紹介 ────────────────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="自己紹介",
    body_items=[
        {"text": "なっかー — fluct 6年目、副部長・テックリード", "type": "heading"},
        {"text": "SSPの配信サーバー・管理画面の開発チーム（10人前後）を担当", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "fluct とは", "type": "heading"},
        {"text": "WebサイトやアプリのメディアとSSPをリアルタイムでつなぐ広告プラットフォーム", "type": "bullet"},
        {"text": "1日数十億リクエストをレイテンシー数百ms以内で処理する", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "入社のきっかけ", "type": "heading"},
        {"text": "一緒に働きたいと思えるこの人たちを作り上げた文化に惹かれた", "type": "bullet"},
    ],
)

# ─── Slide 3: 今日話すこと ────────────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="今日話すこと — Lv1 → Lv3 の冒険",
    body_items=[
        {"text": "テーマ", "type": "heading"},
        {"text": "実装力が全てだと思っていた自分が、事業に向き合うエンジニアになるまでの話", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "3つのレベルアップ", "type": "heading"},
        {"text": "Lv1: タスクをもらってやるだけ（1年目）", "type": "bullet"},
        {"text": "Lv2: 会計システムを1人で背負い「なぜ」を問いはじめる（1〜2年目）", "type": "bullet"},
        {"text": "Lv3: 正解がない中でfluct としての答えを作る（3〜4年目）", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "自分はたまたま会計周りが強みだけど、この話はどの領域にも通ずる", "type": "bullet"},
    ],
)

# ─── Slide 4: 結論（先出し） ─────────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="結論を先に — 「なぜを問える人」がAIを加速装置にできる",
    body_items=[
        {"text": "問い", "type": "heading"},
        {"text": "実装が圧縮された今、エンジニアは何で勝負するのか？", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "答え", "type": "heading"},
        {"text": "課題を自分ごととして捉え、「何故やるのか」「何を解くのか」を考えること", "type": "bullet"},
        {"text": "事業に向き合い、技術の力で事業を前に進めること", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "なぜそう言い切れるのか——自分のレベルアップの過程を話します", "type": "bullet"},
    ],
)

# ─── Slide 5: 今の世界地図 ───────────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="今の世界地図 — AIで何が変わったか",
    body_items=[
        {"text": "2020年頃（なっかーが新卒だった頃）", "type": "heading"},
        {"text": "インフラはオンプレ・EC2、CI/CDはJenkins", "type": "bullet"},
        {"text": "AIアシストはなく、コードは全部自分で書いた", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "2026年の今", "type": "heading"},
        {"text": "AIがコードを書く", "type": "bullet"},
        {"text": "自分が時間をかけて書いたものと同等のものが一瞬で出る", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "この変化の中でエンジニアの価値はどこにあるのか？", "type": "bullet"},
    ],
)

# ─── Slide 6: Section — Lv1 ──────────────────────────────────────────────────
add_section_header(prs, layout_title, "Lv1\nタスクをもらってやるだけの世界")

# ─── Slide 7: Lv1 詳細 ───────────────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="Lv1 — タスクをもらってやるだけの世界（1年目）",
    body_items=[
        {"text": "自分の物差し", "type": "heading"},
        {"text": "「実装できる＝成長」。それ以外の評価軸を知らない", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "担当範囲", "type": "heading"},
        {"text": "fluct SSP 全般。管理画面・配信サーバー・会計システムを一通り触る", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "このフェーズで求められたこと", "type": "heading"},
        {"text": "頼まれたタスクを1人でやり切ること", "type": "bullet"},
        {"text": "担当範囲の中で着実に成果を出すこと", "type": "bullet"},
    ],
)

# ─── Slide 8: Section — Lv2 ──────────────────────────────────────────────────
add_section_header(prs, layout_title, "Lv2\n1人でfluct会計システムを背負う")

# ─── Slide 9: Lv2 — 会計システムとは ─────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="Lv2 — fluctの会計システムとは",
    body_items=[
        {"text": "広告主からもらいメディアに支払う双方向の資金管理", "type": "bullet"},
        {"text": "1日数十億リクエスト分のお金の流れを扱う", "type": "bullet"},
        {"text": "1円のズレも許されない業務知識の塊", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "間違えたら", "type": "heading"},
        {"text": "取引先への支払いミス → 信用の低下", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "このシステムが入社1年目の自分に丸ごと落ちてきた", "type": "bullet"},
    ],
)

# ─── Slide 10: Lv2 — 当時の状況 ──────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="Lv2 — 当時の状況（1年目終わり〜2年目）",
    body_items=[
        {"text": "状況", "type": "heading"},
        {"text": "前任者が辞めて仕様を知る人間がいない", "type": "bullet"},
        {"text": "エンジニア・運用者の両方に詳しい人間も同時に離脱", "type": "bullet"},
        {"text": "毎日 biz から質問・要求の雨。答えられない。焦る", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "自分のレベルと要求レベルの差", "type": "heading"},
        {"text": "「到底太刀打ちできない」と感じていた", "type": "bullet"},
        {"text": "先輩が相談に乗ってくれたが、仕様は誰も知らない。割と自力", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "周りの強いエンジニアがコードを読み解き、自ら判断している姿を参考にした", "type": "bullet"},
    ],
)

# ─── Slide 11: Lv2 — 気づき ──────────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="Lv2 — 気づき",
    body_items=[
        {"text": "やったこと", "type": "heading"},
        {"text": "一人では解決しない。とにかく周りと話す", "type": "bullet"},
        {"text": "コードを読み解き、ビジネス側の人と話しながら自ら判断", "type": "bullet"},
        {"text": "がむしゃらに繰り返した", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "得たもの", "type": "heading"},
        {"text": "「岩を切っていると思っていなかったが、切れるようになっていた」", "type": "bullet"},
        {"text": "「なぜこれをやるのか」を考え、優先度を自分で決め、判断する側へ", "type": "bullet"},
        {"text": "タスクをもらう側 → 自分で優先度を決める側へ", "type": "sub_bullet"},
    ],
)

# ─── Slide 12: Section — Lv3 ─────────────────────────────────────────────────
add_section_header(prs, layout_title, "Lv3\n国の税制変更という未知の中で\n正解を導き出す")

# ─── Slide 13: Lv3 — インボイスとfluctの難しさ ────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="Lv3 — インボイス制度とfluctの難しさ（3〜4年目）",
    body_items=[
        {"text": "インボイス制度とは", "type": "heading"},
        {"text": "「定められた書式の書類（インボイス）を揃えないと消費税を経費として認めない」制度", "type": "bullet"},
        {"text": "企業はシステムや経理の対応が必要になった", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "fluctにとっての難しさ", "type": "heading"},
        {"text": "大小の取引先（登録事業者・非登録事業者）を全て管理し直す必要があった", "type": "bullet"},
        {"text": "アプリ開発だけでは対応できない", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "どの企業も正解を持っておらず、当然fluctも未知の中にあった", "type": "bullet"},
    ],
)

# ─── Slide 14: Lv3 — やったこと ──────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="Lv3 — やったこと",
    body_items=[
        {"text": "技術的な計算変更より本当に大変だったのは正解がない不確実性", "type": "bullet"},
        {"text": "オペレーション変化・取引先対応・消費税の立ち位置判断が必要だった", "type": "sub_bullet"},
        {"text": "", "type": "empty"},
        {"text": "不確実性を下げるために", "type": "heading"},
        {"text": "財務・法律の業務知識を経理/法務の方を頼りつつも自分で勉強した", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "事業に向き合う", "type": "heading"},
        {"text": "事業責任者に「fluctとしてどうあるべきか」を提案した", "type": "bullet"},
        {"text": "全社への知識伝搬: Slackチャンネル作成・Q&A作成・事例の共有", "type": "bullet"},
    ],
)

# ─── Slide 15: Lv3 — 気づき ──────────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="Lv3 — 気づき",
    body_items=[
        {"text": "「今までやっていたことだけじゃ乗り越えられない」", "type": "bullet"},
        {"text": "取れそうなものを片っ端から掴んだ", "type": "sub_bullet"},
        {"text": "", "type": "empty"},
        {"text": "踏み込む、という発見", "type": "heading"},
        {"text": "周りの強いエンジニアが事業に向き合い自ら先導している姿を見た", "type": "bullet"},
        {"text": "「自分もそこまで踏み込んでいい」と気づいた", "type": "bullet"},
        {"text": "「踏み込むからこそいいものが作れる」", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "正解が決まっていない状況で、fluctとしての答えをシステムに落とした", "type": "bullet"},
    ],
)

# ─── Slide 16: ダブルループ構造 ───────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="気づいたら大きなループにいた — ダブルループ構造",
    body_items=[
        {"text": "開発ループ（小）", "type": "heading"},
        {"text": "仕様を受け取る → 設計・実装 → テスト → デプロイ", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "ビジネスループ（大）", "type": "heading"},
        {"text": "課題を発見する → 解くべきことを定義する → 開発する → 効果を検証する", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "Lv1→Lv3の過程で、いつの間にかコードを書くループから", "type": "bullet"},
        {"text": "ビジネスの課題を解き改善する大きなループに移行していた", "type": "sub_bullet"},
    ],
)

# ─── Slide 17: AIが圧縮したもの ──────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="AIが圧縮したもの・変わらないもの",
    body_items=[
        {"text": "AIによって今、開発ループが大幅に圧縮された", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "AIが圧縮したのは開発ループという小さいループだけ", "type": "heading"},
        {"text": "ビジネスループ全体は変わらずやる必要がある", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "嬉しくなかったこと", "type": "heading"},
        {"text": "実装力をコツコツ積み上げる成長プロセスが大なり小なり奪われた", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "嬉しかったこと", "type": "heading"},
        {"text": "「なぜ」を考えるという成長ポイントにフォーカスできるようになった", "type": "bullet"},
    ],
)

# ─── Slide 18: AIに使われないために ──────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="AIに使われる側にならないために",
    body_items=[
        {"text": "危険なパターン", "type": "heading"},
        {"text": "やったけどなぜ上手くいった・失敗したか分からない", "type": "bullet"},
        {"text": "→ 成長に繋がらない「やった」が積まれるだけ", "type": "sub_bullet"},
        {"text": "", "type": "empty"},
        {"text": "大切にすること", "type": "heading"},
        {"text": "「なぜやるのか」を考え続ける", "type": "bullet"},
        {"text": "「どうしてこうなったのか」を問い続ける", "type": "bullet"},
        {"text": "「何を解くのか」を明確にし続ける", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "タイトル回収:「何を作るか」でなく「何を解くか」", "type": "bullet"},
    ],
)

# ─── Slide 19: まとめ ────────────────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="まとめ — 焦りの正体と、これからの物差し",
    body_items=[
        {"text": "自分が今学生だったら", "type": "heading"},
        {"text": "大部分の焦りの発生源は「実装以外の手札を持っていない」こと", "type": "bullet"},
        {"text": "手札は自分で増やせる。Lv1→Lv2、Lv2→Lv3の自分がそうだった", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "みんなへ", "type": "heading"},
        {"text": "コード1行、判断一個に対して「なぜ」に答えられると全アウトプットの質が上がる", "type": "bullet"},
        {"text": "なぜを考えられると自信がつく。理由付けができると味方ができる", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "AI時代において「何故やるのか、何を解くのか」を考えられることは大きな追い風", "type": "bullet"},
    ],
)

# ─── Slide 20: クロージング ──────────────────────────────────────────────────
add_content_slide(
    prs, layout_content,
    title="クロージング — CARTA & Treasure",
    body_items=[
        {"text": "CARTAは事業に向き合うことを矜持に持っている", "type": "bullet"},
        {"text": "", "type": "empty"},
        {"text": "Treasure とは", "type": "heading"},
        {"text": "CARTAのサマーインターン。今日話した「事業に向き合うエンジニアリング」を体験できる場所", "type": "bullet"},
        {"text": "テックリード/CTOがベタ付きでついてくれる", "type": "sub_bullet"},
        {"text": "本当に運用されているエンジニア評価制度の課題を技術で解く", "type": "sub_bullet"},
        {"text": "解き方も向き合い方も自由", "type": "sub_bullet"},
        {"text": "", "type": "empty"},
        {"text": "Treasureでチームを前に進める主戦力になってください", "type": "bullet"},
    ],
)

# ─── Save ─────────────────────────────────────────────────────────────────────
prs.save(OUTPUT_PATH)
print(f"Saved: {OUTPUT_PATH}")
verify_output(OUTPUT_PATH)
