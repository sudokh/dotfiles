#!/bin/bash

SCRIPT_DIR=`pwd -P`
DEST_DIR="/Users/`whoami`/.config/karabiner/assets/complex_modifications"
isDestDir=""

function check_dest_dir() {
  if [ -d $DEST_DIR ]; then
    echo "True"
  else
    echo "False"
  fi
}

function lnfile() {
  isDestDir=`check_dest_dir`
  if [ $isDestDir = "False" ]; then
    echo "$DEST_DIR not exists."
  else
    if [ -e $DEST_DIR/$1 ]; then
      echo "$DEST_DIR/$1 already exists."
    else
      ln -s $SCRIPT_DIR/$1 $DEST_DIR/$1
      echo "$1 is installed !"
    fi
  fi
}

lnfile sudo_karabiner_rules.json
