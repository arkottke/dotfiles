
" Change to directory to file
augroup tex
    autocmd!
    autocmd BufEnter *.tex silent! lcd %:p:h
    " Run Neomake on save
    " autocmd BufWritePost *.tex Neomake
augroup END

" Enable spelling by default
set spell

" Add YCM completion
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme


let g:vimtex_latexmk_options='-pdf -verbose -file-line-error -synctex=1 -interaction=nonstopmode'

if has('unix')
    let g:vimtex_latexmk_options.=' -lualatex'
endif
