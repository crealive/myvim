if count(g:myvim_plugin_groups, 'vcs')


NeoBundle 'tpope/vim-fugitive' " fugitive.vim may very well be the best Git wrapper of all time {{{
" Stage current file: 
" :Git add %
" :Gwrite
"
" Commit (opens a commit window)
" :Gcommit
" After entering a message and saving and closing, the commit is executed
"
" Revert current file:
" :Git checkout %
" :Gread
"
" Blame (opens a split window)
" :Gblame
"
" Delete the file and buffer:
" :Git rm %
" :Gremove
"
" Rename the current file:
" :Git mv %
" :Gmove targe_path
" 
" Status (opens a status window)
" :Gstatus
"
" - 		add/remove from stage
" <Enter> 	open file under cursor
" p		git add -patch
" C 		invoke :Gcommit
"
" Diff (opens a split windoe
"
" Gedit
" Fugitive makes it possible to open a read only buffer with the contents of
" any file, on any local git branch. You can do this using the :Gedit command
" followed by an argument of the form: branchname:path/to/file.
autocmd User fugitive 
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
"
" History
"
" Load the last ten previous revisions of the current file into the quickfix list
" :Glog -10
"
" Load all ancestral commit objects that touched the current file into the
" quickfix list
" :Glog -- %
"
"
" Grep
"
" Find a text in current working tree
" :Ggrep findme
"
" Search for ‘findme’ in branch ‘branchname'
" :Ggrep findme branchname
"
" Search for ‘findme’ in all ancestral commit messages
" :Glog --grep=findme --
"
" Search for ‘findme’ in the diff for each ancestral commit that touches the
" currently active file
" :Glog -Sfindme -- %
"
"
"
"
"
autocmd BufReadPost fugitive://* set bufhidden=delete
" }}}


endif
