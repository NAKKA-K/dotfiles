# Brewfile
#
# 言語ランタイム・CLI ユーティリティの大半は mise.toml で管理する。
# このファイルでは以下のいずれかに該当するものだけを扱う。
#   - サービス管理 (brew services) を伴うもの (mysql、php-fpm)
#   - Homebrew が事実上標準のもの (vim)
#   - mise plugin が存在しない / 未対応のもの (roswell など)
#   - macOS アプリケーション (cask)
#   - VSCode 拡張、Go tools
#
# `brew bundle --file=Brewfile` で一括インストールする。

tap "felixkratz/formulae"
tap "homebrew/bundle"
tap "homebrew/services"
tap "lightdash/lightdash"
tap "microsoft/apm"

# 開発ツール
brew "coreutils"
brew "gnupg"
brew "pre-commit"
brew "git-extras"
brew "vim"

# 言語ランタイム (mise で管理しないもの)
brew "perl"
brew "php"
brew "php@8.0", restart_service: :changed
brew "php@8.1"
brew "roswell"

# データベース
brew "mysql@8.0", link: true

# 専用ツール
brew "felixkratz/formulae/borders"
brew "lightdash/lightdash/lightdash"
brew "microsoft/apm/apm"

# --- 過去に利用した formula (現在は未インストール、参考のため残す) ---
# brew "autoconf"               # GNU Autoconf
# brew "cairo"                  # 2D グラフィックスライブラリ
# brew "carthage"               # macOS / iOS 依存管理ツール
# brew "clang-format"           # C/C++ コードフォーマッタ
# brew "harfbuzz"               # テキスト整形エンジン
# brew "pango"                  # テキストレイアウトライブラリ
# brew "fontforge"              # フォント編集ツール
# brew "fop"                    # XSL-FO レンダリング
# brew "gobject-introspection"  # GObject イントロスペクション
# brew "nghttp2"                # HTTP/2 実装
# brew "nkf"                    # 文字コード変換
# brew "protobuf"               # Protocol Buffers
# brew "unixodbc"               # ODBC ドライバマネージャ
# brew "sanemat/font/ricty"     # Ricty フォント (旧 tap sanemat/font)

cask "aws-vault-binary"
cask "raycast"
cask "warp"

# --- 過去に利用した cask (現在は未インストール、参考のため残す) ---
# cask "fig"  # ターミナル補完ツール (サービス終了)

# VSCode 拡張
vscode "aleksandra.go-group-imports"
vscode "aswinkumar863.smarty-template-support"
vscode "bastienboutonnet.vscode-dbt"
vscode "bmewburn.vscode-intelephense-client"
vscode "dbaeumer.vscode-eslint"
vscode "devsense.composer-php-vscode"
vscode "devsense.intelli-php-vscode"
vscode "devsense.phptools-vscode"
vscode "devsense.profiler-php-vscode"
vscode "dwtexe.cursor-stats"
vscode "eamodio.gitlens"
vscode "editorconfig.editorconfig"
vscode "esbenp.prettier-vscode"
vscode "gera2ld.markmap-vscode"
vscode "golang.go"
vscode "grafana.vscode-jsonnet"
vscode "graphql.vscode-graphql"
vscode "graphql.vscode-graphql-syntax"
vscode "hashicorp.hcl"
vscode "hashicorp.terraform"
vscode "ms-azuretools.vscode-docker"
vscode "ms-ceintl.vscode-language-pack-ja"
vscode "ms-vscode-remote.remote-containers"
vscode "ms-vscode.makefile-tools"
vscode "ms-vsliveshare.vsliveshare"
vscode "neilbrayfield.php-docblocker"
vscode "samuelcolvin.jinjahtml"
vscode "thenouillet.symfony-vscode"
vscode "vscodevim.vim"
vscode "whatwedo.twig"
vscode "xdebug.php-debug"
vscode "yzane.markdown-pdf"
vscode "yzhang.markdown-all-in-one"

# Go tools (golangci-lint は mise で管理)
go "github.com/bufbuild/buf/cmd/buf"
go "cmd/go"
go "cmd/gofmt"
go "golang.org/x/tools/gopls"
go "go.uber.org/nilaway/cmd/nilaway"
go "honnef.co/go/tools/cmd/staticcheck"
