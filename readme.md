# vim-symlink [![GitHub Actions](https://github.com/aymericbeaumet/vim-symlink/actions/workflows/ci.yml/badge.svg)](https://github.com/aymericbeaumet/vim-symlink/actions/workflows/ci.yml)

**Open a symlink and edit its target by its real path.**

Keep your dotfiles wherever you like. vim-symlink makes Vim and Neovim use
the target's path when you open a symlink, so plugins such as
[vim-fugitive](https://github.com/tpope/vim-fugitive) can find its Git repository.

For example, with `~/.vimrc` linked to `~/dotfiles/vimrc`:

| Open `~/.vimrc` | Buffer path | Git repository beside the file |
| --- | --- | --- |
| Without vim-symlink | `~/.vimrc` | Your home directory may have none |
| With vim-symlink | `~/dotfiles/vimrc` | Your dotfiles repository |

Vim already reads and writes through symlinks. This plugin also gives the
buffer the real path. It leaves the symlink in place and does not change your
working directory.

[![Vim opening a symlink and showing its target path](./media/demo.gif)](./media/demo.gif)

No configuration or runtime dependencies. Native Lua for Neovim, VimScript
for Vim. Tested on Linux and macOS, including Vim 8.2 and Neovim 0.6 on Linux.

## Try it without changing your config

This macOS and Linux demo puts a link outside its target's Git repository.
In a terminal, run

```sh
demo_dir="$(mktemp -d)"
cd "$demo_dir"
git clone --depth 1 https://github.com/aymericbeaumet/vim-symlink.git
ln -s vim-symlink/readme.md notes.md
nvim -N -u NONE --cmd 'set runtimepath=./vim-symlink,$VIMRUNTIME' \
  --cmd 'runtime! plugin/symlink*.vim' notes.md
```

Use `vim` in place of `nvim` to try Vim. Try these commands in either editor.

| Run | What you see |
| --- | --- |
| `:echo expand('%:.')` | `vim-symlink/readme.md`, the tracked file you opened through `notes.md` |
| `:!git -C %:h log -1 --oneline` | The latest commit in the target's repository |
| `:pwd` | The temporary directory where you opened the link |

Quit with `:q`.

## Install

Add this to your [lazy.nvim](https://github.com/folke/lazy.nvim) plugin specs:

```lua
{ 'aymericbeaumet/vim-symlink', lazy = false }
```

Load it at startup so it can resolve the first file you open. No `setup()` call
is needed.

Install with [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'aymericbeaumet/vim-symlink'
```

Or use Vim's built-in packages:

```sh
git clone https://github.com/aymericbeaumet/vim-symlink.git \
  ~/.vim/pack/plugins/start/vim-symlink
```

For Neovim, use `${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/plugins/start/vim-symlink`
as the destination instead.

## Behavior

- Follows chains of symlinks and existing files inside symlinked directories.
- Reuses an already-open target buffer, including its unsaved edits.
- Supports splits, tabs, read-only mode, and `vimdiff`.
- Resolves readable files on `BufReadPost`; special buffers and broken links
  are left to the editor. New files in symlinked directories retain the
  editor's normal behavior.
- Uses the resolved path for the buffer. If your workflow depends on the link's
  name or location, disable resolution before opening it.

## Configuration

Both options default to `1`. Change them at runtime in Vimscript:

```vim
" Disable resolution for subsequent file reads; set to 1 to enable again
let g:symlink_enabled = 0

" Disable the extra redraw after resolution
let g:symlink_redraw = 0
```

In Lua, use `vim.g.symlink_enabled = 0` and `vim.g.symlink_redraw = 0`.
Disabling resolution does not rename buffers that have already been resolved.

To run a hook after resolution:

```vim
autocmd User SymlinkResolve echomsg expand('%:p')
```

See [`:help symlink`](./doc/symlink.txt) for the full reference.

## Contributing

Found a surprising interaction with another plugin? Please
[open an issue](https://github.com/aymericbeaumet/vim-symlink/issues/new) with your
editor version, a minimal config, and the symlink layout needed to reproduce it.

[Development instructions](./docs/development.md) cover the pinned mise
environment and the Vim/Neovim regression suites.

[MIT licensed](./license).
