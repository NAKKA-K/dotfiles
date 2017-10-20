" My settings

" options
set noswapfile  " swapファイルを作成しない
set autoread 
set hidden      " 保存されていないファイルがあっても別のファイルを開ける
set showcmd     " 入力中のコマンドを表示する

syntax on       " 構文ごとに文字色を変化させる
set background=dark " 暗い色に合うように文字色を変更
set number      " 行番号を表示
set title       " ウィンドウのタイトルにファイルパスを表示
set ruler       " カーソルの行列数を表示
set cursorline  " カーソルの行を見やすく表示
set virtualedit=onemore
set smartindent " 改行時のインデントに合わせて自動でインデントを挿入
set visualbell
set showmatch   " 対応する括弧等を表示する
set laststatus=2 " 末尾から2行目にステータスを常時表示
set wildmode=list:longest
set wildmenu wildmode=list:full " コマンドモードでTabによるファイル名補完
set whichwrap=h,l " 行頭、行末が前後の行とつながる


" Makefileのみtabの空白変換をしない----------------------------------
let _curfile=expand("%:r")
if _curfile != 'Makefile'
  set expandtab " tabを空白に変換
endif
" -------------------------------------------------------------------
set tabstop=2     " tabの表示幅
set shiftwidth=2  " tabの実幅

set incsearch   " 検索ワードの最初の文字を入力した時点で検索を開始する
set wrapscan    " 検索内容をループさせる
set hlsearch    " 検索結果をハイライト
set smartcase   " 小文字のみで検索したときに大小文字を無視する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P " ステータスの書式を指定




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
" auto close HTML tag
inoremap </ <ESC><Left>byw$a></<C-o>p>

" indent
noremap > >>
noremap < <<
vnoremap > >gv
vnoremap < <gv


" auto file type
filetype on
