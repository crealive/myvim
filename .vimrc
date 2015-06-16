" Global definitions
let g:myvim_settings = {}
let g:myvim_settings.default_indent = 2
let g:myvim_settings.max_column = 120
let g:myvim_settings.enable_cursorcolumn = 0
let g:myvim_settings.cache_dir = '~/.vim/.cache'


" available groups: 'ui', 'editing', 'vcs', 'unite'
let g:myvim_plugin_groups = [ 'ui', 'editing',  'vcs', 'unite', 'auto_completion' ]
" let g:myvim_plugin_groups = []

let s:myvim_script_uri = "https://raw.githubusercontent.com/crealive/myvim/master/.vim/scripts/"

let mapleader = ","
let g:mapleader = ","


" Key mappings {{{
  nmap <leader><t> :so $MYVIMRC<CR>                 "reload vim configuration
  nnoremap <Return> :set hlsearch! hlsearch?<cr>          "show / hide search matchings
" }}}

" Base UI {{{
  syntax on
  set number
  set foldenable                                      "enable folds by default
  set foldmethod=marker                               "fold via syntax of files

  let &colorcolumn=g:myvim_settings.max_column
  if g:myvim_settings.enable_cursorcolumn
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

  set hidden                                          "allow buffer switching without saving
  set autoread                                        "auto reload if file saved externally
  set fileformats+=mac                                "add mac to auto-detection of file format line endings

  " whitespace
  set backspace=indent,eol,start                      "allow backspacing everything in insert mode
  set autoindent                                      "automatically indent to match adjacent lines
  set expandtab                                       "spaces instead of tabs
  set smarttab                                        "use shiftwidth to enter tabs
  let &tabstop=g:myvim_settings.default_indent              "number of spaces per tab for display
  let &softtabstop=g:myvim_settings.default_indent          "number of spaces per tab in insert mode
  let &shiftwidth=g:myvim_settings.default_indent           "number of spaces when indenting
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
  set smartcase                                       "do case-sensitive if there's a capital letter
" }}}

" Folder management {{{
  function! Get_cache_dir(suffix) "{{{
    return resolve(expand(g:myvim_settings.cache_dir . '/' . a:suffix))
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

  silent !mkdir -p $HOME/.vim/pm/
  call EnsureExists(g:myvim_settings.cache_dir)
  call EnsureExists(&undodir)
  call EnsureExists(&backupdir)
  call EnsureExists(&directory)
  "}}}

" Plugin Manager Setup {{{
let pm_directory = '/.vim/pm/'
let s:scripts_directory = '/.vim/scripts/'
let manager_readme=expand($HOME.pm_directory.'neobundle.vim/README.md')

if !filereadable(manager_readme)
  echo ""
  echo "Installing Plugin Manager..."
  echo ""
  silent !mkdir -p $HOME/.vim/pm/
  silent !mkdir -p $HOME/.vim/scripts
  silent !mkdir -p $HOME/.vim/plugins

  " Note: Skip initialization for vim-tiny or vim-small.
  if 0 | endif

  " Required:
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/pm/neobundle.vim
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
endif

" Modules {{{
  function! Download(my_module)
    let module = a:my_module
    let path = fnamemodify($HOME . s:scripts_directory . 'myvim_' . module . '.vim', ':p')
    if !filereadable(path)
      silent execute "!curl " . s:myvim_script_uri . 'myvim_' . module . '.vim > ' . path
    endif
  endfunction

  if count(g:myvim_plugin_groups, 'ui') "{{{
    call Download('ui')
  endif "}}}

  if count(g:myvim_plugin_groups, 'editing') "{{{
    call Download('editing')
  endif "}}}

  if count(g:myvim_plugin_groups, 'vcs') "{{{
    call Download('vcs')
  endif "}}}

  if count(g:myvim_plugin_groups, 'unite') "{{{
    call Download('unite')
  endif "}}}

  if count(g:myvim_plugin_groups, 'auto_completion') "{{{
    call Download('auto_completion')
  endif "}}}
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
