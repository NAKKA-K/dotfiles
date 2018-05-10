#!/bin/bash

cat ~/dotfiles/bash/.bash_profile >> ~/.bash_profile
ln -si ~/dotfiles/bash/.bashrc ~/.bashrc
ln -si ~/dotfiles/bash/.bash_aliases ~/.bash_aliases
ln -si ~/dotfiles/bash/.bash_gnu_aliases ~/.bash_gnu_aliases
ln -si ~/dotfiles/bash/.bash_bsd_aliases ~/.bash_bsd_aliases
