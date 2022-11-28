export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="~/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
export PS1='
[%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
%F{yellow}$%f '

alias grep='grep --color=auto'
alias be='bundle exec'

alias brname='git symbolic-ref --short HEAD'
alias ga="git add"
alias gcm="git commit -m"
alias gd="git diff"
alias gs="git status"
alias gb="git branch"
alias gcb="git checkout -b"
alias gpush="git push origin HEAD"
alias gpull="git pull origin $(brname)"
alias gbd="git delete-squashed-branches master"

git config --global alias.lol 'log --graph --oneline --decorate=full --date=short --format="%C(yellow)%h%C(reset) %C(magenta)[%ad]%C(reset)%C(auto)%d%C(reset) %s %C(cyan)@%an%C(reset)"'

alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -laG"

HISTSIZE=1000

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export GOPATH=$HOME/dev/go
eval "$(anyenv init -)"

eval "$(direnv hook zsh)"

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/sh-nakamura/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sh-nakamura/Downloads/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
# if [ -f '/Users/sh-nakamura/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sh-nakamura/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

autoload -Uz compinit && compinit -u
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
