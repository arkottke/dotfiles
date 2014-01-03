
if has("win32") || has("win64")
    " Default to python3 on windows
    map <F5> <ESC>:w<CR>:!python3 %<CR>
else
    " Use the shebang line in linux
    map <F5> <ESC>:w<CR>:!./%<CR>
endif
