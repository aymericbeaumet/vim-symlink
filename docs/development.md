# Development and dependencies

The plugin has no runtime dependencies. Development uses Vim, Neovim, Python,
uv, and vim-vint, pinned in `mise.toml`. CI uses the same versions on Linux
and macOS. Mise builds Vim through its asdf plugin and installs vim-vint in
an isolated environment through its pipx backend.

```sh
git submodule update --init --recursive
mise install
mise exec -- make all
```

`make lint` checks VimScript. `make test-vim` and `make test-nvim` run the
Vader suites, including split, diff, tab, edge-case, and regression tests.

When upgrading dependencies, check the pinned tools, GitHub Actions, and both
test submodules (`test/vader.vim` and `test/vim-bbye`). vim-vint 0.3.21 and the
current vim-bbye revision are still their latest upstream versions.

Vint requires `pkg_resources`, which setuptools removed in version 82.
Its isolated environment therefore includes setuptools 81.0.0 explicitly;
keep that compatibility pin until Vint removes the import. The explicit
Python argument also keeps older mise versions from selecting uv's default
interpreter instead of the project's pinned Python.

The separate CI compatibility matrix deliberately uses Vim 8.2.3995 and
Neovim 0.6.1. Keep those versions when upgrading development tools so that
the original regression coverage remains intact.
