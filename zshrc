#!/bin/zsh
#--------------------------------------
# .zshrc
# Maintained by SUDO Kohei
#
# * References
#  - Options Index (zsh)
#     https://thuis.roelschroeven.net/doc/zsh-doc/html/Options-Index.html
#--------------------------------------
MY_ZSHRC=".`whoami`_zshrc"
if [ -e ~/$MY_ZSHRC ] ; then
  source ~/$MY_ZSHRC
else
fi

#---------------------------------------
# Normal
#---------------------------------------
#-- locale --#
#{{{
export LANG=ja_JP.UTF-8
# 文字の判定・操作・文字数のカウント
export LC_CTYPE=ja_JP.UTF-8
# メッセージの言語
export LC_MESSAGES=en_US.UTF-8
# 日付・時刻
export LC_TIME=en_US.UTF-8
#}}}

#-- Prompt --#
#{{{
_prompt_colors=(
  "%F{white}"   # ユーザ名，ドメイン名，ブランチ名
  "%F{green}"   # at, in
  "%F{cyan}"    # path
  "%F{blue}"    # unstaged fileがあるとき
  "%F{red}"     # staged fileがあるとき
  "%F{magenta}" # untracked fileがあるとき
)

# Define PROMPT
PROMPT="
${_prompt_colors[1]}%n%f \
${_prompt_colors[2]}at%f \
${_prompt_colors[1]}%m%f \
${_prompt_colors[2]}in \
${_prompt_colors[3]}%~%f
> "
#"'${editor_info[keymap]}> '

# Define RPROMPT
RPROMPT='${vcs_info_msg_0_}'

# tab補完を有効化
autoload -U compinit && compinit

# Add hook for calling vcs_info before each command.
# add-zsh-hook <hook_name> <func_name>
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

add-zsh-hook precmd prompt_precmd

function prompt_precmd {
  # Check for untracked files or updated submodules since vcs_info does not.
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    branch_format="[${_prompt_colors[1]}%b%f%u%c${_prompt_colors[6]}@%f]"
  else
    branch_format="[${_prompt_colors[1]}%b%f%u%c]"
  fi

  zstyle ':vcs_info:*' formats "${branch_format}"

  vcs_info
}

# Formats:
#   %b - branchname
#   %u - unstagedstr (see below)
#   %c - stagedstr (see below)
#   %a - action (e.g. rebase-i)
local branch_format="(${_prompt_colors[1]}%b%f%u%c)"
local action_format="(${_prompt_colors[3]}%a%f)"
local unstaged_format="${_prompt_colors[4]}@%f"
local staged_format="${_prompt_colors[5]}@%f"

# Set vcs_info parameters.
## gitのチェックを有効化
zstyle ':vcs_info:*' enable git
## commitしていない変更をチェック
zstyle ':vcs_info:*' check-for-changes true
## addしていない変更があるときのフォーマット
zstyle ':vcs_info:*' unstagedstr "${unstaged_format}"
## commitしていないstageがあるときのフォーマット
zstyle ':vcs_info:*' stagedstr "${staged_format}"
## 特別な状況(コンフリクトの発生時など)のときのフォーマット
zstyle ':vcs_info:*' actionformats "${branch_format}${action_format}"
## actionformatsが適用されないとき(＝通常)のフォーマット
zstyle ':vcs_info:*' formats "${branch_format}"
## Gitと関係ないディレクトリ(No Version Control System)のときのフォーマット
zstyle ':vcs_info:*' nvcsformats   ""

# コンソールのタイトルを設定
case "${TERM}" in
	kterm*|xterm*|terminal*)
		precmd() {
			echo -ne "\033]0;-zsh : ${USER}@${HOST%%.*} : ${PWD}\007"
		}
		;;
esac


#}}}

#---------------------------------------
# Key Mapping
#---------------------------------------
#-- Alias --#
#{{{
## ls
case ${OSTYPE} in
  # for Linux
  linux*)
    alias ls='ls --color=auto'
    ;;
  # for Mac
  darwin*)
    alias ls='ls -GF'
    ;;
esac
alias la='ls -a'
alias ll='ls -lh'
alias lla='ll -a'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43'
#export LSCOLORS=exfxcxdxbxGxDxabagacad

## git
alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
alias gst='git status'
alias gco='git checkout'
alias gf='git fetch'
alias gc='git commit'

## docker
alias d='docker'
alias dp='docker ps'
alias de='docker exec -it'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcr='docker-compose restart'

## dotfile
alias zso='source ~/.zshrc'
alias tmux='tmux -u'
alias tso='tmux source ~/.tmux.conf'
alias tmain='change_tmux_mode "MAIN"'
alias tsub='change_tmux_mode "SUB"'
#}}}

#-- bindkey --#
#{{{
# vi-style key bindings
bindkey -v
# use Ctrl-r for history in vi mode
bindkey '^R' history-incremental-search-backward
# DELETE key
bindkey "^[[3~" delete-char
# HOME key
bindkey "^[[1~" beginning-of-line
# END key
bindkey "^[[4~" end-of-line

# Use Ctrl-Z as fg
bindkey '^Z' fancy-ctrl-z
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
#}}}


#---------------------------------------
# Option
#---------------------------------------
#-- setopt --#
#{{{
# 補完後に末尾に移動
setopt noalwaystoend

