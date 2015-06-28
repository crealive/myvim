if count(g:myvim_plugin_groups, 'unite')


NeoBundle 'Shougo/unite.vim' "{{{
  let bundle = neobundle#get('unite.vim')
  function! bundle.hooks.on_source(bundle)
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#profile('default', 'context', {
          \ 'start_insert': 1
          \ })
  endfunction

  let g:unite_data_directory=GetCacheDir('unite')
  let g:unite_source_history_yank_enable=1
  let g:unite_source_rec_max_cache_files=5000

  if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C4'
    let g:unite_source_grep_recursive_opt=''
  elseif executable('ack')
    let g:unite_source_grep_command='ack'
    let g:unite_source_grep_default_opts='--no-heading --no-color -C4'
    let g:unite_source_grep_recursive_opt=''
  endif

  function! s:unite_settings()
    nmap <buffer> Q <plug>(unite_exit)
    nmap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <esc> <plug>(unite_exit)

    " Play nice with supertab
    let b:SuperTabDisabled=1

    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  endfunction

  autocmd FileType unite call s:unite_settings()

  nmap <space> [unite]
  nnoremap [unite] <nop>

  nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer file_mru bookmark<cr><c-u>
  nnoremap <silent> [unite]d :<C-u>Unite -auto-resize -buffer-name=files   -start-insert file_rec/async:!<cr>
  nnoremap <silent> [unite]f :<C-u>Unite -auto-resize -buffer-name=files   -start-insert file<cr>
  nnoremap <silent> [unite]r :<C-u>Unite -auto-resize -buffer-name=mru     -start-insert file_mru<cr>
  nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline -start-insert outline<cr>
  nnoremap <silent> [unite]y :<C-u>Unite -auto-resize -buffer-name=yank    history/yank<cr>
  nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffer  buffer<cr>
  nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>
  nnoremap <silent> [unite]e :VimFiler <cr>  "}}}


NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources':'file_mru'}}
NeoBundleLazy 'osyo-manga/unite-airline_themes', {'autoload':{'unite_sources':'airline_themes'}} "{{{
  nnoremap <silent> [unite]a :<C-u>Unite -winheight=10 -auto-preview -buffer-name=airline_themes airline_themes<cr>
"}}}

NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources':'colorscheme'}} "{{{
  nnoremap <silent> [unite]c :<C-u>Unite -winheight=10 -auto-preview -buffer-name=colorschemes colorscheme<cr>
  "}}}

NeoBundleLazy 'tsukkee/unite-tag', {'autoload':{'unite_sources':['tag','tag/file']}} "{{{
  nnoremap <silent> [unite]t :<C-u>Unite -auto-resize -buffer-name=tag tag tag/file<cr>
"}}}

NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}} "{{{
  nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
"}}}

NeoBundleLazy 'Shougo/unite-help', {'autoload':{'unite_sources':'help'}} "{{{
  nnoremap <silent> [unite]h :<C-u>Unite -auto-resize -buffer-name=help help<cr>
"}}}

NeoBundleLazy 'Shougo/junkfile.vim', {'autoload':{'commands':'JunkfileOpen','unite_sources':['junkfile','junkfile/new']}} "{{{
  let g:junkfile#directory=GetCacheDir('junk')
  nnoremap <silent> [unite]j :<C-u>Unite -auto-resize -buffer-name=junk junkfile junkfile/new<cr>
"}}}

NeoBundle 'Shougo/vimfiler.vim' " {{{
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1
  let g:vimfiler_enable_clipboard = 0
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_ignore_pattern = '\%(.DS_Store\|.pyc\|.git\w*\|.sw\w*\|.hg\|.svn\)$'
  let g:vimfiler_data_directory =  GetCacheDir("vimfiler")
  let g:vimfiler_force_overwrite_statusline = 0

  let g:vimfiler_tree_leaf_icon = ''
  let g:vimfiler_tree_opened_icon = '▾'
  let g:vimfiler_tree_closed_icon = '▸'
  let g:vimfiler_default_columns = ''
  let g:vimfiler_explorer_columns = ''
  let g:vimfiler_tree_indentation = 3
  let g:vimfiler_file_icon = '·'
  let g:vimfiler_marked_file_icon = '✩'
  let g:vimfiler_readonly_file_icon = '○'

  autocmd FileType vimfiler setlocal nonumber
  autocmd FileType vimfiler setlocal norelativenumber
  autocmd FileType vimfiler nunmap <buffer> <C-l>
  autocmd FileType vimfiler nunmap <buffer> <S-m>
  autocmd FileType vimfiler nmap <buffer> r   <Plug>(vimfiler_redraw_screen)
  autocmd FileType vimfiler nmap <buffer> u   <Plug>(vimfiler_switch_to_parent_directory)
  autocmd FileType vimfiler nmap <buffer> <Leader>n           <Plug>(vimfiler_new_file)
  autocmd FileType vimfiler nmap <buffer> <silent><Leader>r   <Plug>(vimfiler_rename_file)
  autocmd FileType vimfiler nmap <buffer> <silent><Leader>m   <Plug>(vimfiler_move_file)
  autocmd FileType vimfiler nmap <buffer> <S-m-k> <Plug>(vimfiler_make_directory)

    nmap <silent><buffer><expr> <Cr> vimfiler#smart_cursor_map(
      \ "\<Plug>(vimfiler_expand_tree)",
      \ "\<Plug>(vimfiler_edit_file)")

    nnoremap <C-o> :VimFilerExplorer -parent -toggle -status -split -simple -winwidth=30 -no-quit<CR>
" }}}



endif
