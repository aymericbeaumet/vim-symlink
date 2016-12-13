function! s:Symlink_OnBufReadPost(...)
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

augroup Symlink
  autocmd!
  autocmd BufReadPost * nested call <SID>Symlink_OnBufReadPost(expand('<afile>'))
augroup END
