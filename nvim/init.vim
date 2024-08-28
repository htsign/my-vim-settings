set formatoptions=nlmB1j
set packpath=~/nvim,~/.vim,$VIMRUNTIME,~/nvim/after,~/.vim/after,$VIMRUNTIME/after

if exists('g:neovide')
  execute('source ' .. expand('<sfile>:p:h') .. '/ginit.vim')
endif

source ~/.vimrc

packloadall
