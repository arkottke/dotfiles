
" Change to directory to file
augroup tex
    autocmd!
    autocmd BufEnter *.tex silent! lcd %:p:h
    " Run Neomake on save
    " autocmd BufWritePost *.tex Neomake
augroup END

" Enable spelling by default
set spell
