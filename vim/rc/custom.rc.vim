" My settings

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall


"" Map leader to ,
let mapleader=','
" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>


" move line --------------------
nnoremap j gj
nnoremap k gk


" move and input --------------------
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
noremap <C-e> A
noremap <C-a> I


" auto brackets --------------------
inoremap {<Enter> {<CR>}<ESC><S-o>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>


" indent --------------------
noremap > >>
noremap < <<
vnoremap > >gv
vnoremap < <gv


" Plugin key map: NERDTree --------------------
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close NERDTree when file is closed


" Plugin key map: Tagbar --------------------
nmap <F4> :TagbarToggle<CR>


"" Plugin key map: (Git)fugitive --------------------
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gpush :Gpush<CR>
noremap <Leader>gpull :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gblame :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>


"" Copy/Paste/Cut --------------------
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif


"" Split --------------------
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>


"" Switching windows --------------------
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>


"" Tabs --------------------
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>


"" Buffer nav --------------------
noremap <leader>buf :buffers<CR>


"" Set working directory --------------------
nnoremap <leader>cd :lcd %:p:h<CR>


"" Open current line on GitHub --------------------
nnoremap <Leader>o :.Gbrowse<CR>


" RSpec.vim mappings --------------------
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>


" For ruby refactory --------------------
" def/endなどを%で行き来できる
if has('nvim')
  runtime! macros/matchit.vim
else
  packadd! matchit
endif

" rap: メソッドに引数を追加する
nnoremap <leader>rap  :RAddParameter<cr>
" rcpc: 後置条件文(hoge if fuga?)を通常if形式に変換する
nnoremap <leader>rcpc :RConvertPostConditional<cr>
" rel: 選択部分をRspecのlet文に切り出す
nnoremap <leader>rel  :RExtractLet<cr>
" rec: 選択部分を定数に切り出す
vnoremap <leader>rec  :RExtractConstant<cr>
" relv: 選択部分を変数に切り出す
vnoremap <leader>relv :RExtractLocalVariable<cr>
" rit: 一時変数を取り除く
nnoremap <leader>rit  :RInlineTemp<cr>
" rrlv: ローカル変数のリネーム
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
" rriv: インスタンス変数をリネーム
vnoremap <leader>rriv :RRenameInstanceVariable<cr>
" rem: 選択部分をメソッドに切り出す
vnoremap <leader>rem  :RExtractMethod<cr>


" non indent, when paste from clipborad --------------------
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif
