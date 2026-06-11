# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit && compinit
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:/usr/local/bin"
export PATH="~/bin:$PATH"
export PATH="$GOBIN:$PATH"
export GOPATH=$HOME/dev/go
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export GPG_TTY=$TTY

. "$HOME/.local/bin/env"

eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"

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
alias m='mise run'

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
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
