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
        \ if exists(':CocAction')
            \|nmap <silent> [g <Plug>(coc-diagnostic-prev)
            \|nmap <silent> ]g <Plug>(coc-diagnostic-next)
            \|nnoremap <silent> <Leader>sr :call CocAction('jumpReferences')<CR>
            \|nnoremap <silent> gd :call <SID>goto_definition()<CR>
            \|nnoremap <silent> gi <Plug>(coc-implementation)
            \|nnoremap <silent> gr <Plug>(coc-references)
            \|nnoremap <silent> K :call <SID>show_documentation()<CR>
        \|endif
augroup END

function! s:goto_definition()
    if CocAction('jumpDefinition')
        return v:true
    endif

    let ret = execute("silent! normal \<C-]>")
    if (ret =~ "Error" || ret =~ "エラー")
        call searchdecl(expand('<cword>'))
    endif
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h ' .. expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
