if count(g:myvim_plugin_groups, 'auto_completion')



  if has('lua')
      let g:myvim_settings.autocomplete_method = 'neocomplete'
  else
      let g:myvim_settings.autocomplete_method = 'neocomplcache'
  endif

  if g:myvim_settings.autocomplete_method == 'neocomplete' "{{{
    NeoBundleLazy 'Shougo/neocomplete.vim', {'autoload':{'insert':1}, 'vim_version':'7.3.885'} "{{{
      let g:neocomplete#enable_at_startup=1
      let g:neocomplete#data_directory=Get_cache_dir('neocomplete')
    "}}}
  endif "}}}

  if g:myvim_settings.autocomplete_method == 'neocomplcache' "{{{
    NeoBundleLazy 'Shougo/neocomplcache.vim', {'autoload':{'insert':1}} "{{{
      let g:neocomplcache_enable_at_startup=1
      let g:neocomplcache_temporary_dir=Get_cache_dir('neocomplcache')
      let g:neocomplcache_enable_fuzzy_completion=1
    "}}}
  endif "}}}

  NeoBundle 'Shougo/neosnippet.vim' "{{{ The Neosnippet plug-In adds snippet support to Vim.
    " Snippets are small templates for commonly used code that you can fill in on the fly

    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
    let g:neosnippet#enable_snipmate_compatibility=1

    imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
    smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
  " }}}

  NeoBundle 'Shougo/neosnippet-snippets' " Snippet repository


endif
