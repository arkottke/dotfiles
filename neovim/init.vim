

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Completion
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

"Colors
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-fswitch'
Plug 'itchyny/lightline.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'

Plug 'zchee/deoplete-jedi', { 'for': 'python' } 
Plug 'lervag/vimtex', { 'for': 'tex' }

call plug#end()

let mapleader=","

set autoindent
set backspace=indent,eol,start
set complete-=i
set completeopt=menuone,noinsert,noselect
set cursorline
set expandtab
set number
set ruler
set shellslash
set shiftwidth=4 	" auto-ident width when using cindent
set softtabstop=4 	" spaces added when hitting tab
set tabstop=8 		" real tab width

" Colors
colorscheme dracula
let g:lightline = {
    \ 'colorscheme': 'Dracula',
    \ }

" Denite
nmap ; :Denite buffer<CR>
nmap <Leader>t :Denite file_rec<CR>
nmap <Leader>r :Denite tag<CR>

" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-n>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-p>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" Neosnippet
" Use tab to complete and jump
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
" if has('conceal')
"   set conceallevel=2 concealcursor=niv
" endif

" Disable polyglot for latex
let g:polyglot_disabled = ['latex']

" Switch between C source files
nmap <silent> <Leader>of :FSHere<cr>
nmap <silent> <Leader>ol :FSRight<cr>
nmap <silent> <Leader>oL :FSSplitRight<cr>
nmap <silent> <Leader>oh :FSLeft<cr>
nmap <silent> <Leader>oH :FSSplitLeft<cr>
nmap <silent> <Leader>ok :FSAbove<cr>
nmap <silent> <Leader>oK :FSSplitAbove<cr>
nmap <silent> <Leader>oj :FSBelow<cr>
nmap <silent> <Leader>oJ :FSSplitBelow<cr>
