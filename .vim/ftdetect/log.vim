augroup LogFtDetect
  autocmd!
  autocmd BufRead,BufNewFile *.log silent! packadd vim-log-highlighting | setlocal filetype=log
augroup END
