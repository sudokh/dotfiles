"---------------------------------------
" .vimrc
" Maintained by SUDO Kohei
"---------------------------------------

"---------------------------------------
" Normal
"---------------------------------------
"-- Encode --"
"{{{
" ファイル読み込み時の文字コード
set encoding=utf-8
" ファイル保存時の文字コード
set fileencoding=utf-8
" ファイル読み込み時に，想定される文字コードを指定
set fileencodings=utf-8,euc-jp,sjis,cp932
" ファイル読み込み時に，想定される改行コードを指定
set fileformats=unix,mac,dos
"}}}

"-- Appearance --"
"{{{
" 行番号を表示
set number
" タイトルを表示
set title
" カーソルのある行を強調表示
set cursorline
hi CursorLine guibg=#EBEBEB ctermbg=235
hi CursorColumn guibg=#EBEBEB ctermbg=235
hi Folded guibg=#EBEBEB ctermbg=235
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
" 背景をダークモード
set background=dark
" 不可視文字を表示
set list
" 不可視文字の表示記号設定
set listchars=tab:>-,extends:<,trail:-
" 構文ハイライトを有効化
syntax enable
" 全角の記号の幅を固定
set ambiwidth=double
"" 全角スペースを可視化
"augroup highlightIdegraphicSpace
"  autocmd!
"  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkRed guibg=DarkRed
"  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
"augroup END
"}}}

"-- Tab, Indent --"
"{{{
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
" htmlファイル編集時のインデント関連
autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2
"}}}

"-- Search --"
"{{{
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
"}}}

"-- Other --"
"{{{
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
if has('mac')
  set clipboard+=unnamed
else
  set clipboard+=unnamedplus
endif
"}}}


"---------------------------------------
" Key Mapping
"---------------------------------------
"-- Normal --"
"{{{
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
nnoremap <silent> <Space><Space> "*yiw:let @/ = '\<' . @" . '\>'<CR>:set hlsearch<CR>
" コピー&ペースト
vnoremap <C-c> "+y
map <S-Insert> "+gP
"}}}

"-- other --"
"{{{
" 現在開いているファイルを関連付けられたアプリケーションで開く
nnoremap <Leader><CR> :!open %:p<CR>
"}}}

"-- vimgrep --"
"{{{
" 検索結果の移動
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprevious<CR>
" カーソル下の単語で検索(ディレクトリ以下のファイル)
nnoremap <Leader>j :vimgrep /<C-r><C-w>/j **/*<CR>
" カーソル下の単語で検索(現在開いているファイル)
nnoremap <Leader>J :vimgrep /<C-r><C-w>/j %<CR>
" Quickfixを自動で起動
autocmd QuickFixCmdPost *grep* cwindow
"}}}


"---------------------------------------
" Other
"---------------------------------------
" {{{
" 同ディレクトリのローカルファイルから設定を読み込み
let $MYVIMRC = '.myvimrc.vim'
if filereadable($HOME.'/'.$MYVIMRC)
  source $HOME/$MYVIMRC
endif
"}}}


" colorscheme
"colorscheme darkblue
colorscheme gruvbox
