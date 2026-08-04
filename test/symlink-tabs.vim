" Issue #2: tab startup should keep one resolved file per tab, like split and
" diff startup keep one resolved file per window.
execute 'cd ' . fnameescape(expand('<sfile>:p:h'))

let v:errors = []

call assert_equal(2, tabpagenr('$'), 'tab count')
tabnext 1
call assert_equal('fixture/foo', expand('%:.'), 'first tab path')
call assert_equal(['foo'], getline(1, '$'), 'first tab content')
tabnext 2
call assert_equal('fixture/bar', expand('%:.'), 'second tab path')
call assert_equal(['bar'], getline(1, '$'), 'second tab content')

if !empty(v:errors)
  for s:error in v:errors
    echomsg s:error
  endfor
  cquit
endif

qall!
