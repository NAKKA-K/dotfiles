" options
set noswapfile    " swapファイルを作成しない
set autoread      " ファイルが外部で変更された時に自動で読み込む
set hidden        " 保存されていないファイルがあっても別のファイルを開ける
set showcmd       " 入力中のコマンドを表示する

set background=dark " 暗い色に合うように文字色を変更
set number        " 行番号を表示
set title         " ウィンドウのタイトルにファイルパスを表示
set ruler         " カーソルの行列数を表示
set cursorline    " カーソルの行を見やすく表示
set virtualedit=onemore
set smartindent   " 改行時のインデントに合わせて自動でインデントを挿入
set visualbell
set showmatch     " 対応する括弧等を表示する
set laststatus=2  " 末尾から2行目にステータスを常時表示
set wildmode=list:longest
set wildmenu wildmode=list:full " コマンドモードでTabによるファイル名補完
set whichwrap=h,l " 行頭、行末が前後の行とつながる

set incsearch     " 検索ワードの最初の文字を入力した時点で検索を開始する
set wrapscan      " 検索内容をループさせる
set hlsearch      " 検索結果をハイライト
set smartcase     " 小文字のみで検索したときに大小文字を無視する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P " ステータスの書式を指定

set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp




" -------------------------------------------------------------------
" Makefileのみtabの空白変換をしない----------------------------------
let _curfile=expand("%:r")
if _curfile != 'Makefile'
  set expandtab   " tabを空白に変換
endif

" default space
set tabstop=4     " tabの表示幅
set shiftwidth=4  " tabの実幅
set softtabstop=4 " 1度に消すスペースの数

" spaceの幅をファイルタイプごとに設定する
augroup setFileTypeIndent
    autocmd!
    autocmd BufRead,BufNewFile *.coffee setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.rb setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.html setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.css setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.scss setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.erb setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END

augroup Binary
  autocmd!
  autocmd BufReadPre  *.bin let &bin=1
  autocmd BufReadPost * if &bin | silent %!xxd -g 1
  autocmd BufReadPost * set filetype=xxd | endif
  autocmd BufWritePre * if &bin | %!xxd -r
  autocmd BufWritePost * if &bin | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
