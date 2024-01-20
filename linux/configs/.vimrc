""""""""""""""""
" Toxblh vimrc "
"              "
""""""""""""""""
" Autoload vimplug
""""""""""""""""
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"""""""""""""""

"Vim Plug
"""""""""""""
call plug#begin('~/.vim/plugged')
  Plug 'bling/vim-airline'
  Plug 'ryanoasis/vim-devicons'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'joshdick/onedark.vim'
  Plug 'lewis6991/gitsigns.nvim'
call plug#end()

""""""""""""""
" General
set nocompatible

" Syntax
syntax on

" file plugins
filetype plugin indent on
filetype on
filetype plugin on

"turn off backup
set nobackup
set nowritebackup

"Configs
" number lines
set number
set relativenumber
set ruler

set encoding=UTF-8
set updatetime=300
colorscheme onedark



""""""
"
"  COC - https://github.com/neoclide/coc.nvim
"  Plugin Config 
"
"""""""

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"""""
" Finish COC config
"""""
