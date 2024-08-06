" ===== BASIC SURROUND (version 0.2 ;-) =======================================
" this is a set of mappings that aim to provide the basic functionality 
" as the plugin vim-surround. It it build from more basic vim functionality 
" (text objects, unnamed register). Target users are those, who use vim-emulators
" for IDEs that dont support vimscript (vsvim, viemu, vscodevim(??)).
" 
" Supported Objects:
" word (default), WORD and visual selected text
" Surrounds:  ', ", (, {, [
" Examples:
" In normal mode, type s' to surround the word under cursor with '.
" Type sw" to surround a big WORD with ". Type ds( to delete surrounding ().
" In visual mode, select text, then type s{ to surround it with {}.
" Hints: to use surround with any motion, use the motion in visual mode, then use a mapping
"        from basic surround.
"        Commands are not repeatable with "."
"
" Changing surrounds (experimental!)
" Changing is not done in the standart way "csXY" but "SXY". Reason: csXY is too slow to type.
" These changes are implemented: S"'  and  S'"
" USE WITH CAUTION, if you are not inside " or ' results will be unexpected.
" You need to type fast to use these.

" ===== Customization ========================================================
" disable some builtin keys in normal mode and visual mode.
" this is optional, but it prevents them from beeing executed normally if you type to slow.
" for visual mode there is no downside because "s" is the same as "c".
" the only command you really loose is "s". you can try and commend out the next line
nnoremap s <NOP>
nnoremap sw <NOP>
nnoremap ds <NOP>
nnoremap S <NOP>
vnoremap s <NOP>
" mapleader only used for chage surround. you can try setting this to "cs" 
" but then its hard to type csXY fast enough
let mapleader="S"
" Note for german users: at the bottom, there is a block with mappings 
" customized for german keyboard layout. Uncomment these
" ===== end Customization ====================================================

nnoremap s( ciw(<C-r>")<Esc>
nnoremap s[ ciw[<C-r>"]<Esc>
nnoremap s{ ciw{<C-r>"}<Esc>
nnoremap s" ciw"<C-r>""<Esc>
nnoremap s' ciw'<C-r>"'<Esc>
nnoremap sw( ciW(<C-r>")<Esc>
nnoremap sw[ ciW[<C-r>"]<Esc>
nnoremap sw{ ciW{<C-r>"}<Esc>
nnoremap sw" ciW"<C-r>""<Esc>
nnoremap sw' ciW'<C-r>"'<Esc>

" surround visual selected text
vnoremap s" c"<C-r>""<Esc>
vnoremap s' c"<C-r>"'<Esc>
vnoremap s( c(<C-r>")<Esc>
vnoremap s[ c[<C-r>"]<Esc>
vnoremap s* c/*<C-r>"*/<Esc>
vnoremap s{ c{<C-r>"}<Esc>

" delete surround
nnoremap ds" di"h"_2s<C-r>"<Esc>
nnoremap ds' di'h"_2s<C-r>"<Esc>
nnoremap ds( di(h"_2s<C-r>"<Esc>
nnoremap ds[ di[h"_2s<C-r>"<Esc>
nnoremap ds{ di{h"_2s<C-r>"<Esc>

" change surround. tricky / experimental
nnoremap <leader>'" di'h"_2s"<C-r>""<Esc>
nnoremap <leader>"' di"h"_2s'<C-r>"'<Esc>

" users with german keyboard will find this useful
" surrounds for german keyboard
"nnoremap s2 ciw"<C-r>""<Esc>
"nnoremap s# ciw'<C-r>"'<Esc>
"nnoremap s8 ciw[<C-r>"]<Esc>
"nnoremap s7 ciw{<C-r>"}<Esc>
"nnoremap sw8 ciW[<C-r>"]<Esc>
"nnoremap sw7 ciW{<C-r>"}<Esc>
"vnoremap s7 c{<C-r>"}<Esc>
"vnoremap s8 c[<C-r>"]<Esc>
"" delete surrounds for german keyboard
"nnoremap ds2 di"h"_2s<C-r>"<Esc>
"nnoremap ds# di'h"_2s<C-r>"<Esc>
"nnoremap ds8 di[h"_2s<C-r>"<Esc>
"nnoremap ds7 di{h"_2s<C-r>"<Esc>
