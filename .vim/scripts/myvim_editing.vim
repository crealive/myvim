if count(g:myvim_plugin_groups, 'editing')


NeoBundle 'tpope/vim-surround' " Adds surroundings 's' {{{ 
" Change a surrounding: cs <old> <new>
" cs"' "Hello world!" > 'Hello world!'
"
" Change a tag surrounding: cst <new>
" cst" <q>Hello world!</q> > "Hello world!"
"
" Delete a surrounding ds<old>
" ds" "Hello world!" > Hello world!
"
" Add a surrounding: ys<where><surrounding>
" ysiw] Hello world! > [Hello] world!
" yss) Hello world! > (Hello world!)
"
" In Visual Mode add a surrounding:
" VS<new>
"
" }}}
"
NeoBundle 'tpope/vim-repeat' " Use . on more ways (like surroundings)

NeoBundle 'tomtom/tcomment_vim' " Easy to use file-type sensible comments {{{
" Toggle a part: gc{motion}
" Toggle a line: gcc
" }}}

NeoBundle 'svermeulen/vim-easyclip' "Simplified clipboard functionality for Vim {{{
" New command: move, called by 'm'.
" Because of 'm', the original 'm' mapping, used for marks, have to replaced:
nnoremap gm m
" EasyClip allows you to yank and cut things without worrying about losing text
" that you copied previously. It achieves this by storing all yanks into a
" buffer, which you can cycle through forward or backwards to choose the yank
" that you want.
"
" Cut: m<motion> / mm (line)
" Copy Y (cursor to line)
" Paste: p<CTRL-N> <CTRL-P>
" }}}
"
NeoBundle 'justinmk/vim-sneak' " a minimalist, versatile Vim motion plugin that jumps to any location specified by two characters {{{
" s{char}{char}
let g:sneak#streak = 1
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
xmap f <Plug>Sneak_s
xmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S
" }}}


endif
