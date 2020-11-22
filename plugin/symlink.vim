if exists('g:symlink_loaded')
  finish
endif
let g:symlink_loaded = 1

let g:symlink_redraw = get(g:,'symlink_redraw', 1)

function! s:on_buf_read(filepath)
  if !filereadable(a:filepath)
    return
  endif

  let l:resolved = resolve(a:filepath)
  if l:resolved ==# a:filepath
    return
  endif

  if exists(':Bwipeout') " vim-bbye
    silent! Bwipeout
  else
    if &diff
      echoerr "symlink.vim: 'moll/vim-bbye' is required in order for this plugin to properly work in diff mode"
      return
    endif
    enew
    bwipeout #
  endif

  execute 'edit ' . fnameescape(l:resolved)

  if g:symlink_redraw
    redraw
  endif
endfunction

augroup symlink_plugin
  autocmd!
  autocmd BufRead * nested call s:on_buf_read(expand('<afile>'))
augroup END
