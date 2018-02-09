

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Completion
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

"Colors
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'

Plug 'Shougo/neosnippet'
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

" SuperTab like snippets behavior.
imap <expr><TAB>
	 \ neosnippet#expandable_or_jumpable() ?
	 \    "\<Plug>(neosnippet_expand_or_jump)" :
	 \ 	  pumvisible() ? "\<C-n>" : "\<TAB>"
