set textwidth=79
" Turn on spell checking
set spell spelllang=en_us

augroup markdown
    " Remove trailing whitespace
    autocmd BufWritePre *.md :%s/\s\+$//e
augroup END
