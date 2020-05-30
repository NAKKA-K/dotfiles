if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# os type case settings
case "${OSTYPE}" in
darwin*)
    echo 'darwin: BSD type'
    if [ -f ~/.bash_bsd_aliases ]; then
        . ~/.bash_bsd_aliases
    fi
    ;;
linux*)
    echo 'linux: GNU type'
    if [ -f ~/.bash_gnu_aliases ]; then
        . ~/.bash_gnu_aliases
    fi
    ;;
esac

# prompt settings
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    # 出力の後に改行を入れる
    printf '\n'
  fi
}
PROMPT_COMMAND='add_line'

export PS1='\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w \[\e[1;32m $(__git_ps1 "(%s)") \[\e[0m\]\$ '

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/nakka-k/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;
