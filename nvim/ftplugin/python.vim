set textwidth=88
" Turn on spell checking
" set spell spelllang=en_us

augroup python
    " Remove trailing whitespace
    autocmd BufWritePre *.py :%s/\s\+$//e
    " Run Neomake on save
    "autocmd BufWritePost *.py Neomake
    autocmd BufWritePre *.py set makeprg=python\ %

    autocmd BufWritePre *.py execute ':Black'
   
    nmap <Leader>m :wa<CR>:make<CR>
    nmap <Leader>b :TagbarToggle<CR>
    nnoremap <F9> :Black<CR>
augroup END
