# Development and dependencies

The plugin has no runtime dependencies. Development uses Vim, Neovim, Python,
uv, and vim-vint, pinned in `mise.toml` and `mise.lock`. CI uses the same
versions on Ubuntu 24.04 and macOS 15. Mise builds Vim through its asdf plugin
and installs vim-vint in an isolated environment through its pipx backend.

```sh
git submodule update --init --recursive
mise install --locked 'asdf:mise-plugins/mise-vim' 'aqua:neovim/neovim' python uv 'pipx:vim-vint'
mise exec -- make all
```

`make lint` checks VimScript. `make test-vim` and `make test-nvim` run the
Vader suites, including split, diff, tab, edge-case, and regression tests.

The compatibility jobs also use mise, with Vim 8.2.3995 and Neovim 0.6.1
from `mise.compat.toml` and `mise.compat.lock`. They run on Linux. To install
and run them locally on Linux:

```sh
MISE_ENV=compat mise install --locked 'asdf:mise-plugins/mise-vim' 'aqua:neovim/neovim' python uv 'pipx:vim-vint'
MISE_ENV=compat mise exec -- make test
```

When upgrading dependencies, check the pinned tools, GitHub Actions, and both
test submodules (`test/vader.vim` and `test/vim-bbye`). Refresh the lockfiles
with `mise lock --platform linux-x64,macos-arm64,macos-x64` and
`mise lock -E compat --platform linux-x64`. vim-vint 0.3.21 and the current
vim-bbye revision are still their latest upstream versions.

Vint requires `pkg_resources`, which setuptools removed in version 82.
Its isolated environment therefore includes setuptools 81.0.0 explicitly;
keep that compatibility pin until Vint removes the import. The explicit
Python argument also keeps older mise versions from selecting uv's default
interpreter instead of the project's pinned Python.

Keep the legacy versions when upgrading development tools so the original
regression coverage remains intact.
