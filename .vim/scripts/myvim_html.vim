if count(g:myvim_plugin_groups, 'html')


  NeoBundleLazy 'groenewege/vim-less', {'autoload':{'filetypes':['less']}}
  NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload':{'filetypes':['scss','sass']}}
  NeoBundleLazy 'hail2u/vim-css3-syntax', {'autoload':{'filetypes':['css','scss','sass']}}
  NeoBundleLazy 'ap/vim-css-color', {'autoload':{'filetypes':['css','scss','sass','less','styl']}}
  NeoBundleLazy 'othree/html5.vim', {'autoload':{'filetypes':['html']}}
  NeoBundleLazy 'wavded/vim-stylus', {'autoload':{'filetypes':['styl']}}
  NeoBundleLazy 'digitaltoad/vim-jade', {'autoload':{'filetypes':['jade']}}
  NeoBundleLazy 'juvenn/mustache.vim', {'autoload':{'filetypes':['mustache']}}
  NeoBundleLazy 'gregsexton/MatchTag', {'autoload':{'filetypes':['html','xml']}}

" Emmet Html and CSS speed coding {{{
" Executes by tab {{{
  NeoBundleLazy 'mattn/emmet-vim', {'autoload':{'filetypes':['html','xml','xsl','xslt','xsd','css','sass','scss','less','mustache']}}
  function! s:zen_html_tab()
    let line = getline('.')
    if match(line, '<.*>') < 0
      return "\<c-y>,"
    endif
    return "\<c-y>n"
  endfunction
  autocmd FileType xml,xsl,xslt,xsd,css,sass,scss,less,mustache imap <buffer><tab> <c-y>,
  autocmd FileType html imap <buffer><expr><tab> <sid>zen_html_tab()
  " }}}
  "
  " @see http://docs.emmet.io/
  "
  " Element Operators:
  "
  " Child >
  " div>ul>li
  "
  " <div>
  "   <ul>
  "     <li></li>
  "   </ul>
  " </div>
  "
  "
  " Silbings +
  " div+p+bq
  "
  " <div></div>
  " <p></p>
  " <blockquote></blockquote>
  "
  " Climb up ^
  " div+div>p>span+em^bq
  "
  " <div></div>
  " <div>
  "   <p>
  "     <span></span>
  "     <em></em>
  "   </p>
  "   <blockquote></blockquote>
  " </div>
  "
  "
  " Grouping ()
  " div>(header>ul>li*2>a)+footer>p
  "
  " <div>
  "   <header>
  "     <ul>
  "       <li><a href=""></a></li>
  "       <li><a href=""></a></li>
  "     </ul>
  "   </header>
  "   <footer>
  "       <p></p>
  "   </footer>
  " </div>
  "
  "
  " Attribute Operators:
  "
  " ID and CLASS # .
  " div#header+div.page+div#footer.class1.class2.class3
  "
  " <div id="header"></div>
  " <div class="page"></div>
  " <div id="footer" class="class1 class2 class3"></div>
  "
  " Custom []
  " td[title="Hello world!" colspan=3]
  "
  " Counter
  " ul>li.item$*5
  "
  " <ul>
  "   <li class="item1"></li>
  "   <li class="item2"></li>
  "   <li class="item3"></li>
  "   <li class="item4"></li>
  "   <li class="item5"></li>
  " </ul>
  "
  "
  " Text {}
  "
  " a{Click me}
  " <a href="">Click me</a>
  "
  "
  " CSS:
  "
  " Colors C#
  " c#3 → color: #333;
  "
  " #1 → #111111
  " #e0 → #e0e0e0
  " #fc0 → #ffcc00
  "
  " Units
  "
  " m10 → margin: 10px;
  " m1.5 → margin: 1.5em;
  "
  " p → %
  " e → em
  " x → ex
  "
  " w100p → width: 100%
  " m10p30e5x → margin: 10% 30em 5ex
  "
  " Uniteless
  "
  " lh2 → line-height: 2;
  " fw400 → font-weight: 400;
  "
  " }}}


endif
