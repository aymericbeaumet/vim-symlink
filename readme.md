# vim-symlink [![GitHub Actions](https://github.com/aymericbeaumet/vim-symlink/actions/workflows/ci.yml/badge.svg)](https://github.com/aymericbeaumet/vim-symlink/actions/workflows/ci.yml)

[vim-symlink](https://github.com/aymericbeaumet/vim-symlink) enables to
automatically follow the symlinks in Vim or Neovim. This means that when you
edit a pathname that is a symlink, vim will instead open the file using the
resolved target path.

[![demo](./media/demo.gif)](./media/demo.gif)

## Features

- Cross-platform
- Recursive symlinks resolution
- [`vimdiff`](http://vimdoc.sourceforge.net/htmldoc/diff.html) support
- Allow to create new files in symlinked directories
- Make [vim-fugitive](https://github.com/tpope/vim-fugitive) behave properly
  with linked files
- Native Lua implementation for Neovim (0.7+) with VimScript fallback for Vim
- No dependencies required
- Runtime enable/disable via `g:symlink_enabled`
- `User SymlinkResolve` event for custom hooks

## Install

Install with [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ 'aymericbeaumet/vim-symlink' }
```

Install with [packer](https://github.com/wbthomason/packer.nvim):

```lua
use { 'aymericbeaumet/vim-symlink' }
```

Install with [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'aymericbeaumet/vim-symlink'
```

## Configuration

```vim
" Disable symlink resolution (default: 1)
let g:symlink_enabled = 0

" Disable redraw after resolution (default: 1)
let g:symlink_redraw = 0
```

## Usage

Read more about the usage in [the documentation](./doc/symlink.txt).
