if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export GOPATH="$HOME/dev/go"
export PATH="$GOPATH/bin:$PATH"

export PATH=$PATH:$HOME/.composer/vendor/bin

export PATH="/usr/local/opt/openssl/bin:$PATH"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

eval "$(direnv hook bash)"
eval "$(mise activate bash)"

[ -f ~/dotfiles/.fzf.bash ] && source ~/dotfiles/.fzf.bash
