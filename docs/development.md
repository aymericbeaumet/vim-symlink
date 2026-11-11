# Development and dependencies

The plugin has no runtime dependencies. Development uses mise exclusively to
install the editors and lint tools. Start with mise 2026.11.6 or newer, Git,
and the host build prerequisites: a C compiler, Make, and ncurses headers
(on macOS, the Xcode Command Line Tools). These OS components remain host
prerequisites; no Homebrew, pip, or separate version-manager setup is needed.

```sh
mise trust
mise install --locked \
  'aqua:jdx/mise' 'asdf:mise-plugins/mise-vim' 'aqua:neovim/neovim' \
  'github:jdx/jactionlint' python uv 'pipx:vim-vint' taplo
git submodule update --init --recursive
mise run check
```

The explicit tool list excludes unrelated global mise tools from installation.
`mise run check` runs configuration lint, VimScript lint, and both editor test
suites. `mise run test` runs only tests. For one editor, use
`mise exec -- make test-vim` or `mise exec -- make test-nvim`. Tests cover
split, diff, tab, read-only, edge-case, and regression behavior.

## Reproducibility

`mise.toml` pins every tool and requires locked resolution for project tools.
`mise.lock` records downloadable artifacts and checksums for Linux x64 and
macOS arm64/x64. Vint's complete Python dependency graph is committed in
`.mise/locks/`; test helpers are Git submodules pinned to commits. CI uses
these same files and explicitly installs with `--locked`.

Vim is built from its pinned upstream version through a commit-pinned mise
plugin. The build options disable embedded language runtimes and GUI support,
so locally installed Python, Ruby, Perl, and Lua do not change the build.
Compiler and OS-library versions still come from the host: this is a locked
toolchain, not a claim of bit-for-bit identical Vim binaries across machines.
CI fixes the runner release to Ubuntu 24.04 and macOS 15.

Vint 0.3.21 still imports `pkg_resources`, removed in setuptools 82, so its
isolated environment pins setuptools 81.0.0. Python 3.14.10 is the newest
3.14 patch; Python 3.15.2 cannot resolve the locked graph because PyYAML has
no compatible wheels. Keep these compatibility constraints until upstream
supports upgrading them.

## Compatibility coverage

Vim 8.2.3995 and Neovim 0.6.1 intentionally remain in `mise.compat.toml` and
`mise.compat.lock` to cover the original regressions. To run on Linux:

```sh
MISE_ENV=compat mise install --locked \
  'asdf:mise-plugins/mise-vim' 'aqua:neovim/neovim'
MISE_ENV=compat mise exec -- make test
```

## Updating dependencies

Check `mise outdated --local --bump`, GitHub Actions releases, the Vim build
plugin, and both test submodules (`test/vader.vim` and `test/vim-bbye`). Keep
exact tool versions, full GitHub Action commit pins, and the legacy editor
versions. When updating mise itself, also update its minimum version and the
workflow's bootstrap version.

After editing tool pins, refresh locks before installing in locked mode:

```sh
mise lock python uv
mise install --locked python uv
mise exec python uv -- mise lock --bump --platform linux-x64,macos-arm64,macos-x64
mise lock -E compat --platform linux-x64
```

The pinned Python must be available to resolve Vint's wheel-only dependency
graph. Check lock output for warnings: a successful command can still fall
back to a version-only Vint entry when graph resolution fails. Require the
`uv` sidecar reference in Vint's lock entry before committing. Commit both
lockfiles and `.mise/locks/`, including `uv.lock` if a global ignore hides it.
Re-run the installation and checks above; CI also runs both legacy editors.
