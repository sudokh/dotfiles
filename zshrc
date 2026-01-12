#!/bin/zsh
#--------------------------------------
# .zshrc
# Maintained by SUDO Kohei
# Updated for High Portability (Mac/Linux/WSL)
#--------------------------------------

# マシン固有設定
MY_ZSHRC=".`whoami`_zshrc"
[ -e ~/$MY_ZSHRC ] && source ~/$MY_ZSHRC

#---------------------------------------
# Basic Settings
#---------------------------------------
export LANG=ja_JP.UTF-8
# パス等の設定
export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$HOME/Project/go"
export NVM_DIR="$HOME/.nvm"
# ヒストリ設定
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000

#---------------------------------------
# Zsh Modules & Options
#---------------------------------------
autoload -Uz compinit && compinit
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least

# --- [追加機能 1] CDR (Recent Directories) ---
# 過去に移動したディレクトリを記録し、`cdr`コマンドで移動できるようにする
# 外部ツール(zoxide等)がない環境での代替手段
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
# キャッシュディレクトリがない場合は作成
[ -d "$HOME/.cache/shell" ] || mkdir -p "$HOME/.cache/shell"

# --- Option ---
setopt noalwaystoend
setopt autocd
setopt autopushd
setopt autoresume
setopt nobgnice
setopt nocaseglob
setopt nocheckjobs nohup
setopt noclobber
setopt combiningchars
# setopt correct          # 不要: 開発時の誤判定防止のため無効化推奨
setopt noflowcontrol
setopt interactivecomments
setopt promptsubst
setopt pushdignoredups
setopt pushdsilent
setopt no_beep
setopt noautoremoveslash
setopt always_last_prompt
setopt completeinword
setopt auto_param_slash
setopt list_types
setopt auto_menu
setopt complete_in_word
setopt auto_list
setopt magic_equal_subst
setopt extended_glob
setopt extendedhistory
setopt appendhistory
setopt histexpiredupsfirst
setopt histignorealldups
setopt histignoredups
setopt histsavenodups
setopt sharehistory
setopt prompt_percent
setopt transient_rprompt

#---------------------------------------
# Appearance (Prompt & LS Colors)
#---------------------------------------
# 色設定
_prompt_colors=(
  "%F{white}"   # 1: User/Host
  "%F{green}"   # 2: Text
  "%F{cyan}"    # 3: Path
  "%F{blue}"    # 4: Unstaged
  "%F{red}"     # 5: Staged
  "%F{magenta}" # 6: Untracked
)

# プロンプト定義 (直前のコマンドが失敗したら赤色の矢印を出す機能を追加)
PROMPT="
${_prompt_colors[1]}%n%f \
${_prompt_colors[2]}at%f \
${_prompt_colors[1]}%m%f \
${_prompt_colors[2]}in \
${_prompt_colors[3]}%~%f
%(?.%F{green}>%f.%F{red}>%f) " 

RPROMPT='${vcs_info_msg_0_}'

# vcs_info設定
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "${_prompt_colors[4]}@%f"
zstyle ':vcs_info:*' stagedstr "${_prompt_colors[5]}@%f"
zstyle ':vcs_info:*' nvcsformats ""

# Hook関数
function my_precmd_vcs() {
    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        local branch_format="[${_prompt_colors[1]}%b%f%u%c${_prompt_colors[6]}@%f]"
    else
        local branch_format="[${_prompt_colors[1]}%b%f%u%c]"
    fi
    zstyle ':vcs_info:*' formats "${branch_format}"
    zstyle ':vcs_info:*' actionformats "${branch_format}(${_prompt_colors[3]}%a%f)"
    vcs_info
}

function my_precmd_window_title() {
    case "${TERM}" in
        kterm*|xterm*|terminal*|rxvt*|screen*|tmux*)
            print -Pn "\e]2; %n@%m: %~\a" ;;
    esac
}
add-zsh-hook precmd my_precmd_vcs
add-zsh-hook precmd my_precmd_window_title

# LS Colors
export LSCOLORS=Gxfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43'

#---------------------------------------
# Key Bindings & Aliases
#---------------------------------------
bindkey -v

# --- [追加機能 2] Smart History Search ---
# 入力した文字列に一致する履歴だけを矢印キーで遡る
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# Viモードのコマンドモード時だけでなく、インサートモードの矢印キーにも割り当て
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# 標準的なキーバインド
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey '^R' history-incremental-search-backward

# Ctrl-Z でフォアグラウンド復帰
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
bindkey '^Z' fancy-ctrl-z

# Aliases
case ${OSTYPE} in
  darwin*) alias ls='ls -GF' ;;
  linux*)  alias ls='ls --color=auto' ;;
esac
alias la='ls -a'
alias ll='ls -lh'
alias lla='ll -a'

# Git Aliases
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

# Docker Aliases
alias d='docker'
alias dp='docker ps'
alias de='docker exec -it'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'

# Utils
alias zso='source ~/.zshrc'
alias tmux='tmux -u'

# 安全対策 (上書き確認)
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# --- Functions ---

# Smart Open
o() {
    local target="${1:-.}"
    if [[ "$OSTYPE" == "darwin"* ]]; then open "$target"
    elif [[ -n "$WSL_DISTRO_NAME" ]]; then explorer.exe "$target"
    elif command -v xdg-open > /dev/null; then xdg-open "$target"
    else echo "No suitable open command found."
    fi
}

# [追加機能 3] Universal Extract
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Path Adder
function add_path() { [ -d "$1" ] && export PATH="$1:$PATH"; }
add_path "$HOME/.nodebrew/current/bin"
unset -f add_path

#---------------------------------------
# Completion Settings
#---------------------------------------
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes
# 補完時の説明を見やすく
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for:%f %d'

# Host completion
if [ -f $HOME/.ssh/known_hosts ]; then
    zstyle ':completion:*' hosts $( cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1 )
fi

# Tools (Safety Check)
if (( $+commands[uv] )); then
    eval "$(uv generate-shell-completion zsh)"
    _uv_run_mod() {
      if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files'
      else
        _uv "$@"
      fi
    }
    compdef _uv_run_mod uv
fi
source "$HOME/.local/bin/env"
