if $compatible
    set nocompatible
endif

" --------------------------------------------------

let g:vim_home = expand('~/dotfiles/vim')
let g:rc_dir = expand('~/dotfiles/vim/rc')

function! s:source_rc(rc_file_name)
    let rc_file = expand(g:rc_dir . '/' . a:rc_file_name)
    if filereadable(rc_file)
        execute 'source' rc_file
    endif
endfunction

call s:source_rc('dein.rc.vim') " Dein is plugin manager

call s:source_rc('option.rc.vim') " set options
call s:source_rc('custom.rc.vim') " my settings

call s:source_rc('plugin_variable.rc.vim')


" --------------------------------------------------
" syntax
syntax enable
syntax on       " 構文ごとに文字色を変化させる

" auto file type
filetype plugin indent on
