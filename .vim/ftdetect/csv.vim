augroup CsvFtDetect
  autocmd!
  autocmd BufRead,BufNewFile *.csv silent! packadd rainbow_csv | setlocal filetype=csv
  autocmd BufRead,BufNewFile *.tsv silent! packadd rainbow_csv | setlocal filetype=csv
augroup END
