#!bin/bash

function lnfile () {
  if [ -e $1 ]; then
    echo "$1 already exists."
  else
    ln -s $HOME/.dotfiles/$1 $HOME/$1
    echo "$1 is installed !"
  fi
}

lnfile .zshrc
lnfile .tmux.conf

source $HOME/.zshrc

