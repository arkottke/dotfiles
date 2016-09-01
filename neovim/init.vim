"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/albert/Documents/dotfiles/neovim/./repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/albert/Documents/dotfiles/neovim/.')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

call dein#add('chriskempson/base16-vim')
call dein#add('kien/ctrlp.vim')
call dein#add('lervag/vimtex')
call dein#add('scrooloose/syntastic')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-unimpaired')
call dein#add('tpope/vim-vinegar')

" You can specify revision/branch/tag.
" call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" Text Settings
" -------------
set autoindent
set expandtab
set shiftwidth=4 	" auto-ident width when using cindent
set softtabstop=4 	" spaces added when hitting tab
set tabstop=8 		" real tab width

" General Settings
" ----------------
syntax enable
filetype plugin indent on  

set autoindent
set backspace=indent,eol,start
set complete-=i
set incsearch
set laststatus=2
set number
set ruler
set shellslash
set showcmd
set smarttab

set diffopt+=iwhite,vertical

set background=dark
colorscheme base16-solarized-dark

" turn on command line completion wild style
set wildmenu 
" ignore these list file extensions
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
            \,*.pdf,*.un~,*.swp,*.xlsx,*.docx,*/.git/*,*/.svn/*
" turn on wild mode huge list
set wildmode=list:longest 

set completeopt=menuone,longest,preview
" Open new windows below the current window
"set splitbelow

" GUI Settings
" ------------
if has('gui_running')
    set cursorline
    set lines=25 columns=90
endif

set guioptions=ce 
"              ||
"              |+-- use simple dialogs rather than pop-ups
"              +  use GUI tabs, not console style tabs
if has("gui_gtk2")
    set guifont=DejaVu\ Sans\ Mono\ 11
elseif has("win32") || has("win64")
    set guifont=DejaVu_Sans_Mono:h9:cANSI
endif

" Clear highlighting on escape in normal mode
" The second line is needed for mapping to the escape key since Vim internally
" uses escape to represent special keys.
nnoremap <ESC> :noh<CR><ESC>
nnoremap <ESC>^[ <ESC>^[

" Plugin Settings
" ---------------

" CtrlP
let g:ctrl_work_path_mode = 'ra'
nnoremap <Leader>. :CtrlPTag<cr>

" Deocomplete
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB>
	    \ pumvisible() ? "\<C-n>" :
	    \ neosnippet#expandable_or_jumpable() ?
	    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
