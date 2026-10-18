# Development

- Initialize test helpers with `git submodule update --init --recursive`.
- Install the pinned tools with `mise install --locked` and the eight explicit
  project tools from `mise.toml`; run `mise exec -- make all` for configuration
  and VimScript linting and the Vim and Neovim suites. Explicit tool arguments
  avoid pulling unrelated global mise tools into the project's locked install.
- Keep development tool versions in `mise.toml` and refresh `mise.lock` for
  Linux and macOS when changing them. Commit the `.mise/locks/` sidecar with
  `mise.lock`, including `uv.lock` if a global ignore rule hides it. CI uses
  the same configuration.
- Preserve the legacy editor versions in the CI compatibility matrix: they
  intentionally cover Vim 8.2 and Neovim 0.6 regressions. Their pins live in
  `mise.compat.toml` and `mise.compat.lock`.
- See `docs/development.md` for dependency maintenance and test details.
