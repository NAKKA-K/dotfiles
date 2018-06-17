#!/bin/bash

if [ -f ~/.bashrc ]; then
    cat ~/dotfiles/bash/.bashrc >> ~/.bashrc
else
    ln -si ~/dotfiles/bash/.bashrc ~/.bashrc
fi
ln -si ~/dotfiles/bash/.bash_aliases ~/.bash_aliases
ln -si ~/dotfiles/bash/.bash_gnu_aliases ~/.bash_gnu_aliases
ln -si ~/dotfiles/bash/.bash_bsd_aliases ~/.bash_bsd_aliases
