#!/bin/bash

function hidden_lnfile () {
  DEST_FILE=$2/.$1
  SRC_FILE=$CURRENT_DIR/$1

  common_lnfile $SRC_FILE $DEST_FILE
}

function lnfile () {
  DEST_FILE=$2/$1
  SRC_FILE=$CURRENT_DIR/$1

  common_lnfile $SRC_FILE $DEST_FILE
}

function common_lnfile () {
  SRC_FILE=$1
  DEST_FILE=$2

  if [ -e $DEST_FILE ]; then
    echo "$DEST_FILE already exists."
  else
    ln -s $SRC_FILE $DEST_FILE
    echo "$DEST_FILE is installed !"
  fi
}


function create_my_zshrc () {
  MY_ZSHRC=$HOME/.`whoami`_zshrc
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

function MAKEDIR() {
  TARGET_DIR=$1

  if [ -d $TARGET_DIR ]; then
    echo "$TARGET_DIR already exists."
  else
    mkdir $TARGET_DIR
    echo "$TARGET_DIR is created!"
  fi
}


CURRENT_DIR=`pwd -P`
#HOME=~
CONFIG_DIR=~/.config
NVIM_DIR=$CONFIG_DIR/nvim
DEIN_DIR=~/.cache/dein


#-----------
# main
#-----------
# vim, zsh, tmux の設定ファイルのシンボリックリンクを作成
hidden_lnfile vimrc $HOME
hidden_lnfile zshrc $HOME
hidden_lnfile tmux.conf $HOME

# 自作のスクリプトへのパスを通すために，パスを記述したファイルを動的に生成
create_my_zshrc

# nvim 向けのディレクトリを作成
MAKEDIR $CONFIG_DIR
MAKEDIR $NVIM_DIR
MAKEDIR $DEIN_DIR

lnfile nvim/init.vim $CONFIG_DIR
lnfile nvim/dein.toml $CONFIG_DIR

# deinを未インストールの場合は，インストール
if [ -z "$(ls $DEIN_DIR)" ]; then
  cd $NVIM_DIR
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  sh ./installer.sh ~/.cache/dein
else
  echo "dein is already installed"
fi

