"---------------------------------------
" init.vim
" Maintained by SUDO Kohei
"---------------------------------------

"---------------------------------------
" dein.vim
"---------------------------------------
"{{{
let s:dein_dir = $HOME . '/.cache/dein'
let s:toml_dir  = $HOME . '/.config/nvim'
let s:toml = s:toml_dir . '/dein.toml'
let s:lazy_toml = s:toml_dir . '/lazy.toml'

if &compatible
  set nocompatible               " Be iMproved
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

  " load toml
  call dein#load_toml(s:toml,{'lazy':0})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
"}}}

source $HOME/.vimrc

