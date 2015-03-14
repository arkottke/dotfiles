set textwidth=78

" Set F5 to run Python with the appropriate interpreter
if has("win32") || has("win64")
    " Set F4 to run ctags
    map <F4> <ESC>:cd %:p:h<CR>:!ctags -R -f .tags<CR>

    " Default to python3 on windows
    map <F5> <ESC>:w<CR>:!C:/Miniconda3/python %<CR>
else
    " Use the shebang line in linux
    map <F5> <ESC>:w<CR>:!python3 %<CR>
endif

" Remove trailing whitespace
autocmd BufWritePre *.py :%s/\s\+$//e
