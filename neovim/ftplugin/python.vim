" Adjust with for PEP8 compliance
set textwidth=79
" Turn on spell checking
" set spell spelllang=en_us
" Remove trailing whitespace
autocmd BufWritePre *.py :%s/\s\+$//e
" Run Neomake on save
autocmd BufWritePost *.py Neomake

" Use the shebang line in linux
map <F5> <ESC>:TagbarToggle<CR>
map <F5> <ESC>:x<CR>:!python %<CR>
