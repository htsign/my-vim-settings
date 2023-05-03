let s:font_name = 'Cica'
let s:font_size = '12'

colorscheme desert
highlight! Pmenu guibg=#21222C ctermbg=235
highlight! PmenuSbar guibg=#21222C ctermbg=235
highlight! PmenuSel guibg=#44475A ctermbg=239
highlight! PmenuThumb guibg=#44475A ctermbg=239

set columns=140 lines=45
set renderoptions=type:directx,geom:1,renmode:5

let s:font_delim = has('win32') ? ':h' : '\ '
let &guifont = s:font_name .. s:font_delim .. s:font_size

autocmd VimResized * execute "normal \<C-w>="
