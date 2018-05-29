alias grep='grep --color=auto'


alias brname='git symbolic-ref --short HEAD'
alias ga="git add"
alias gcm="git commit -m"
alias gd="git diff"
alias gs="git status"
alias gb="git branch"
alias gpush="git push origin HEAD"
alias gpull="git pull origin $(brname)"

git config --global alias.lol 'log --graph --oneline --decorate=full --date=short --format="%C(yellow)%h%C(reset) %C(magenta)[%ad]%C(reset)%C(auto)%d%C(reset) %s %C(cyan)@%an%C(reset)"'
