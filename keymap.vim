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
            \|nmap <silent> [g <Plug>(coc-diagnostic-prev)
            \|nmap <silent> ]g <Plug>(coc-diagnostic-next)
            \|nnoremap <silent> g. :call CocActionAsync('codeAction')<CR>
            \|vnoremap <silent> g. :call CocActionAsync('codeAction', v:true)<CR>
            \|nnoremap <silent> gd :call <SID>goto_definition()<CR>
            \|nnoremap <silent> gy :call CocActionAsync('jumpTypeDefunition')<CR>
            \|nnoremap <silent> gi :call CocActionAsync('jumpImplementation')<CR>
            \|nnoremap <silent> gr :call CocActionAsync('jumpReferences')<CR>
            \|nnoremap <silent> K :call <SID>show_documentation()<CR>
            \|nnoremap <Leader>rn :call CocActionAsync('rename')<CR>
            \|nnoremap == :call CocActionAsync('format')<CR>
            \|vnoremap = :call CocActionAsync('formatSelected', 'v')<CR>
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
    if index(['vim','help'], &filetype) >= 0
        execute 'h ' .. expand('<cword>')
    elseif coc#rpc#ready()
        call CocActionAsync('doHover')
    else
        call CocAction('doHover')
    endif
endfunction
