"+++++++++++++++++++++++++++++++++++++++
" vimplug.vim
" Maintained by SUDO Kohei
"+++++++++++++++++++++++++++++++++++++++

"---------------------------------------
" Automatic Plug installation {{{
"---------------------------------------
" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
"}}}

"---------------------------------------
" Plugin installation {{{
"---------------------------------------
call plug#begin()
" filer
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'yuki-yano/fern-preview.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'
" window size
Plug 'simeji/winresizer'
" parenthesis completion
Plug 'cohama/lexima.vim'
" parenthesis edit
Plug 'tpope/vim-surround'
" table create, formatter
Plug 'dhruvasagar/vim-table-mode'
" colorscheme
Plug 'morhetz/gruvbox'
"" statusline
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'itchyny/lightline.vim'
" syntax highlight, indent
Plug 'sheerun/vim-polyglot'
" Git command
Plug 'tpope/vim-fugitive'
" show git diff
Plug 'airblade/vim-gitgutter'
" html editing
Plug 'mattn/emmet-vim'
call plug#end()
"}}}

"---------------------------------------
" Plugin setting

" Fern {{{
nnoremap <Leader>h :Fern . -drawer -toggle<CR>
nnoremap <Leader>H :<C-u>Fern .<CR>
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction
augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END
" }}}

" Colorscheme {{{
colorscheme gruvbox
" }}}

" winresizer {{{
let g:winresizer_start_key = '<Leader>e'
" }}}

" vim-table-mode {{{
let g:table_mode_corner='|'
nnoremap <Leader>tm :TableModeToggle<CR>
" }}}

" lightline {{{
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }
" 全角スペースを可視化
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkRed guibg=DarkRed
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END
" }}}

"vim-fugitive {{{
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gc :Gcommit<CR><CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gb :Gblame<CR>
"}}}

"vim-gitgutter {{{
nnoremap <leader>gg :GitGutterLineHighlightsToggle<CR>
"}}}


"prabirshrestha/vim-lsp
"mattn/vim-lsp-settings
"markonm/traces.vim
"junegunn/fzf.vim
"Shougo/ddc.vim
"skanehira/preview-markdown.vim
"MichaelMure/mdr
"mattn/vim-maketable
"mattn/sonictemplate-vim
"thinca/vim-quickrun
"skanehira/translate.vim
"tyru/open-browser.vim
"
"UltiSnips
"ripgrep
