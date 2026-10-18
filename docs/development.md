# Development and dependencies

The plugin has no runtime dependencies. Development uses mise, Vim, Neovim,
Python, uv, vim-vint, jactionlint, and Taplo, pinned in `mise.toml` and
`mise.lock`. CI uses the same versions on Ubuntu 24.04 and macOS 15. Mise
builds Vim through its asdf plugin and installs vim-vint in an isolated
environment through its pipx backend.

```sh
git submodule update --init --recursive
mise install --locked \
  'aqua:jdx/mise' 'asdf:mise-plugins/mise-vim' 'aqua:neovim/neovim' \
  'github:jdx/jactionlint' python uv 'pipx:vim-vint' taplo
mise exec -- make all
```

`make lint` checks CI and mise configuration and VimScript. `make test-vim`
and `make test-nvim` run the Vader suites, including split, diff, tab,
edge-case, and regression tests.

The compatibility jobs also use mise, with Vim 8.2.3995 and Neovim 0.6.1
from `mise.compat.toml` and `mise.compat.lock`. They run on Linux. To install
and run them locally on Linux:

```sh
MISE_ENV=compat mise install --locked \
  'aqua:jdx/mise' 'asdf:mise-plugins/mise-vim' 'aqua:neovim/neovim' \
  'github:jdx/jactionlint' python uv 'pipx:vim-vint' taplo
MISE_ENV=compat mise exec -- make test
```

When upgrading dependencies, check the pinned tools, GitHub Actions, and both
test submodules (`test/vader.vim` and `test/vim-bbye`). Refresh the lockfiles
with `mise lock --platform linux-x64,macos-arm64,macos-x64` and
`mise lock -E compat --platform linux-x64`. vim-vint 0.3.21 and the current
vim-bbye revision are still their latest upstream versions.

`mise.lock` also records vim-vint's Python dependency graph in `.mise/locks/`.
Commit both when changing Python tooling. Use mise 2026.10.13 or newer to read
the lockfile; CI pins the matching version.

Vint requires `pkg_resources`, which setuptools removed in version 82.
Its isolated environment therefore includes setuptools 81.0.0 explicitly;
keep that compatibility pin until Vint removes the import. Mise uses the
project's pinned Python 3.14.8 for its locked dependency graph. Python 3.15
does not yet have a usable PyYAML wheel for this graph.

Keep the legacy versions when upgrading development tools so the original
regression coverage remains intact.
