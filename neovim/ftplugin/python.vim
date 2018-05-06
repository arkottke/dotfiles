" Adjust with for PEP8 compliance
set textwidth=79
" Turn on spell checking
" set spell spelllang=en_us

augroup python
    " Remove trailing whitespace
    autocmd BufWritePre *.py :%s/\s\+$//e
    " Run Neomake on save
    "autocmd BufWritePost *.py Neomake
    autocmd BufWritePre *.py set makeprg=python\ %
   
    nmap <Leader>m :wa<CR>:make<CR>
    nmap <Leader>b :TagbarToggle<CR>
    " Use the shebang line in linux
    nnoremap <F4> <ESC>:TagbarToggle<CR>
    nnoremap <F5> <ESC>:w<CR>:!python %<CR>
augroup END
