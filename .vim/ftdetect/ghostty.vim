augroup GhosttyFtDetect
  autocmd!
  autocmd BufRead,BufNewFile */.config/ghostty/config setlocal filetype=toml
  autocmd BufRead,BufNewFile */.config/ghostty/config.ghostty setlocal filetype=toml
augroup END
