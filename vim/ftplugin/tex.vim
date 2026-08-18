" Change to the file's directory and enable spelling by default.
augroup tex
  autocmd! * <buffer>
  autocmd BufEnter <buffer> silent! lcd %:p:h
augroup END

setlocal spell
