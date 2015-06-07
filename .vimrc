set nocp

" Global definitions
let g:settings = {}
let g:settings.default_indent = 2
let g:settings.max_column = 120
let g:settings.enable_cursorcolumn = 0

let mapleader = ","
let g:mapleader = ","




" Plugin Manager Setup {{{
let pm_directory = '/.vim/pm/'
let manager_readme=expand($HOME.pm_directory.'neobundle.vim/README.md')

if !filereadable(manager_readme)
  echo ""
  echo "Installing Plugin Manager..."
  echo ""
  silent !mkdir -p $HOME/.vim/autoload/
  silent !mkdir -p $HOME/.vim/pm/
  silent !mkdir -p $HOME/.vim/scripts
  silent !mkdir -p $HOME/.vim/plugins
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/pm/neobundle.vim

  " Note: Skip initialization for vim-tiny or vim-small.
  if 0 | endif

  " Required:
  silent !echo "NeoBundle 'tpope/vim-sensible'" >> $HOME/.vim/scripts/base.vim
  echo "...Done"
  exit 0
endif

if has('vim_starting')
	if &compatible
		set nocompatible               " Be iMproved
	endif

	" Required:
	set runtimepath+=~/.vim/pm/neobundle.vim
endif"

" Required:
call neobundle#begin(expand('~/.vm/plugins/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
filetype plugin indent on


for file in split(glob("~/.vim/scripts/*.vim"), '\n')
  exe 'source' file
endfor

call neobundle#end()
NeoBundleCheck

" }}}

" Key mappings {{{
  nmap <leader><S-v> :so $MYVIMRC<CR>
" }}}
