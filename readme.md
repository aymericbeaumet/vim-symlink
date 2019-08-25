# symlink.vim

[symlink.vim](https://github.com/aymericbeaumet/symlink.vim) enables to
automatically follow the symlinks in Vim in a cross-platform way. This means
that if you edit a pathname that is a symlink, vim will instead open the file
using the resolved target path.

## Rationale

For example, if you keep your configuration files such as .bashrc in a Git
repository and symlink ~/.bashrc -> ~/dotfiles/.bashrc, plugins like
vim-fugitive will not realize the file is under version control as there's no
~/.git. But if you use this plugin, vim ~/.bashrc will edit ~/dotfiles/.bashrc
instead, and you will be able to use vim-fugitive.

[Read more](./doc/symlink.txt)
