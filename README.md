# dotfiles

シェル・エディタ・Claude Code などの個人用設定をまとめたリポジトリ。

## ディレクトリ構成

| パス | 内容 |
|------|------|
| `bash/` | bash の設定（`.bashrc`、`.bash_profile`、エイリアス各種） |
| `zsh/` | zsh の設定（`.zshrc`） |
| `vim/` | vim の設定（`.vimrc` ほか） |
| `claude/` | Claude Code のグローバル設定（`CLAUDE.md`、`rules/`、`skills/`、`commands/`、`settings.json`） |
| `Brewfile` | Homebrew で管理するパッケージ |
| `mise.toml` / `mise.mk` | mise で管理するツール定義と bootstrap／install 用の Makefile |
| `.fzf.bash` / `.fzf.zsh` | fzf の設定 |
| `.ideavimrc` | IdeaVim の設定 |
| `link.sh` | 上記設定を `$HOME` に symlink するスクリプト |

## セットアップ

### 1. mise のインストールとツール導入

各種ツール（言語ランタイム、CLI ユーティリティなど）は [mise](https://mise.jdx.dev/) で管理する。`mise.mk` に bootstrap / install のターゲットを定義しているので、make 経由で実行する。

```bash
make -f mise.mk bootstrap   # mise 本体をインストール（既にあれば self-update）
make -f mise.mk install     # mise.toml に定義されたツールを一括インストール
```

`mise install` 実行時に postinstall フックとして `link.sh` が自動で動き、シェル・エディタの設定が `$HOME` に symlink される（`mise.toml` の `[hooks]` 参照）。そのため通常はこの手順だけでツール導入と dotfile の配置が完了する。

`link.sh` を単独で再実行することも可能。

```bash
./link.sh
```

symlink される対象は `link.sh` を参照すること（`.zshrc`、`.bashrc`、`.bash_profile`、`.bash_aliases`、`.vimrc`、`.ideavimrc`、`.fzf.zsh`、`.fzf.bash` など）。

### 2. Vim プラグイン

vim を起動して以下を実行すると、`dein.toml` のプラグインが導入される。

```vim
:source ~/.vimrc
```

### 3. Homebrew パッケージ

`Brewfile` のパッケージを一括インストールする場合は以下を実行する。

```bash
brew bundle --file=Brewfile
```

### 4. Claude Code 設定

`claude/` 配下の設定は Claude Code 側のグローバル設定ディレクトリ（`~/.claude/`）にリンクして利用する。詳細は `claude/CLAUDE.md` を参照。

## 運用ルール

リポジトリ運用上の原則（シークレット管理、冪等性、シンプル優先など）は `CLAUDE.md` にまとめている。
