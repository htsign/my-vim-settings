augroup MarkdownFtDetect
  autocmd!
  autocmd BufRead,BufNewFile *.md silent! packadd vim-markdown | setlocal filetype=markdown
  autocmd BufRead,BufNewFile *.markdown silent! packadd vim-markdown | setlocal filetype=markdown
augroup END
