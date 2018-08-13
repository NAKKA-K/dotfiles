" NERDTree ---------------------------------------------------
let g:NERDTreeShowHidden = 1 " 不可視ファイルを表示する

" gitgutter ---------------------------------------------------
let g:gitgutter_max_signs = 200

" vim-trailing-whitespace  ---------------------------------------------------
autocmd BufWritePre * :FixWhitespace

" vim-go --------------------------------------------------
let g:go_fmt_command = "goimports"
let g:go_highlight_function_calls = 1
let g:go_fmt_autosave = 1
