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

" Compile with rubber or texify
if has('win32') || has('win64')
    map <F5> <ESC>:w<CR>:cd %:p:h<CR>:!texify -bp %<CR>
else
    map <F5> <ESC>:w<CR>:cd %:p:h<CR>:!rubber -d %<CR>
endif
