if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export GOPATH="$HOME/dev/go"
export PATH="$GOPATH/bin:$PATH"

PYENV_ROOT=~/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
