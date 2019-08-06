

" Specify a directory for plugins
call plug#begin('~/.nvim/plugged')

" Completion
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

"Colors
Plug 'RRethy/vim-illuminate'
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-fswitch'
Plug 'itchyny/lightline.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'rking/ag.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
Plug 'romainl/Apprentice'
Plug 'bfredl/nvim-ipy'

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
set wildmode=longest,list,full

set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git*

syntax on

" ,tags,.git,.git/*,.idea/*,__pycache__/*,venv/*,.pytest-cache/*,*.egg-info/*

" Configure Python
let g:python_host_prog = '/bin/python2'
let g:python3_host_prog = '/bin/python3'

" Colors
if has('gui')
    colorscheme dracula
endif
let g:lightline = {
    \ 'colorscheme': 'dracula',
    \ }

" Denite

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    nnoremap <silent><buffer><expr> <tab> denite#do_map('choose_action')
    nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> T denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> h denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q denite#do_map('quit')
    nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
    nnoremap <nowait> <silent><buffer><expr> y denite#do_map('do_action', 'yank')
    nnoremap <silent><buffer><expr> c denite#do_map('do_action', 'cd')
    nnoremap <silent><buffer><expr> e denite#do_map('do_action', 'edit')
    nnoremap <nowait> <silent><buffer><expr> o denite#do_map('do_action', 'drop')
    nnoremap <silent><buffer><expr> V denite#do_map('toggle_select')
    nnoremap <silent><buffer><expr> <space> denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <C-g> <Plug>(denite_filter_quit)
    inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    inoremap <silent><buffer><expr> <tab> denite#do_map('choose_action')
    inoremap <silent><buffer><expr> <c-t> denite#do_map('do_action', 'tabopen')
    inoremap <silent><buffer><expr> <c-v> denite#do_map('do_action', 'vsplit')
    inoremap <silent><buffer><expr> <c-h> denite#do_map('do_action', 'split')
    inoremap <silent><buffer><expr> <c-o> denite#do_map('do_action', 'drop')
    inoremap <silent><buffer><expr> <esc> denite#do_map('quit')
    " for compatibility with FZF
    inoremap <silent><buffer> <C-n> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <C-p> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction

let s:denite_options = {
      \ 'prompt' : '❯',
      \ 'split': 'floating',
      \ 'start_filter': 1,
      \ 'auto_resize': 1,
      \ 'source_names': 'short',
      \ 'direction': 'botright',
      \ 'highlight_filter_background': 'CursorLine',
      \ 'highlight_matched_char': 'Type',
      \ 'reversed': 'true',
      \ }
call denite#custom#option('default', s:denite_options)

nmap ; :Denite buffer<CR>
nmap <Leader>t :Denite file/rec<CR>
nmap <Leader>r :Denite tag<CR>
nmap <Leader>e :Denite grep<CR>

" call denite#custom#var('file/rec', 'command', ['scantree.py'])
call denite#custom#var('file/rec', 'command',
            \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#source('file/rec', 'matchers', 
            \ ['matcher/fuzzy', 'matcher/hide_hidden_files'])

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

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

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

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %
