" dein configurations.

" plugin install directory
let s:dein_dir = expand('~/.cache/dein')
" dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'


" is exist dein.vim ?
if has('vim_starting') && &runtimepath !~ '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif

    " Add dein plugin to vim runtimepath
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif


" can setting start ?
if !dein#load_state(s:dein_dir)
    finish
endif

" start settings
call dein#begin(s:dein_dir)

let s:dein_toml = g:rc_dir . '/dein.toml'
call dein#load_toml(s:dein_toml, {'lazy': 0})

" end settings
call dein#end()
call dein#save_state()

" install the non install plugin
if !has('vim_starting') && dein#check_install()
    call dein#install()
endif

