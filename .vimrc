" Global definitions
let g:myvim_settings = {}
let g:myvim_settings.default_indent = 2
let g:myvim_settings.max_column = 120
let g:myvim_settings.enable_cursorcolumn = 0
let g:myvim_settings.cache_dir = '~/.vim/.cache'

let s:myvim_scripts_directory = $HOME . "/.vim/scripts/"

let s:myvim_script_uri = "https://raw.githubusercontent.com/crealive/myvim/master/.vim/scripts/"

let mapleader = ","
let g:mapleader = ","


" Key mappings {{{
  nmap <leader><t> :so $MYVIMRC<CR>                 "reload vim configuration
  nnoremap <Return> :set hlsearch! hlsearch?<cr>          "show / hide search matchings
  inoremap jk <esc>
    inoremap kj <esc>
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

" Folder and file management {{{
  function! Get_cache_dir(suffix) "{{{
    return resolve(expand(g:myvim_settings.cache_dir . '/' . a:suffix))
  endfunction "}}}

  function AppendToFile(file, lines) " {{{
    if !filereadable(a:file)
      silent execute "!touch " . a:file
    endif

    call writefile(readfile(a:file)+a:lines, a:file)
  endfunction " }}}

  function! EnsureExists(path) "{{{
    if !isdirectory(expand(a:path))
      silent call mkdir(expand(a:path))
    endif
  endfunction "}}}

  " EnsureBaseConfiguration " {{{
  let s:base_configuration = fnamemodify(s:myvim_scripts_directory . 'base.vim' , ':p')
  function! EnsureBaseConfiguration()
    if !filereadable(s:base_configuration)
      silent execute "!mkdir -p " . s:myvim_scripts_directory
      "silent execute "!echo test >> " . s:base_configuration
      silent call AppendToFile(s:base_configuration, [
            \"let g:myvim_plugin_groups = \[\]",
            \"\"let g:myvim_plugin_groups = \[ \"editing\", \"ui\", \"vcs\", \"unite\", \"auto_completion\" \]",
            \"NeoBundle 'tpope/vim-sensible'"])
      "silent execute "!echo test >>" . s:base_configuration . "<<EOL   EOL"
      "let g:myvim_plugin_groups = \[ \\'ui\\', \\'editing\\', \\'vcs\\', \\'unite\\', \\'auto_completion\\' \] >> " . s:myvim_scripts_directory . "base.vim"
      "silent execute "!echo NeoBundle \\'tpope/vim-sensible\\' >> " . s:base_configuration
    endif
  endfunction " }}}

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

  if !exists('g:ownvim.plugin_groups')
    call EnsureBaseConfiguration()
  elseif
    let g:myvim_plugin_groups = g:ownvim.plugin_groups
  endif
  "}}}

" Plugin Manager Setup {{{
let s:pm_directory = $HOME . "/.vim/pm/"
let manager_readme = fnamemodify(s:pm_directory . 'neobundle.vim/README.md', ':p')

if !filereadable(manager_readme)
  echo ""
  echo "Installing Plugin Manager..."
  echo ""
  silent execute "!git clone https://github.com/Shougo/neobundle.vim " . s:pm_directory . "neobundle.vim"
  silent execute "!mkdir -p " . s:pm_directory
  silent execute "!mkdir -p $HOME/.vim/plugins"

  " Note: Skip initialization for vim-tiny or vim-small.
  if 0 | endif

  " Required:
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

" Required:
call neobundle#begin(expand('~/.vim/plugins/'))

function PluginsComplete() " {{{
  call neobundle#end()
  NeoBundleCheck
endfunction " }}}

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
filetype plugin indent on

" Modules {{{
  if filereadable(s:base_configuration)
      execute "source" s:base_configuration
  endif

  if !exists('g:myvim_plugin_groups')
    let g:myvim_plugin_groups = []
  endif

  function! DownloadIfNeeded(my_module) " {{{
    let module = a:my_module
    let path = fnamemodify(s:myvim_scripts_directory . 'myvim_' . module . '.vim', ':p')
    if !filereadable(path)
      silent execute "!curl " . s:myvim_script_uri . 'myvim_' . module . '.vim > ' . path
    endif
  endfunction " }}}

  if count(g:myvim_plugin_groups, 'ui') "{{{
    call DownloadIfNeeded('ui')
  endif "}}}

  if count(g:myvim_plugin_groups, 'editing') "{{{
    call DownloadIfNeeded('editing')
  endif "}}}

  if count(g:myvim_plugin_groups, 'vcs') "{{{
    call DownloadIfNeeded('vcs')
  endif "}}}

  if count(g:myvim_plugin_groups, 'unite') "{{{
    call DownloadIfNeeded('unite')
  endif "}}}

  if count(g:myvim_plugin_groups, 'auto_completion') "{{{
    call DownloadIfNeeded('auto_completion')
  endif "}}}
"}}}

for file in split(glob("~/.vim/scripts/*.vim"), '\n')
  exe 'source' file
endfor

if !exists('g:ownvim.plugin_groups')
  call PluginsComplete()
endif
" }}}
