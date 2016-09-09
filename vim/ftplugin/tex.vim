" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" Enable spelling
setlocal spell spelllang=en_us

" Set the width of text
set textwidth=80

" Use the shebang line in linux
map <F5> :VimtexCompileToggle<CR>

" Compile with rubber or texify
if has('win32') || has('win64')
    let g:vimtex_view_general_viewer='mupdf'
endif

let g:vimtex_latexmk_options='-pdf -verbose -file-line-error -synctex=1 -interaction=nonstopmode'

if has('unix')
    let g:vimtex_latexmk_options.=' -lualatex'
endif
