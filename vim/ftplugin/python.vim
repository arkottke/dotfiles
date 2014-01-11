" Set F5 to run Python with the appropriate interpreter
if has("win32") || has("win64")
    " Default to python3 on windows
    map <F5> <ESC>:w<CR>:!py %<CR>
else
    " Use the shebang line in linux
    map <F5> <ESC>:w<CR>:!./%<CR>
endif

" Remove trailing whitespace
autocmd BufWritePre *.py :%s/\s\+$//e
