set encoding=utf-8

packadd! matchit
if v:version >= 900 && glob('$VIMRUNTIME/**/pack/*/opt/editorconfig') != ''
  packadd! editorconfig
endif

source ~/.vim/keymap.vim

set nobackup
set noswapfile
set noundofile

let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

let &t_Co = 256
let &t_Sf = "\<Esc>[3%dm"
let &t_Sb = "\<Esc>[4%dm"

set imsearch=-1

set emoji
set number
set cursorcolumn cursorline
set scrolloff=3

set splitbelow
set splitright

set expandtab
set tabstop=2 shiftwidth=0 softtabstop=-1
set autoindent
set smartindent

set virtualedit+=block

set list listchars=tab:\-\-\>,extends:»,precedes:«,trail:⋅
set matchpairs&
set matchpairs+=「:」,『:』,（:）,【:】

highlight NonText    ctermbg=NONE ctermfg=240 guibg=NONE guifg=#585858
highlight SpecialKey ctermbg=NONE ctermfg=240 guibg=NONE guifg=#585858

set incsearch
set ignorecase
set smartcase
set wildmenu
set showmatch

set helplang=ja,en

set showtabline=2
augroup BufferAsTab
  autocmd!
  autocmd BufNew * tab ball
augroup END

set laststatus=2
set statusline=%<%f\ %m%r%h%w[%{&fenc!=''?&fenc:&enc}%{&bomb?'\ (BOM)':''}][%{&ff}]%=[%{&ft}]%6l,%c%V%8P

set autochdir

set mouse=a

if !has('nvim')
  set iminsert=2
  set ttymouse=xterm2
endif

syntax on
filetype plugin indent on
augroup FileTypeAutoDetect
  autocmd!
  autocmd BufWinEnter * filetype detect
augroup END

colorscheme desert

augroup OmniComplete
  autocmd!
  autocmd FileType *
    \ if &l:omnifunc ==# ''
    \|    setlocal omnifunc=syntaxcomplete#Complete
    \|endif
augroup END

if exists('*timer_start')
  " update help tags asyncronously
  call timer_start(0, { -> execute('helptags ALL') })
endif

source ~/.vim/codeium.vim
source ~/.vim/easymotion.vim
source ~/.vim/ctrlp.vim
