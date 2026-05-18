if exists('g:symlink_loaded')
  finish
endif
let g:symlink_loaded = 1

let g:symlink_redraw = get(g:, 'symlink_redraw', 1)
let g:symlink_enabled = get(g:, 'symlink_enabled', 1)

if has('nvim-0.7')
  lua require('symlink').setup()
  finish
endif

let s:resolving = 0

function! s:resolve_symlink() abort
  if !g:symlink_enabled || s:resolving
    return
  endif

  let l:bufnr = bufnr('%')
  let l:buftype = getbufvar(l:bufnr, '&buftype')
  if !empty(l:buftype)
    return
  endif

  let l:fname = fnamemodify(bufname(l:bufnr), ':p')
  if empty(l:fname) || !filereadable(l:fname)
    return
  endif

  let l:resolved = resolve(l:fname)
  if l:resolved ==# l:fname
    return
  endif

  let s:resolving = 1
  try
    let l:existing = bufnr(l:resolved)
    if l:existing != -1 && l:existing != l:bufnr
      let l:winid = win_getid()
      execute 'buffer ' . l:existing
      execute 'silent! bwipeout ' . l:bufnr
      call win_gotoid(l:winid)
    else
      execute 'keepalt file ' . fnameescape(l:resolved)
      let l:old = bufnr(l:fname)
      if l:old != -1 && l:old != bufnr('%')
        execute 'silent! bwipeout ' . l:old
      endif
      filetype detect
    endif

    if g:symlink_redraw
      redraw
    endif

    silent! doautocmd <nomodeline> User SymlinkResolve
  finally
    let s:resolving = 0
  endtry
endfunction

augroup symlink_plugin
  autocmd!
  autocmd BufReadPost * call s:resolve_symlink()
augroup END
