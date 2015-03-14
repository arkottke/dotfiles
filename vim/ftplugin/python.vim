" Set F5 to run Python with the appropriate interpreter
if has("win32") || has("win64")
    " Default to python3 on windows
    map <F5> <ESC>:w<CR>:!C:/Miniconda3/python %<CR>
else
    " Use the shebang line in linux
    map <F5> <ESC>:w<CR>:!python3 %<CR>
endif

" Remove trailing whitespace
autocmd BufWritePre *.py :%s/\s\+$//e
