" Change to directory to file
augroup tex
    autocmd!
    autocmd BufEnter *.tex silent! lcd %:p:h
augroup END

" Enable spelling by default
set spell
