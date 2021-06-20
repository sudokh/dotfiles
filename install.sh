#!/bin/bash

CURRENT_DIR=`pwd -P`
DEST_DIR=~

function lnfile () {
  DEST_FILE=$DEST_DIR/.$1
  SRC_FILE=$CURRENT_DIR/$1

  if [ -e $DEST_FILE ]; then
    echo "$DEST_FILE already exists."
  else
    ln -s $SRC_FILE $DEST_FILE
    echo "$DEST_FILE is installed !"
  fi
}

function create_my_zshrc () {
  MY_ZSHRC=$DEST_DIR/.`whoami`_zshrc
  TMUX_SCRITP_DIR=$CURRENT_DIR/scripts/tmux

  if [ -e $MY_ZSHRC ]; then
    echo "$MY_ZSHRC already exists."
  else
    touch $MY_ZSHRC
    echo "alias tm='$TMUX_SCRITP_DIR/change_tmux_mode.sh "MAIN"'" >> $MY_ZSHRC
    echo "alias ts='$TMUX_SCRITP_DIR/change_tmux_mode.sh "SUB"'" >> $MY_ZSHRC
    echo "$MY_ZSHRC is created !"
  fi
}

lnfile vimrc
lnfile zshrc
lnfile tmux.conf
create_my_zshrc
