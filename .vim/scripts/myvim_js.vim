if count(g:myvim_plugin_groups, 'js')

  NeoBundleLazy 'marijnh/tern_for_vim', {
      \ 'autoload': { 'filetypes': ['javascript'] },
      \ 'build': {
        \ 'mac': 'npm install',
        \ 'unix': 'npm install',
        \ 'cygwin': 'npm install',
        \ 'windows': 'npm install',
      \ },
    \ }

  NeoBundleLazy 'mmalecki/vim-node.js', {'autoload':{'filetypes':['javascript']}}
  NeoBundleLazy 'leshill/vim-json', {'autoload':{'filetypes':['javascript','json']}}
  NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {'autoload':{'filetypes':['javascript','coffee','ls']}}
  NeoBundleLazy 'pangloss/vim-javascript', {'autoload':{'filetypes':['javascript']}}
  NeoBundleLazy 'maksimr/vim-jsbeautify', {'autoload':{'filetypes':['javascript']}} "{{{
    nnoremap <leader>fjs :call JsBeautify()<cr>
  "}}}

endif
