# dotfiles

シェル・エディタ・Claude Code などの個人用設定をまとめたリポジトリ。

## 対応環境

| 環境 | 状態 | 備考 |
|------|------|------|
| macOS | フル対応 | Homebrew・cask・Brewfile を含むすべてが利用可能 |
| WSL2 (Ubuntu/Debian 系) | 部分対応 | mise／link.sh／一部の Brewfile はそのまま利用可能。cask・macOS 専用アプリは対象外 |

`bash/.bashrc` は `OSTYPE` を判定して macOS は `.bash_bsd_aliases`、Linux (WSL2 含む) は `.bash_gnu_aliases` を読み込む。OS 固有の差分はその 2 ファイルに閉じる方針。

## ディレクトリ構成

| パス | 内容 |
|------|------|
| `bash/` | bash の設定（`.bashrc`、`.bash_profile`、エイリアス各種） |
| `zsh/` | zsh の設定（`.zshrc`） |
| `vim/` | vim の設定（`.vimrc` ほか） |
| `claude/` | Claude Code のグローバル設定（`CLAUDE.md`、`rules/`、`skills/`、`commands/`、`settings.json`） |
| `Brewfile` | Homebrew で管理するパッケージ（macOS 前提） |
| `mise.toml` / `mise.mk` | mise で管理するツール定義と bootstrap／install 用の Makefile |
| `.fzf.bash` / `.fzf.zsh` | fzf の設定 |
| `.ideavimrc` | IdeaVim の設定 |
| `link.sh` | 上記設定を `$HOME` に symlink するスクリプト |

## セットアップ

### 1. mise のインストールとツール導入（macOS / WSL2 共通）

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

### 2. Vim プラグイン（macOS / WSL2 共通）

vim を起動して以下を実行すると、`dein.toml` のプラグインが導入される。

```vim
:source ~/.vimrc
```

### 3. パッケージインストール

#### 3a. macOS

`Brewfile` のパッケージを一括インストールする。

```bash
brew bundle --file=Brewfile
```

`Brewfile` には formula／cask／VSCode 拡張／Go tools がまとまっており、macOS ではこれだけで網羅できる。

#### 3b. WSL2

WSL2 では Homebrew (Linuxbrew) も導入は可能だが、`Brewfile` に含まれる `cask` (Raycast、Warp、aws-vault-binary など) は macOS 専用なので利用できない。また Linuxbrew は GUI アプリ系の依存解決が macOS と異なり、衝突や容量肥大の原因になりやすい。そのため WSL2 では以下のように使い分けることを推奨する。

- 言語ランタイム・CLI ユーティリティの大半は **mise (`mise.toml`) で導入済み**なので追加作業は不要
- `Brewfile` に列挙されている formula のうち WSL2 でも欲しいもの（例: `coreutils`、`gnupg`、`pre-commit`、`git-extras`、`vim`、`mysql` など）は **`apt` で代替**する
- `cask` は対象外（macOS GUI アプリは対象 OS で別途インストールする。Raycast / Warp などは Windows 側、または Windows 用の代替ツールを使う）
- VSCode 拡張は **VSCode の Sync Settings 機能** で WSL 側にも展開する（または `code --install-extension <id>` で個別導入）
- Go tools は WSL2 上の Go (mise 管理) を使って **`go install` で個別導入**する

apt での代替例。

```bash
sudo apt update
sudo apt install -y coreutils gnupg pre-commit git-extras vim mysql-client
```

Linuxbrew をどうしても使いたい formula が出てきた場合は、対象を絞って手動インストールするのがよい (`brew install <formula>`)。`brew bundle --file=Brewfile` をそのまま実行すると cask が原因で失敗するため非推奨。

### 4. Claude Code 設定（macOS / WSL2 共通）

`claude/` 配下の設定は Claude Code 側のグローバル設定ディレクトリ（`~/.claude/`）にリンクして利用する。`link.sh` が symlink を張るため、`mise install` または `./link.sh` の実行で自動的に有効化される。詳細は `claude/CLAUDE.md` を参照。

## 運用ルール

リポジトリ運用上の原則（シークレット管理、冪等性、シンプル優先など）は `CLAUDE.md` にまとめている。
