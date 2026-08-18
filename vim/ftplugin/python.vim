" Adjust width for PEP8 compliance
setlocal textwidth=79

augroup python
  autocmd! * <buffer>
  autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd BufWritePre <buffer> setlocal makeprg=python\ %
augroup END

nnoremap <buffer> <leader>m :wa<CR>:make<CR>
