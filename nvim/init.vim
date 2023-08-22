set formatoptions=nlmB1j
set packpath=~/nvim,$VIMRUNTIME,$VIMRUNTIME/after,~/nvim/after

if exists('g:neovide')
  execute('source ' .. expand('<sfile>:p:h') .. '/ginit.vim')
endif

source ~/.vimrc

packloadall
