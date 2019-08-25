# symlink.vim

[![travis](https://img.shields.io/travis/aymericbeaumet/symlink.vim?style=flat-square&logo=travis)](https://travis-ci.org/aymericbeaumet/symlink.vim)
[![github](https://img.shields.io/github/issues/aymericbeaumet/symlink.vim?style=flat-square&logo=github)](https://github.com/aymericbeaumet/symlink.vim/issues)

[symlink.vim](https://github.com/aymericbeaumet/symlink.vim) enables to
automatically follow the symlinks in Vim in a cross-platform way. This means
that if you edit a pathname that is a symlink, vim will instead open the file
using the resolved target path.

## Rationale

For example, if you keep your configuration files such as _.bashrc_ in a Git
repository and symlink _~/.bashrc_ to _~/dotfiles/.bashrc_, plugins like
[vim-fugitive](https://github.com/tpope/vim-fugitive) will not realize the file
is under version control as there's no _~/.git_. But if you use this plugin,
`vim ~/.bashrc` will edit _~/dotfiles/.bashrc_ instead, and you will be able to
use vim-fugitive.

## Install

I recommend using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'aymericbeaumet/symlink.vim'
```

## Usage

Discover the usage and the configuration of this plugin in [the
documentation](./doc/symlink-vim.txt).
