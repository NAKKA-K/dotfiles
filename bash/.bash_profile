if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export GOPATH="$HOME/dev/go"
export PATH="$GOPATH/bin:$PATH"

PYENV_ROOT=~/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH=$PATH:$HOME/.composer/vendor/bin

export PATH="/usr/local/opt/openssl/bin:$PATH"

eval "$(rbenv init -)"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

eval "$(direnv hook bash)"

[ -f ~/dotfiles/.fzf.bash ] && source ~/dotfiles/.fzf.bash
