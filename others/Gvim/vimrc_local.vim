"#######################################
" vimrc_local.vim
" Maintained by SUDO Kohei
"
" This file is for GVim on Windows
"
" # Config file
" $VIM/
"   - vimrc_local.vim
"   - gvimrc_local.vim
"   - myvimrc.vim
"#######################################
scriptencoding utf-8

"---------------------------------------
" For GVim
"---------------------------------------
"{{{
let g:vimrc_local_finish = 1

" plugins下のディレクトリをruntimepathへ追加する。
for s:path in split(glob($VIM.'/plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

" Encoding
source $VIM/plugins/kaoriya/encode_japan.vim
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,sjis

" Bram氏の提供する設定例をインクルード
set guioptions+=M
source $VIMRUNTIME/vimrc_example.vim
set guioptions-=M

" WinでPATHに$VIMが含まれていないときにexeを見つけ出す
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
set formatexpr=autofmt#japanese#formatexpr()


" vimdoc-ja: 日本語ヘルプを無効化する.
if kaoriya#switch#enabled('disable-vimdoc-ja')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimdoc-ja"'), ',')
endif

" vimproc: 同梱のvimprocを無効化する
if kaoriya#switch#enabled('disable-vimproc')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimproc$"'), ',')
endif

" go-extra: 同梱の vim-go-extra を無効化する
if kaoriya#switch#enabled('disable-go-extra')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]golang$"'), ',')
endif

"}}}


"---------------------------------------
" Private Setting
"---------------------------------------
" 同ディレクトリのローカルファイルから設定を読み込み
if filereadable(expand('$VIM/myvimrc.vim'))
  source $VIM/myvimrc.vim
endif
" 後でmyvimrc.vimに入れる
let $VIM_HOME = 'C:\Users\kohei\Desktop'
" runtimepath
set runtimepath+=$VIM\myplugin\lexima.vim
set runtimepath+=$VIM\myplugin\gruvbox
set runtimepath+=$VIM\myplugin\nerdtree.vim
set runtimepath+=$VIM\myplugin\vim-table-mode.vim
set runtimepath+=$VIM\myplugin\lightline.vim
nnoremap <Leader>d :e +10 $VIM_HOME<CR>
nnoremap <Leader>D :silent ! start C:\Users\kohei\Desktop<CR>
inoremap <ESC> <ESC>:set iminsert=0<CR>
autocmd FileType text setlocal textwidth=0
if has('vim_starting')
  function! s:open_dir()
    cd $VIM_HOME
    e $VIM_HOME
    SM 6
  endfunction
  augroup OpenDir
    au!
    autocmd VimEnter * call s:open_dir()
  augroup END
endif

"---------------------------------------
" Normal
"---------------------------------------
"- Appearance -"
" 行番号を表示
set number
" タイトルを表示
set title
" カーソルのある行を強調表示
set cursorline
" カーソルのある列を強調表示
set cursorcolumn
" 対応する括弧を強調表示
set showmatch
" カーソルの位置をステータスラインに表示
set ruler
" ステータスラインに使われる画面上の行数
set laststatus=2
" コマンドラインに使われる画面上の行数
set cmdheight=2
" 入力中のコマンドを右下に表示
set showcmd
" コマンドの補完候補をステータスラインに表示
set wildmenu
" カーソルの移動時に上下に確保する行数
set scrolloff=5
" 行を折り返さない
set nowrap
" 不可視文字を表示
set list
" 不可視文字の表示記号設定
set listchars=tab:>-,extends:<,trail:-
" 構文ハイライトを有効化
syntax enable
" 全角の記号の幅を固定
set ambiwidth=double

"- Tab, Indent -"
" タブ入力を複数の空白に置き換え
set expandtab
" タブ文字が画面上で占める幅
set tabstop=2
" インデントのスペースの個数
set shiftwidth=2
" 改行前に前の行のインデントを継続
set autoindent
" C言語風のインデント
set smartindent

"- Search -"
" インクリメンタルサーチを有効化
set incsearch
" 検索時に大文字小文字を区別せずに比較
set ignorecase
" 検索パターンに大文字があるときは大文字小文字を区別して比較
set smartcase
" 検索結果をハイライト
set hlsearch
" 末尾まで検索後に先頭から再検索
set wrapscan

"- Other -"
" インサートモード中にすべてのバックスペースを許可
set backspace=indent,eol,start
" 自動整形の実行方法を決めるフラグ(マルチバイト向けなどの設定)
set formatoptions+=jmM
" インサートモードに入ったときにIMEをOFF
set iminsert=0
" 検索時にIMEをOFF
set imsearch=0
" スワップファイルを作成しない
set noswapfile
" バックアップファイルを作成しない
set nobackup
" viminfoファイルを作成しない
set viminfo=
" undoファイルを作成しない
set noundofile
" テキスト中の{と}で折りたたみを定義
set foldmethod=marker
" Vimで扱う色数
set t_Co=256
" ファイルタイプの自動検出を有効化
filetype plugin on
" ファイルタイプ用のプラグインとインデント設定の自動読み込み
filetype indent on
" バッファの放棄時に隠れ(hidden)状態にする
set hidden
" キーコードシーケンスが終了するのを待つ時間を短くする
set ttimeoutlen=1
" ウィンドウサイズの自動調整を無効
set noequalalways
" 新しいウィンドウを下に開く
set splitbelow
" 新しいウィンドウを右に開く
set splitright
" OSとクリップボードを共有
set clipboard=unnamed
" ファイル保存時にパーミッションを変更しない
set backupcopy=yes


"---------------------------------------
" Key Mapping
"---------------------------------------
"{{{
"- Normal -"
" Leaderキーをスペースに割り当て
let mapleader = "\<Space>"
" ウィンドウの移動
nnoremap dh <C-w>h
nnoremap dj <C-w>j
nnoremap dk <C-w>k
nnoremap dl <C-w>l
" ハイライトを消す
nnoremap <silent> <ESC><ESC> :noh<CR>
" バッファを再読み込み
nnoremap <silent> <C-e> :edit!<CR>
" カーソル下の単語(完全一致)で検索&yank
nnoremap <silent> <Space><Space> "*yiw:let @/ = '\<' . @* . '\>'<CR>:set hlsearch<CR>
" カーソル下の単語(部分一致)で検索&yank
nnoremap <silent> <Space>/ "*yiw:let @/ =  @* <CR>:set hlsearch<CR>
" コピー&ペースト
vnoremap <C-c> "+y
map <S-Insert> "+gP
" 現在開いているファイルのディレクトリに移動
nnoremap <Leader>l :lcd %:h<CR>

"- vimgrep -"
" 検索結果の移動
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprevious<CR>
" カーソル下の単語で検索(ディレクトリ以下のファイル)
nnoremap <Leader>j :vimgrep /<C-r><C-w>/j **/*<CR>
" カーソル下の単語で検索(現在開いているファイル)
nnoremap <Leader>J :vimgrep /<C-r><C-w>/j %<CR>
" Quickfixを自動で起動
autocmd QuickFixCmdPost *grep* cwindow

"- other -"
" vimrcを再読み込み
nnoremap <Leader>ss :source $VIM/vimrc<CR>
" 現在開いているファイルを関連付けられたアプリケーションで開く
nnoremap <Leader><CR> :silent ! start %<CR>
"}}}

"---------------------------------------
" Plugin
"---------------------------------------
"{{{
" Colorscheme
colorscheme gruvbox

" vim-table-mode
nnoremap <Leader>tm :TableModeToggle<CR>

" NERDTree
map <silent> <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeAutoDeleteBuffer = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" lightline
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }
"}}}

"---------------------------------------
" WSL
"---------------------------------------
set shell=C:\WINDOWS\System32\bash.exe

" 全角スペースを可視化
if has('win32')
  augroup highlightIdegraphicSpace
    autocmd!
    autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkRed guibg=DarkRed
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
  augroup END
endif
