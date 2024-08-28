nnoremap <silent> <C-[><C-[> :nohlsearch<CR>

nnoremap [winsize] <Nop>
nmap <Leader>w [winsize]
nnoremap [winsize]h+ :resize +3<CR>
nnoremap [winsize]h- :resize -3<CR>
nnoremap [winsize]v+ :vertical resize +5<CR>
nnoremap [winsize]v- :vertical resize -5<CR>

augroup KeyBinding
  autocmd!
  autocmd VimEnter *
    \ if exists(':CocConfig')
      \|nmap     <silent> [g         <Plug>(coc-diagnostic-prev)
      \|nmap     <silent> ]g         <Plug>(coc-diagnostic-next)
      \|nnoremap <silent> g.         <Plug>(coc-codeaction)
      \|nnoremap <silent> gd         :call <SID>GotoDefinition()<CR>
      \|nnoremap <silent> gy         <Plug>(coc-type-definition)
      \|nnoremap <silent> gi         <Plug>(coc-implementation)
      \|nnoremap <silent> gr         <Plug>(coc-references)
      \|nnoremap <silent> K          :call <SID>ShowDocumentation()<CR>
      \|nnoremap <silent> <Leader>rn <Plug>(coc-rename)
      \|nnoremap <silent> ==         <Plug>(coc-format)
      \|vnoremap <silent> =          <Plug>(coc-format-selected)
    \|endif
augroup END

function! s:GotoDefinition() abort
  try
    if CocAction('jumpDefinition')
      return v:true
    endif
  catch /\<request: definition provider not found\>/
    " echo v:exception
  endtry

  call searchdecl(expand('<cword>'))
endfunction

function! s:ShowDocumentation() abort
  if index(['vim','help'], &filetype) >= 0
    execute 'h ' .. expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  else
    call CocAction('doHover')
  endif
endfunction
