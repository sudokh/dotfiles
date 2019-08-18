scriptencoding utf-8

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/gvimrc_local.vim)があれば読み込む。読み込んだ後
" に変数g:gvimrc_local_finishに非0な値が設定されていた場合には、それ以上の設
" 定ファイルの読込を中止する。
if 1 && filereadable($VIM . '/gvimrc_local.vim')
  source $VIM/gvimrc_local.vim
  if exists('g:gvimrc_local_finish') && g:gvimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.gvimrc_first.vim)があれば読み込む。読み込んだ後に変
" 数g:gvimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 1 && exists('$HOME') && filereadable($HOME . '/.gvimrc_first.vim')
  unlet! g:gvimrc_first_finish
  source $HOME/.gvimrc_first.vim
  if exists('g:gvimrc_first_finish') && g:gvimrc_first_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_gvimrc_exampleに非0な値を設定しておけばインクルードしない。
"if 1 && (!exists('g:no_gvimrc_example') || g:no_gvimrc_example == 0)
"  source $VIMRUNTIME/gvimrc_example.vim
"endif

"---------------------------------------------------------------------------
" カラー設定:
"colorscheme morning

" 端末モード関連の色設定
"highlight Terminal guifg=lightgrey guibg=grey20

"---------------------------------------------------------------------------
" フォント設定:
"
if has('win32')
  " Windows用
  "set guifont=MS_Gothic:h12:cSHIFTJIS
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
"elseif has('mac')
"  set guifont=Osaka－等幅:h14
"elseif has('xfontset')
"  " UNIX用 (xfontsetを使用)
"  set guifontset=a14,r14,k14
endif

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
"" ウインドウの幅
"set columns=80
"" ウインドウの高さ
"set lines=25
"" コマンドラインの高さ(GUI使用時)
"set cmdheight=2
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (GUI使用時)

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
"if has('multi_byte_ime') || has('xim')
"  " IME ON時のカーソルの色を設定(設定例:紫)
"  highlight CursorIM guibg=Purple guifg=NONE
"  " 挿入モード・検索モードでのデフォルトのIME状態設定
"  " (8.0.1114 でデフォルトになったが念のため残してある)
"  "set iminsert=0 imsearch=0
"  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
"  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
"endif

"---------------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a

"---------------------------------------------------------------------------
" メニューに関する設定:
"
" 解説:
" "M"オプションが指定されたときはメニュー("m")・ツールバー("T")供に登録され
" ないので、自動的にそれらの領域を削除するようにした。よって、デフォルトのそ
" れらを無視してユーザが独自の一式を登録した場合には、それらが表示されないと
" いう問題が生じ得る。しかしあまりにレアなケースであると考えられるので無視す
" る。
"
"if &guioptions =~# 'M'
"  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
"endif
"
"---------------------------------------------------------------------------
" その他、見栄えに関する設定:
"
" 検索文字列をハイライトしない(_vimrcではなく_gvimrcで設定する必要がある)
"set nohlsearch

"---------------------------------------------------------------------------
" 印刷に関する設定:
"
" 注釈:
" 印刷はGUIでなくてもできるのでvimrcで設定したほうが良いかもしれない。この辺
" りはWindowsではかなり曖昧。一般的に印刷には明朝、と言われることがあるらし
" いのでデフォルトフォントは明朝にしておく。ゴシックを使いたい場合はコメント
" アウトしてあるprintfontを参考に。
"
" 参考:
"   :hardcopy
"   :help 'printfont'
"   :help printing
"
" 印刷用フォント
"if has('printer')
"  if has('win32')
"    set printfont=MS_Mincho:h12:cSHIFTJIS
"    "set printfont=MS_Gothic:h12:cSHIFTJIS
"  endif
"endif

" Copyright (C) 2009-2018 KaoriYa/MURAOKA Taro



"
" added by sudo kohei
" 2019/02/25
"

" gvimの色テーマ
colorscheme koehler

" IMEの状態によってカーソルの色を変える
function! s:CursorColor()
  hi Cursor guifg=NONE guibg=Green
  hi CursorIM guifg=NONE guibg=Purple
endfunction

augroup ColorSchemeHook
  autocmd!
  autocmd ColorScheme * call s:CursorColor()
augroup END


hi StatusLine guibg=#5D0F0F guifg=#FFFFFF
hi StatusLineNC guibg=#FFFFFF guifg=#888888

hi Normal guibg=#170D0D
hi LineNr guifg=#E3B1B1
hi Search guibg=#A52A2A guifg=#FFFFFF
hi Visual guibg=#000000 guifg=#fffacd
hi WildMenu guibg=#FFFFFF guifg=#A52A2A
hi IncSearch guibg=#000000 guifg=#ffff00


"MyricaM_M
set guifont=MyricaM_M:h12:cSHIFTJIS


" 各種バーを非表示
set guioptions-=m  "メニューバー
set guioptions-=T  "ツールバー
set guioptions-=R  " 
set guioptions-=l  " 
set guioptions-=L  " 
set guioptions-=r  "左右のスクロールバー
set guioptions-=b  "水平スクロールバー

" 半透明にする
autocmd GUIEnter * set transparency=0

" auto reload .vimrc
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC
  autocmd BufWritePost *gvimrc source $MYGVIMRC
augroup END

