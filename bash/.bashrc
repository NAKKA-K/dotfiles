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
