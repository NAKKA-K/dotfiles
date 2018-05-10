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

