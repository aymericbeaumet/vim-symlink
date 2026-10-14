# Development

- Initialize test helpers with `git submodule update --init --recursive`.
- Install the pinned tools with `mise install`; run `mise exec -- make all`
  for VimScript linting and the Vim and Neovim suites.
- Keep development tool versions in `mise.toml`, which is also used by CI.
- Preserve the legacy editor versions in the CI compatibility matrix: they
  intentionally cover Vim 8.2 and Neovim 0.6 regressions.
- See `docs/development.md` for dependency maintenance and test details.
