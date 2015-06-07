set nocp

" Global definitions
let g:myvim_settings = {}
let g:myvim_settings.default_indent = 2
let g:myvim_settings.max_column = 120
let g:myvim_settings.enable_cursorcolumn = 0
let g:myvim_settings.cache_dir = '~/.vim/.cache'


let g:myvim_plugin_groups = ['ui']


let mapleader = ","
let g:mapleader = ","


" Key mappings {{{
  nmap <leader><1> :so $MYVIMRC<CR>                 "reload vim configuration
  nnoremap <BS> :set hlsearch! hlsearch?<cr>          "show / hide search matchings
" }}}

" Base UI {{{
  syntax on
  set number
  set foldenable                                      "enable folds by default
  set foldmethod=marker                               "fold via syntax of files

  let &colorcolumn=g:settings.max_column
  if g:settings.enable_cursorcolumn
    set cursorcolumn
    autocmd WinLeave * setlocal nocursorcolumn
    autocmd WinEnter * setlocal cursorcolumn
  endif
" }}}

" Base settings {{{
  set encoding=utf-8                                  "set encoding for text
  set history=1000                                    "number of command lines to remember
  set viewoptions=folds,options,cursor,unix,slash     "unix/windows compatibility

  set timeoutlen=300                                  "mapping timeout
  set ttimeoutlen=50                                  "keycode timeout


  " whitespace
  set backspace=indent,eol,start                      "allow backspacing everything in insert mode
  set autoindent                                      "automatically indent to match adjacent lines
  set expandtab                                       "spaces instead of tabs
  set smarttab                                        "use shiftwidth to enter tabs
  let &tabstop=g:settings.default_indent              "number of spaces per tab for display
  let &softtabstop=g:settings.default_indent          "number of spaces per tab in insert mode
  let &shiftwidth=g:settings.default_indent           "number of spaces when indenting
  set list                                            "highlight whitespace
  set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮
  set shiftround
  set linebreak
  let &showbreak='↪ '

  set scrolloff=1                                     "always show content after scroll
  set scrolljump=5                                    "minimum number of lines to scroll
  set display+=lastline
  set wildmenu                                        "show list for autocomplete
  set wildmode=list:full
  set wildignorecase

  " search
  set hlsearch                                        "highlight searches
  set incsearch                                       "incremental searching
  set ignorecase                                      "ignore case for searching
  set smartcase                                       "do case-sensitive if there's a capital letter"{{{
" }}}"}}}

" Folder management {{{
  function! Get_cache_dir(suffix) "{{{
    return resolve(expand(g:settings.cache_dir . '/' . a:suffix))
  endfunction "}}}

  function! EnsureExists(path) "{{{
    if !isdirectory(expand(a:path))
      call mkdir(expand(a:path))
    endif
  endfunction "}}}

  " persistent undo
  if exists('+undofile')
    set undofile
    let &undodir = Get_cache_dir('undo')
  endif

  " backups
  set backup
  let &backupdir = Get_cache_dir('backup')

  " swap files
  let &directory = Get_cache_dir('swap')
  set noswapfile

  call EnsureExists(g:settings.cache_dir)
  call EnsureExists(&undodir)
  call EnsureExists(&backupdir)
  call EnsureExists(&directory)
  "}}}

" Plugin Manager Setup {{{
let pm_directory = '/.vim/pm/'
let manager_readme=expand($HOME.pm_directory.'neobundle.vim/README.md')

if !filereadable(manager_readme)
  echo ""
  echo "Installing Plugin Manager..."
  echo ""
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

if count(g:myvim_plugin_groups, 'ui') "{{{
  echo "loading ui module..."
  silent curl https://github.com/crealive/myvim/blob/master/scripts/ui.vim > ~/.vim/scripts/ui.vim
  echo "...loading done."
"}}}

" Required:
call neobundle#begin(expand('~/.vim/plugins/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
filetype plugin indent on

for file in split(glob("~/.vim/scripts/*.vim"), '\n')
  exe 'source' file
endfor

call neobundle#end()
NeoBundleCheck

" }}}