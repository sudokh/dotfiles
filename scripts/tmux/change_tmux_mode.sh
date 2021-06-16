#!/bin/sh

set -e

# 引数の個数が1つでない場合は終了
if [ $# != 1 ]; then
  echo "Argument is required !"
  exit 1
fi

MAIN_COLOR="colour66"
MAIN_PREFIX_KEY="C-k"
SUB_COLOR="colour166"
SUB_PREFIX_KEY="C-s"
TMUX_MODE_MAIN='TMUX_MODE="MAIN"'
TMUX_MODE_SUB='TMUX_MODE="SUB"'

cp ~/.tmux.conf ~/tmp_tmux_conf

if grep 'TMUX_MODE="MAIN"' ~/tmp_tmux_conf >/dev/null; then
  TMUX_MODE="MAIN"
else
  TMUX_MODE="SUB"
fi

if [ $1 = "MAIN" ]; then
  if [ $TMUX_MODE = "MAIN" ]; then
    tmux source ~/tmp_tmux_conf
    echo "Setting Changed ! (-> MAIN)"
  else
    sed -i -e "s/$SUB_COLOR/$MAIN_COLOR/" ~/tmp_tmux_conf
    sed -i -e "s/$SUB_PREFIX_KEY/$MAIN_PREFIX_KEY/" ~/tmp_tmux_conf
    sed -i -e "s/$TMUX_MODE_SUB/$TMUX_MODE_MAIN/" ~/tmp_tmux_conf
    tmux source ~/tmp_tmux_conf
    echo "Setting Changed ! (-> MAIN)"
  fi
else
  if [ $TMUX_MODE = "SUB" ]; then
    tmux source ~/tmp_tmux_conf
    echo "Setting Changed ! (-> SUB)"
  else
    sed -i -e "s/$MAIN_COLOR/$SUB_COLOR/" ~/tmp_tmux_conf
    sed -i -e "s/$MAIN_PREFIX_KEY/$SUB_PREFIX_KEY/" ~/tmp_tmux_conf
    sed -i -e "s/$TMUX_MODE_MAIN/$TMUX_MODE_SUB/" ~/tmp_tmux_conf
    tmux source ~/tmp_tmux_conf
    echo "Setting Changed ! (-> SUB)"
  fi
fi

rm ~/tmp_tmux_conf

