set encoding=utf-8

packadd! matchit
if glob('$VIMRUNTIME/**/pack/*/opt/editorconfig') != ''
  packadd! editorconfig
endif
if has('nvim')
  if glob('$VIMRUNTIME/**/pack/*/opt/nvim-treesitter-textobjects') != ''
    packadd! nvim-treesitter-textobjects
  endif
else
  if glob('$VIMRUNTIME/**/pack/*/opt/vim-hitspop') != ''
    packadd! vim-hitspop
  endif
endif

set nobackup
set noswapfile
set noundofile

let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

let &t_Co = 256
let &t_Sf = "\<Esc>[3%dm"
let &t_Sb = "\<Esc>[4%dm"

filetype plugin indent on
syntax on
colorscheme desert

" for skk
silent! set imcmdline " unsupported option in nvim
set iminsert=1
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

set hlsearch
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

if !has('nvim')
  set iminsert=2
endif

if has('mouse')
  set mouse=a
  if exists('&ttymouse')
    function! IsUnixOnWin() abort
      if has('win32unix')
        return v:true
      endif
      let proc_version = '/proc/version'
      return filereadable(proc_version)
        \ ? !readfile(proc_version, '', 1)->filter({ _, v -> v =~? 'WSL' })->empty()
        \ : v:false
    endfunction

    execute($'set ttymouse={IsUnixOnWin() ? 'sgr' : 'xterm2'}')
  endif
endif

augroup FileTypeAutoDetect
  autocmd!
  autocmd BufWinEnter * filetype detect
augroup END

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

function! s:ReadScript(path) abort
  let path = expand(a:path)
  if filereadable(path)
    execute $'source {fnameescape(path)}'
  endif
endfunction

call s:ReadScript('~/.vim/keymap.vim')

call s:ReadScript('~/.vim/codeium.vim')
call s:ReadScript('~/.vim/easymotion.vim')
call s:ReadScript('~/.vim/ctrlp.vim')
call s:ReadScript('~/.vim/current_word.vim')
