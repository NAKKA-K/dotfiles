" My settings

" options
set noswapfile
set autoread
set hidden
set showcmd

syntax on
set background=dark
set number
set title
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
set wildmenu wildmode=list:full
set whichwrap=h,l

let _curfile=expand("%:r")
if _curfile != 'Makefile'
  set expandtab
endif
set tabstop=2
set shiftwidth=2

set incsearch
set wrapscan
set hlsearch
set smartcase
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P




" move line
nnoremap j gj
nnoremap k gk


" input
inoremap <C-e> <ESC>$a
inoremap <C-a> <ESC>^i
noremap <C-e> <ESC>$a
noremap <C-a> <ESC>^i

" atuo brackets
inoremap {<Enter> {<CR>}<ESC><S-o>
inoremap [ []<Left>
inoremap ( ()<Left>
" HTML tag
inoremap </ <ESC><Left>byw$a></<C-o>p>

" indent
noremap > >>
noremap < <<
vnoremap > >gv
vnoremap < <gv


" auto file type
filetype on
