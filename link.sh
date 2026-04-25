#!/bin/sh
# Create dotfile symlinks into $HOME. Idempotent: skips existing non-symlinks.
set -eu

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

link() {
    src="$1"
    dst="$2"
    if [ ! -e "$src" ]; then
        echo "[miss] $src does not exist" >&2
        return
    fi
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "[skip] $dst exists as a regular file" >&2
        return
    fi
    ln -sfn "$src" "$dst"
    echo "[link] $dst -> $src"
}

link "$DOTFILES/zsh/.zshrc"             "$HOME/.zshrc"
link "$DOTFILES/bash/.bashrc"           "$HOME/.bashrc"
link "$DOTFILES/bash/.bash_profile"     "$HOME/.bash_profile"
link "$DOTFILES/bash/.bash_aliases"     "$HOME/.bash_aliases"
link "$DOTFILES/bash/.bash_gnu_aliases" "$HOME/.bash_gnu_aliases"
link "$DOTFILES/bash/.bash_bsd_aliases" "$HOME/.bash_bsd_aliases"
link "$DOTFILES/vim/.vimrc"             "$HOME/.vimrc"
link "$DOTFILES/.ideavimrc"             "$HOME/.ideavimrc"
link "$DOTFILES/.fzf.zsh"               "$HOME/.fzf.zsh"
link "$DOTFILES/.fzf.bash"              "$HOME/.fzf.bash"
