#!/bin/bash

function lnfile () {
  if [ -e ~/$1 ]; then
    echo "~/$1 already exists."
  else
    ln -s $SCRIPT_DIR/$1 ~/$1
    echo "$1 is installed !"
  fi
}

SCRIPT_DIR=`pwd -P`
lnfile .vimrc
lnfile .zshrc
lnfile .tmux.conf

