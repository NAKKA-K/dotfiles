eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:/usr/local/bin"
export PATH="~/bin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH
# export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export GOPATH=$HOME/dev/go
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
# export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export GPG_TTY=$TTY

# eval "$(anyenv init -)"
eval "$(direnv hook zsh)"
eval "$(rbenv init - zsh)"
source "$HOME/.rye/env"

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/sh-nakamura/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sh-nakamura/Downloads/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
# if [ -f '/Users/sh-nakamura/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sh-nakamura/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit -u
complete -o nospace -C /usr/local/bin/terraform terraform


# ===== Alias =====
alias be='bundle exec'

alias ls="ls -G"
alias la="ls -laG"
alias grep='grep --color=auto'

alias brname='git symbolic-ref --short HEAD'
alias gpull="git pull origin master"
alias gpush="git push origin HEAD"
alias ga="git add"
alias gcm="git commit -m"
alias gd="git diff"
alias gs="git status"
alias gb="git branch"
alias gcb="git checkout -b"
alias gbd="git delete-squashed-branches master"

git config --global alias.lol 'log --graph --oneline --decorate=full --date=short --format="%C(yellow)%h%C(reset) %C(magenta)[%ad]%C(reset)%C(auto)%d%C(reset) %s %C(cyan)@%an%C(reset)"'

# ===== Function =====
sshf() {
    local sshLoginHost
    sshLoginHost=`cat ~/.ssh/config | grep -i ^host | awk '{print $2}' | fzf`

    if [ "$sshLoginHost" = "" ]; then
        # ex) Ctrl-C.
        return 1
    fi

    ssh ${sshLoginHost}
}
export PATH="/opt/homebrew/opt/php@8.0/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.0/sbin:$PATH"

. /opt/homebrew/opt/asdf/libexec/asdf.sh
