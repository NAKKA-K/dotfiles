# dotfiles

シェル・エディタ・Claude Code などの個人用設定をまとめたリポジトリ。

## ディレクトリ構成

| パス | 内容 |
|------|------|
| `bash/` | bash の設定（`.bashrc`、`.bash_profile`、エイリアス各種） |
| `zsh/` | zsh の設定（`.zshrc`） |
| `vim/` | vim の設定（`.vimrc` ほか） |
| `claude/` | Claude Code のグローバル設定（`CLAUDE.md`、`rules/`、`skills/`、`commands/`、`settings.json`） |
| `Brewfile` / `brew.mk` | Homebrew で管理するパッケージと bootstrap／install 用の Makefile |
| `mise.toml` / `mise.mk` | mise で管理するツール定義と bootstrap／install 用の Makefile |
| `.fzf.bash` / `.fzf.zsh` | fzf の設定 |
| `.ideavimrc` | IdeaVim の設定 |
| `link.sh` | 上記設定を `$HOME` に symlink するスクリプト |

## セットアップ

セットアップは Homebrew → mise → Brewfile → 仕上げ の順で進める。
mise が管理する `go` コマンドが Brewfile の `go "..."` ディレクティブで必要になるため、`brew bundle` は mise install の後に実行する。

| Step | 目的 | コマンド |
|------|------|----------|
| 1 | Homebrew 本体を導入 | `make -f brew.mk bootstrap` |
| 2 | mise 本体を導入 | `make -f mise.mk bootstrap` |
| 3 | mise 管理ツールの導入＋ dotfile の symlink | `make -f mise.mk install` |
| 4 | Brewfile のパッケージを一括導入 | `make -f brew.mk install` |
| 5 | Vim プラグイン導入 | vim を起動して `:source ~/.vimrc` |

### 1. Homebrew 本体の導入

```bash
make -f brew.mk bootstrap   # brew が無ければ公式インストーラを実行（既にあれば brew update）
```

### 2. mise 本体の導入

各種ツール（言語ランタイム、CLI ユーティリティなど）は [mise](https://mise.jdx.dev/) で管理する。

```bash
make -f mise.mk bootstrap   # mise 本体をインストール（既にあれば self-update）
```

### 3. mise 管理ツールの導入と dotfile の symlink

```bash
make -f mise.mk install     # mise.toml に定義されたツールを一括インストール
```

`mise install` 実行時に postinstall フックとして `link.sh` が自動で動き、シェル・エディタの設定が `$HOME` に symlink される（`mise.toml` の `[hooks]` 参照）。そのため通常はこの手順だけでツール導入と dotfile の配置が完了する。

`link.sh` を単独で再実行することも可能。

```bash
./link.sh
```

symlink される対象は `link.sh` を参照すること（`.zshrc`、`.bashrc`、`.bash_profile`、`.bash_aliases`、`.vimrc`、`.ideavimrc`、`.fzf.zsh`、`.fzf.bash` など）。

### 4. Homebrew パッケージの導入

`Brewfile` のパッケージを一括インストールする。

```bash
make -f brew.mk install
```

Brewfile の `go "..."` ディレクティブは `go install` を内部で呼び出すため、Step 3 で mise の `go` がインストール済みであることが前提となる。

### 5. Vim プラグイン

vim を起動して以下を実行すると、`dein.toml` のプラグインが導入される。

```vim
:source ~/.vimrc
```

### 6. Claude Code 設定

`claude/` 配下の設定は Claude Code 側のグローバル設定ディレクトリ（`~/.claude/`）にリンクして利用する。詳細は `claude/CLAUDE.md` を参照。

## 運用ルール

リポジトリ運用上の原則（シークレット管理、冪等性、シンプル優先など）は `CLAUDE.md` にまとめている。
