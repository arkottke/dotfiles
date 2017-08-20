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
set inccommand=nosplit
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

" Clear the last search with enter
nnoremap <CR> :noh<CR><CR>

"
" PLUGINS
" """""""


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
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Neosnippet
" """"""""""
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets' behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
\ pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('win64')
    " let g:python_host_prog = 'C:/Python27/python.exe'
    let g:python3_host_prog = 'C:/Users/akottke/AppData/Local/Continuum/Miniconda3/python.exe'
end

" Denite
" """"""
" Use pt on windows
if has('win64')
    " Pt command on file_rec
    call denite#custom#var('file_rec', 'command',
    \ ['pt', '--follow', '--nocolor', '--nogroup', '-g:', ''])
    " Pt command on grep source
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts',
                    \ ['--nogroup', '--nocolor', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
else
    call denite#custom#var('file_rec', 'command',
    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
    " Ag command on grep source
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts',
                    \ ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
end
" Find the git directory
nnoremap <silent> <C-p> :<C-u>Denite
\ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
" Mappings
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
 call denite#custom#map(
 \ 'insert',
 \ '<C-CR>',
 \ '<denite:do_action:split>',
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
let g:neomake_maketest_maker = {'exe': 'make', 'args': ['test']}

" Deoplete Clang
" """"""""""""""
let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang'
