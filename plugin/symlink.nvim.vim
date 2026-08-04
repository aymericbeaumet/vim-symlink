if !has('nvim') || exists('g:symlink_loaded')
  finish
endif
let g:symlink_loaded = 1

let g:symlink_redraw = get(g:, 'symlink_redraw', 1)
let g:symlink_enabled = get(g:, 'symlink_enabled', 1)
let g:symlink_implementation = 'lua'

lua require('symlink').setup()
