#!/bin/bash

function lnfile () {
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
  TMUX_SCRITP_DIR=$CURRENT_DIR/tools/tmux

  if [ -e $MY_ZSHRC ]; then
    if "${FORCE_FLAG}"; then
      rm $MY_ZSHRC
      touch $MY_ZSHRC
      echo "alias tm='$TMUX_SCRITP_DIR/change_tmux_mode.sh "MAIN"'" >> $MY_ZSHRC
      echo "alias ts='$TMUX_SCRITP_DIR/change_tmux_mode.sh "SUB"'" >> $MY_ZSHRC
      echo "$MY_ZSHRC is recreated !"
    else
      echo "$MY_ZSHRC already exists."
    fi
  else
    touch $MY_ZSHRC
    echo "alias tm='$TMUX_SCRITP_DIR/change_tmux_mode.sh "MAIN"'" >> $MY_ZSHRC
    echo "alias ts='$TMUX_SCRITP_DIR/change_tmux_mode.sh "SUB"'" >> $MY_ZSHRC
    echo "$MY_ZSHRC is created !"
  fi
}

function makedir() {
  TARGET_DIR=$1

  if [ -d $TARGET_DIR ]; then
    echo "$TARGET_DIR already exists."
  else
    mkdir $TARGET_DIR
    echo "$TARGET_DIR is created!"
  fi
}

# 各ディレクトリの定義
CURRENT_DIR=`pwd -P`
CONF_DIR=~/.config
NVIM_DIR=~/.config/nvim

#-----------
# main
#-----------
FORCE_FLAG=false
while getopts f option
do
  case $option in
    f)
      FORCE_FLAG=true
      ;;
    \?)
      echo "This is unexpected option." 1>&2
      exit 1
      ;;
  esac
done

# vim, zsh, tmux の設定ファイルのシンボリックリンクを作成
lnfile $CURRENT_DIR/vimrc $HOME/.vimrc
lnfile $CURRENT_DIR/zshrc $HOME/.zshrc
lnfile $CURRENT_DIR/tmux.conf $HOME/.tmux.conf

# 自作のスクリプトへのパスを通すために，パスを記述したファイルを動的に生成
create_my_zshrc

# nvim 向けのディレクトリを作成
makedir $CONF_DIR
makedir $NVIM_DIR

# nvim 向けのファイルのシンボリックリンクを配置
lnfile $CURRENT_DIR/nvim/init.vim $NVIM_DIR/init.vim
lnfile $CURRENT_DIR/nvim/nvim-vimplug.vim $NVIM_DIR/nvim-vimplug.vim

