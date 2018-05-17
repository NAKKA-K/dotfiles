" My settings

" move line
nnoremap j gj
nnoremap k gk


" move and input
inoremap <C-e> <ESC>$a
inoremap <C-a> <ESC>^i
noremap <C-e> <ESC>$a
noremap <C-a> <ESC>^i

" auto brackets
inoremap {<Enter> {<CR>}<ESC><S-o>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>


" indent
noremap > >>
noremap < <<
vnoremap > >gv
vnoremap < <gv



" plugin key map custom --------------------
map <C-n> :NERDTreeToggle<CR>

" non indent, when paste from clipborad
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! s:XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ s:XTermPasteBegin("")
endif

