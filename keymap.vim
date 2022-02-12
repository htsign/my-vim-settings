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
        \ if exists(':LspStatus')
            \|nmap <silent> [g :LspNextDiagnostic<CR>
            \|nmap <silent> ]g :LspPreviousDiagnostic<CR>
            \|nnoremap <silent> g. :<C-u>LspCodeAction<CR>
            \|nnoremap <silent> gd :call <SID>goto_definition()<CR>
            \|nnoremap <silent> gt :<C-u>LspPeekTypeDefinition<CR>
            \|nnoremap <silent> gi :<C-u>LspPeekImplementation<CR>
            \|nnoremap <silent> gr :<C-u>LspReferences<CR>
            \|nnoremap <silent> K :call <SID>show_documentation()<CR>
            \|nnoremap <Leader>rn :<C-u>LspRename<CR>
            \|nnoremap == :<C-u>LspDocumentFormat<CR>
            \|vnoremap = :LspDocumentRangeFormat<CR>
            \|nnoremap <silent> <Leader>gt :<C-u>LspTypeDefinition<CR>
            \|nnoremap <silent> <Leader>gi :<C-u>LspImplementation<CR>
        \|endif
augroup END

function! s:goto_definition()
    if exists(':LspDefinition')
        LspDefinition
        return
    endif

    let ret = execute("silent! normal \<C-]>")
    if (ret =~ "Error" || ret =~ "エラー")
        call searchdecl(expand('<cword>'))
    endif
endfunction

function! s:show_documentation()
    if index(['vim','help'], &filetype) >= 0
        execute 'h ' .. expand('<cword>')
    else
        LspHover
    endif
endfunction
