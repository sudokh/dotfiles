#!bin/bash

function lnfile () {
  if [ ! -e $1 ]; then
    ln -s $HOME/.dotfiles/$1 $HOME/$1
    echo "$1 is installed !"
  else
    echo "$1 exists."
  fi
}

lnfile .zshrc
lnfile .tmux.conf

source $HOME/.zshrc

