if exists('g:symlink_loaded')
  finish
endif
let g:symlink_loaded = 1

let g:symlink_redraw = get(g:,'symlink_redraw', 1)

function! s:on_buf_read(filepath)
  let l:resolved = a:filepath
  while 1
    let l:next = resolve(expand(l:resolved))
    if !filereadable(l:next) || l:next ==# a:filepath
      return
    endif
    if l:next ==# l:resolved
      break
    endif
    let l:resolved = l:next
  endwhile

  if exists(':Bwipeout') " vim-bbye
    Bwipeout
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
