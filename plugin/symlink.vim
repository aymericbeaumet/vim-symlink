if has('nvim') || exists('g:symlink_loaded')
  finish
endif
let g:symlink_loaded = 1

let g:symlink_redraw = get(g:, 'symlink_redraw', 1)
let g:symlink_enabled = get(g:, 'symlink_enabled', 1)

let g:symlink_implementation = 'vim'

let s:resolving = 0
let s:pending_reopens = []

function! s:switch_windows_to_buffer(winids, target) abort
  let l:current = win_getid()
  for l:winid in a:winids
    if win_gotoid(l:winid)
      execute 'keepalt buffer ' . a:target
    endif
  endfor
  if l:current != 0
    call win_gotoid(l:current)
  endif
endfunction

function! s:reopen_vim_buffer(bufnr, resolved) abort
  if !bufexists(a:bufnr)
    return
  endif

  let l:winids = win_findbuf(a:bufnr)
  if empty(l:winids)
    return
  endif

  let l:current = win_getid()
  if win_gotoid(l:winids[0]) && bufnr('%') == a:bufnr
    execute 'keepalt file ' . fnameescape(tempname())
  endif

  execute 'badd ' . fnameescape(a:resolved)
  let l:target = bufnr(a:resolved)
  call s:switch_windows_to_buffer(l:winids, l:target)

  if bufexists(a:bufnr) && a:bufnr != bufnr('%')
    execute 'silent! bwipeout ' . a:bufnr
  endif
  if l:current != 0
    call win_gotoid(l:current)
  endif
endfunction

function! s:reopen_pending_vim_buffers() abort
  let l:pending = s:pending_reopens
  let s:pending_reopens = []
  for l:item in l:pending
    call s:reopen_vim_buffer(l:item.bufnr, l:item.resolved)
  endfor
endfunction

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
      call s:switch_windows_to_buffer(win_findbuf(l:bufnr), l:existing)
      execute 'silent! bwipeout ' . l:bufnr
    else
      execute 'keepalt file ' . fnameescape(l:resolved)
      if !v:vim_did_enter && argc() > 1
        call add(s:pending_reopens, {'bufnr': l:bufnr, 'resolved': l:resolved})
      else
        call s:reopen_vim_buffer(l:bufnr, l:resolved)
      endif
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
  autocmd VimEnter * call s:reopen_pending_vim_buffers()
augroup END
