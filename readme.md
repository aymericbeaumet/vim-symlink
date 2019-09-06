# vim-symlink

[![travis](https://img.shields.io/travis/aymericbeaumet/vim-symlink?style=flat-square&logo=travis)](https://travis-ci.org/aymericbeaumet/vim-symlink)
[![github](https://img.shields.io/github/issues/aymericbeaumet/vim-symlink?style=flat-square&logo=github)](https://github.com/aymericbeaumet/vim-symlink/issues)

[vim-symlink](https://github.com/aymericbeaumet/vim-symlink) enables to
automatically follow the symlinks in Vim. This means that when you edit a
pathname that is a symlink, vim will instead open the file using the resolved
target path.

[![demo](./media/demo.gif)](./media/demo.gif)

## Features

- Cross-platform
- Recursive symlinks resolution
- [`vimdiff`](http://vimdoc.sourceforge.net/htmldoc/diff.html) support
- Allow to create new files in symlinked directories
- Make [vim-fugitive](https://github.com/tpope/vim-fugitive) behave properly
  with linked files

## Install

I recommend using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'moll/vim-bbye' " optional dependency
Plug 'aymericbeaumet/vim-symlink'
```

_[vim-bbye](https://github.com/moll/vim-bbye) allows to consistenly wipe
buffers without impacting the windows order. Even though a failover is
present in vim-symlink (hence avoiding a required dependency), the vim-bbye
implementation is more robust and I advise you to leverage it._

## Usage

Read more about the usage in [the documentation](./doc/symlink.txt).
