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

## Install

Install with [packer](https://github.com/wbthomason/packer.nvim):

```lua
use { 'aymericbeaumet/vim-symlink', requires = { 'moll/vim-bbye' } }
```

Install with [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'aymericbeaumet/vim-symlink'
Plug 'moll/vim-bbye' " optional dependency
```

_Note: [vim-bbye](https://github.com/moll/vim-bbye) allows to consistenly wipe
buffers without impacting the windows order. Even though a fallback is present
in vim-symlink (hence avoiding a required dependency), the vim-bbye
implementation is more robust and I advise you to leverage it._

## Usage

Read more about the usage in [the documentation](./doc/symlink.txt).
