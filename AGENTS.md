# Development

- Initialize test helpers with `git submodule update --init --recursive`.
- Install the pinned tools with `mise install --locked` and the five explicit
  project tools from `mise.toml`; run `mise exec -- make all` for VimScript
  linting and the Vim and Neovim suites. Explicit tool arguments avoid pulling
  unrelated global mise tools into the project's locked install.
- Keep development tool versions in `mise.toml` and refresh `mise.lock` for
  Linux and macOS when changing them. CI uses the same configuration.
- Preserve the legacy editor versions in the CI compatibility matrix: they
  intentionally cover Vim 8.2 and Neovim 0.6 regressions. Their pins live in
  `mise.compat.toml` and `mise.compat.lock`.
- See `docs/development.md` for dependency maintenance and test details.
