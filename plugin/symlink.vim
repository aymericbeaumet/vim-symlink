if exists('g:symlink_loaded')
  finish
endif
let g:symlink_loaded = 1

function! s:symlink_on_buf_read_post(...)
  let l:filename = (a:0 > 0) ? a:1 : expand('%')
  if !filereadable(l:filename)
    return
  endif
  let l:resolved = resolve(l:filename)
  if l:resolved ==# l:filename
    return
  endif
  enew
  bwipeout #
  exec 'edit ' . fnameescape(l:resolved)
  redraw
endfunction

augroup symlink_plugin
  autocmd!
  autocmd BufReadPost * nested call <SID>symlink_on_buf_read_post(expand('<afile>'))
augroup END
