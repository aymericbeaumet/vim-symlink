# vim-symlink

[![travis](https://img.shields.io/travis/aymericbeaumet/vim-symlink?style=flat-square&logo=travis)](https://travis-ci.org/aymericbeaumet/vim-symlink)
[![github](https://img.shields.io/github/issues/aymericbeaumet/vim-symlink?style=flat-square&logo=github)](https://github.com/aymericbeaumet/vim-symlink/issues)

[vim-symlink](https://github.com/aymericbeaumet/vim-symlink) enables to
automatically follow the symlinks in Vim in a cross-platform way. This means
that when you edit a pathname that is a symlink, vim will instead open the
file using the resolved target path.

It will behave as expected even when facing edge-cases like:

- when running vim in diff mode
- when creating a new file in a symlinked directory

## Rationale

For example, if you keep your configuration files such as _.bashrc_ in a Git
repository and symlink _~/.bashrc_ to _~/dotfiles/.bashrc_, plugins like
[vim-fugitive](https://github.com/tpope/vim-fugitive) will not realize the
file is under version control as there's no _~/.git_. But if you use this
plugin, `vim ~/.bashrc` will edit _~/dotfiles/.bashrc_ instead, and
vim-fugitive will behave appropriately.

## Install

I recommend using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'moll/vim-bbye' " recommended dependency
Plug 'aymericbeaumet/vim-symlink'
```

Note the optional dependency to [vim-bbye](https://github.com/moll/vim-bbye):
it is used to consistenly wipeout buffers without impacting the windows order.

## Usage

Read more about the usage in [the documentation](./doc/symlink.txt).
