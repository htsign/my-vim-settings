function! s:SetStatusline() abort
  if exists(':Codeium')
    set statusline=%<%f\ %m%r%h%w[%{&fenc!=''?&fenc:&enc}%{&bomb?'\ (BOM)':''}][%{&ff}]%=[%{&ft}][Codeium:%{codeium#GetStatusString()}]%6l,%c%V%8P
  endif
endfunction

" Typing then deleting a full-width space makes `codeium#Clear` raise `E964` while rendering
" a stale completion, which aborts `Clear` and leaves the completion behind (root cause unknown).
" The plugin is unmaintained, so catch `E964` around the completion trigger, drop the stale
" completion and retry. Other paths (`InsertLeave`, `BufEnter` in insert mode, `<C-]>`) are not covered.
function! s:SafeDebouncedComplete() abort
  try
    call codeium#DebouncedComplete()
  catch /\<E964:/
    unlet! b:_codeium_completions
    call codeium#DebouncedComplete()
  endtry
endfunction

function! s:WrapCompleteAutocmds() abort
  if !exists('#codeium')
    return
  endif
  autocmd! codeium InsertEnter,CursorMovedI,CompleteChanged *
  autocmd Codeium InsertEnter,CursorMovedI,CompleteChanged * call s:SafeDebouncedComplete()
endfunction

augroup Codeium
  autocmd!
  autocmd VimEnter * call s:SetStatusline()
  autocmd VimEnter * call s:WrapCompleteAutocmds()
augroup END

" Re-sourcing after startup wipes the wrappers via `autocmd!` above, so re-create them now
if v:vim_did_enter
  call s:WrapCompleteAutocmds()
endif
