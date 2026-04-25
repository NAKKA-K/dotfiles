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
| `Makefile` | brew・mise 一括セットアップ用エントリポイント |
| `.fzf.bash` / `.fzf.zsh` | fzf の設定 |
| `.ideavimrc` | IdeaVim の設定 |
| `link.sh` | 上記設定を `$HOME` に symlink するスクリプト |

## セットアップ

### 一括セットアップ

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

### Vim プラグイン

vim を起動して以下を実行すると、`dein.toml` のプラグインが導入される。

```vim
:source ~/.vimrc
```

### Claude Code 設定

`claude/` 配下の設定は Claude Code 側のグローバル設定ディレクトリ（`~/.claude/`）にリンクして利用する。詳細は `claude/CLAUDE.md` を参照。

## 運用ルール

リポジトリ運用上の原則（シークレット管理、冪等性、シンプル優先など）は `CLAUDE.md` にまとめている。