# cdなしでディレクトリを移動
setopt autocd
# cd後にカレントディレクトリをpushd
setopt autopushd
# サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt autoresume
# バックグラウンドジョブの優先度を上げる
setopt nobgnice
# "*"などのパス名展開で大文字小文字を区別しない
setopt nocaseglob
# シェル終了時に子プロセスに HUP を送らない
setopt nocheckjobs nohup
# リダイレクトによる上書きを許可しない
setopt noclobber
# 濁点・半濁点を扱う
setopt combiningchars
# コマンドのスペルミスを指摘
setopt correct
# フロー制御(C-s, C-q)を無効
setopt noflowcontrol
# コマンドにコメントを付与可能
setopt interactivecomments
# PROMPT変数の中の変数参照を表示時に展開
setopt promptsubst
# directory stackに同一のディレクトリをpushしない
setopt pushdignoredups
# pushdまたはpopdの後にdirectory stackを表示しない
setopt pushdsilent
# ビープ音を鳴らさないようにする
setopt no_beep
# 末尾から自動的に / を除かない
setopt noautoremoveslash
# カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt always_last_prompt
# 単語の途中でもカーソル位置で補完
setopt completeinword
# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
# 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt list_types
# 補完キー連打で順に補完候補を自動で補完
setopt auto_menu
# カーソル位置で補完する。
setopt complete_in_word
# 補完候補を一覧表示にする
setopt auto_list
# --prefix=~/localというように「=」の後でも
# 「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst
# 拡張globを有効にする。
# glob中で「(#...)」という書式で指定する。
setopt extended_glob
# コマンドのヒストリファイルに実行時間も記録
setopt extendedhistory
# ヒストリファイルに上書きせずに追加(毎回ヒストリファイルを作成しない)
setopt appendhistory
# historyの保存先
export HISTFILE=$HOME/.zsh_history
# メモリに保存するhistoryの件数(検索対象)
export HISTSIZE=1000
# ファイルに保存するhistoryの件数
export SAVEHIST=100000
# ヒストリがいっぱいのとき、最も古いコマンド行から削除
setopt histexpiredupsfirst
# 重複するコマンド行は古い方を削除
setopt histignorealldups
# 直前と同じコマンドはヒストリに追加しない
setopt histignoredups
# 重複するコマンド行は保存しない
setopt histsavenodups
# シェルのプロセスごとにヒストリを共有
setopt sharehistory
# PROMPTの変数内で"%"から始まる置換機能を有効化
setopt prompt_percent
# コマンド実行後は右プロンプトを消す
setopt transient_rprompt
#}}}

#-- completion --#
#{{{
# 補完候補をハイライト
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:messages' format '%B%F{yellow}%d%f%b'$DEFAULT
zstyle ':completion:*:warnings' format '%B%F{red}No matches for: %f%b''%B%F{yellow}%d%f%b'$DEFAULT
zstyle ':completion:*:corrections' format '%B%F{yellow}%d%f %F{red}(errors: %e)%f%b'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{yellow}%BCompleting %d:%b%f'$DEFAULT
zstyle ':completion:*:options' description 'yes'
# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''
# オブジェクトファイルとか中間ファイルとかはfileとして補完させない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~'
# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true
# 変数の添字を補完する
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# 補完候補についてもカラーを設定
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# 補完候補がなければより曖昧に候補を探す。
#   m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完方法の設定。指定した順番に実行する。
#   _oldlist 前回の補完結果を再利用する。
#   _complete: 補完する。
#   _match: globを展開しないで候補の一覧から補完する。
#   _ignored: 補完候補にださないと指定したものも補完候補とする。
#  _approximate: 似ている補完候補も補完候補とする。
#  _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix
## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
## 詳細な情報を使う。
zstyle ':completion:*' verbose yes

# host名の補完
print_known_hosts()
{
  if [ -f $HOME/.ssh/known_hosts ]; then
    cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
  fi
}
_cache_hosts=($( print_known_hosts ))

hosts=( ${(@)${${(M)${(s:# :)${(zj:# :)${(Lf)"$([[ -f ~/.ssh/config ]] \
&& < ~/.ssh/config)"}%%\#*}}##host(|name) *}#host(|name) }/\*} )
#}}}

#---------------------------------------
# Environment variable
#---------------------------------------
#{{{
# for nvim
export XDG_CONFIG_HOME="$HOME/.config"
# for pyenv
eval "$(pyenv init --path)"
#}}}

#---------------------------------------
# Other
#---------------------------------------
#-- others --#
#{{{
#
# コンソールのタイトルを設定
case "${TERM}" in
	kterm*|xterm*|terminal*)
		precmd() {
			echo -ne "\033]0;-zsh : ${USER}@${HOST%%.*} : ${PWD}\007"
		}
		;;
esac
#}}}

#-- for surface --#
#{{{
## battery script
#export PATH="$PATH:$HOME/.dotfiles/scripts/tmux"
#
## for $WINHOME, $GVIM, $MINGW, etc
#source $HOME/.mysetting.sh
#
## for WSL, Windows Terminal, and Gvim
#export WINTERM="$WINHOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
#
## gvim alias
#alias gvim='(){
#$GVIM/gvim.exe --remote-tab-silent $1 1>/dev/null 2>&1 &
#}'
#
## gcc alias
#alias gcc="$MINGW/bin/gcc.exe"
#
## wsl-open alias
#alias open='wsl-open'
#}}}
