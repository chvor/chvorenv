filetype plugin indent on

" Install vim plug from:
" https://github.com/junegunn/vim-plug
" UNIX installation:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'qpkorr/vim-bufkill'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-sleuth'
Plug 'digitaltoad/vim-jade'
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
" Plug 'idanarye/vim-dutyl'
call plug#end()

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:UltiSnipsExpandTrigger = '<C-b>'
let g:UltiSnipsJumpForwardTrigger = '<C-b>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsSnippetDir = $HOME.'/.vim/UltiSnips'

let g:dutyl_stdImportPaths=['/usr/include/dmd']

set updatetime=250
set laststatus=2
set background=dark
set sw=4 ts=4 expandtab ai cindent
set hidden nowrap
colorscheme solarized

let mapleader= ","
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

" incsearch.vim bindings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" buffkill to Alt-W
nmap <Esc>w :BD<CR>
