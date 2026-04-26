# dotfiles

シェル・エディタ・Claude Code などの個人用設定をまとめたリポジトリ。

## 対応環境

| 環境 | 状態 | 備考 |
|------|------|------|
| macOS | フル対応 | `make install` で Homebrew・cask・Brewfile を含むすべてが利用可能 |
| WSL2 (Ubuntu/Debian 系) | 部分対応 | mise／link.sh は利用可能。`make install` の brew 系ステップは cask で失敗するため非推奨 |

`bash/.bashrc` は `OSTYPE` を判定して macOS は `.bash_bsd_aliases`、Linux (WSL2 含む) は `.bash_gnu_aliases` を読み込む。OS 固有の差分はその 2 ファイルに閉じる方針。

## ディレクトリ構成

| パス | 内容 |
|------|------|
| `bash/` | bash の設定（`.bashrc`、`.bash_profile`、エイリアス各種） |
| `zsh/` | zsh の設定（`.zshrc`） |
| `vim/` | vim の設定（`.vimrc` ほか） |
| `claude/` | Claude Code のグローバル設定（`CLAUDE.md`、`rules/`、`skills/`、`commands/`、`settings.json`） |
| `Brewfile` / `brew.mk` | Homebrew で管理するパッケージと bootstrap／install 用の Makefile（macOS 前提） |
| `mise.toml` / `mise.mk` | mise で管理するツール定義と bootstrap／install 用の Makefile |
| `Makefile` | brew・mise 一括セットアップ用エントリポイント |
| `.fzf.bash` / `.fzf.zsh` | fzf の設定 |
| `.ideavimrc` | IdeaVim の設定 |
| `link.sh` | 上記設定を `$HOME` に symlink するスクリプト |

## セットアップ

### 一括セットアップ（macOS 推奨）

リポジトリ直下の `Makefile` から `make install` を実行すると、Homebrew → mise → mise install → brew bundle の順で全ステップを実行する。初回セットアップはこれだけで完結する。

```bash
make install
```

`make install` の中身は次の4ステップを順に呼び出している。

| Step | 目的 | 内部で呼ぶターゲット |
|------|------|---------------------|
| 1 | Homebrew 本体を導入 | `make -f brew.mk bootstrap` |
| 2 | mise 本体を導入 | `make -f mise.mk bootstrap` |
| 3 | mise 管理ツールの導入＋ dotfile の symlink | `make -f mise.mk install` |
| 4 | Brewfile のパッケージを一括導入（mise の shims を PATH に追加） | `make -f brew.mk install` |

Brewfile の `go "..."` ディレクティブは `go install` を内部で呼び出すため、mise 管理の `go` が PATH に存在する必要がある。`make install` は Step 4 で `~/.local/share/mise/shims` を PATH に通してから `brew bundle` を実行することで、シェルが mise 未 activate な初回起動時でも依存解決が成立するようにしている。

`mise install`（Step 3）実行時に postinstall フックとして `link.sh` が自動で動き、シェル・エディタの設定が `$HOME` に symlink される（`mise.toml` の `[hooks]` 参照）。symlink 対象の詳細は `link.sh` を参照すること（`.zshrc`、`.bashrc`、`.bash_profile`、`.bash_aliases`、`.vimrc`、`.ideavimrc`、`.fzf.zsh`、`.fzf.bash` など）。

### 個別ターゲットの再実行

特定のステップだけ再実行したい場合は、各 `*.mk` を直接呼び出す。

```bash
make -f brew.mk bootstrap
make -f mise.mk bootstrap
make -f mise.mk install
make -f brew.mk install
./link.sh                   # symlink だけ再生成したいとき
```

### WSL2 でのセットアップ

WSL2 では Homebrew (Linuxbrew) の導入自体は可能だが、`Brewfile` に含まれる `cask` (Raycast、Warp、aws-vault-binary など) は macOS 専用のため `make install` の Step 4 (`brew bundle`) で失敗する。WSL2 では brew 系ステップを使わず、以下の手順に置き換える。

```bash
make -f mise.mk bootstrap   # mise 本体を導入
make -f mise.mk install     # mise 管理ツール + link.sh による symlink
```

そのうえで、Brewfile に列挙されているパッケージのうち WSL2 でも必要なものは個別に代替する。

- 言語ランタイム・CLI ユーティリティの大半は mise (`mise.toml`) で導入済みなので追加作業は不要
- `Brewfile` の formula のうち必要なもの（例: `coreutils`、`gnupg`、`pre-commit`、`git-extras`、`vim`、`mysql` など）は `apt` で代替する
- `cask` は対象外。Raycast / Warp などの GUI アプリは Windows 側で対応する
- VSCode 拡張は VSCode の Sync Settings 機能で WSL 側にも展開する（または `code --install-extension <id>` で個別導入）
- Go tools は WSL2 上の Go (mise 管理) を使って `go install` で個別導入する

apt での代替例。

```bash
sudo apt update
sudo apt install -y coreutils gnupg pre-commit git-extras vim mysql-client
```

Linuxbrew をどうしても使いたい formula が出てきた場合は、対象を絞って手動インストールする (`brew install <formula>`)。`make -f brew.mk install` や `brew bundle --file=Brewfile` をそのまま実行すると cask が原因で失敗するため非推奨。

### Vim プラグイン

vim を起動して以下を実行すると、`dein.toml` のプラグインが導入される。

```vim
:source ~/.vimrc
```

### Claude Code 設定

`claude/` 配下の設定は Claude Code 側のグローバル設定ディレクトリ（`~/.claude/`）にリンクして利用する。`link.sh` が symlink を張るため、`make install` または `./link.sh` の実行で自動的に有効化される。詳細は `claude/CLAUDE.md` を参照。

## 運用ルール

リポジトリ運用上の原則（シークレット管理、冪等性、シンプル優先など）は `CLAUDE.md` にまとめている。
