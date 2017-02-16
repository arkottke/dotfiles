" Adjust with for PEP8 compliance
set textwidth=79
" Turn on spell checking
" set spell spelllang=en_us
" Remove trailing whitespace
autocmd BufWritePre *.py :%s/\s\+$//e
" Run Neomake on save
autocmd BufWritePost *.py Neomake
