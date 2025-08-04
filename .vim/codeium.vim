function! s:SetStatusline() abort
  if exists(':Codeium')
    set statusline=%<%f\ %m%r%h%w[%{&fenc!=''?&fenc:&enc}%{&bomb?'\ (BOM)':''}][%{&ff}]%=[%{&ft}][Codeium:%{codeium#GetStatusString()}]%6l,%c%V%8P
  end
endfunction

augroup Codeium
  autocmd!
  autocmd VimEnter * call s:SetStatusline()
augroup END
