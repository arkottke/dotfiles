execute pathogen#infect()
syntax on
filetype plugin indent on

" Text Settings
" -------------
set autoindent
set expandtab
set shiftwidth=4 	" auto-ident width when using cindent
set softtabstop=4 	" spaces added when hitting tab
set tabstop=8 		" real tab width

" General Settings
" ----------------
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

set t_Co=256
colorscheme dracula

" turn on command line completion wild style
set wildmenu 
" ignore these list file extensions
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
            \,*.pdf,*.un~,*.swp,*.xlsx,*.docx,*/.git/*,*/.svn/*
" turn on wild mode huge list
set wildmode=list:longest 

set completeopt=menuone,longest,preview

"
" PLUGINS
" """""""
"

" Deoplete
" """"""""
" Use deoplete
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:deoplete#sources#syntax#min_keyword_length = 3
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"
" Neosnippet
" """"""""""
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('win64')
    let g:python_host_prog = 'C:/Python27/python.exe'
    let g:python3_host_prog = 'C:/Users/akottke/AppData/Local/Continuum/Miniconda3/python.exe'
end

" Denite
" """"""
" Use pt on windows
if has('win64')
    call denite#custom#var('file_rec', 'command',
    \ ['pt', '--follow', '--nocolor', '--nogroup', '-g:', ''])
else
    call denite#custom#var('file_rec', 'command',
    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
end
" Find the git directory
nnoremap <silent> <C-p> :<C-u>Denite
\ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
" Change mappings.
call denite#custom#map(
\ 'insert',
\ '<C-j>',
\ '<denite:move_to_next_line>',
\ 'noremap'
\)
call denite#custom#map(
\ 'insert',
\ '<C-k>',
\ '<denite:move_to_previous_line>',
\ 'noremap'
\)

call denite#custom#source('file_mru', 'converters',
\ ['converter_relative_word'])

" Define alias
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
\ ['git', 'ls-files', '-co', '--exclude-standard'])

" Change default prompt
call denite#custom#option('default', 'prompt', '>')

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
\ [ '.git/', '.ropeproject/', '__pycache__/',
\   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

" Neomake
" """""""
let g:neomake_open_list=2

