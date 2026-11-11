# Development

- Use mise 2026.11.6+ and the explicit locked install in `docs/development.md`;
  initialize test helpers with `git submodule update --init --recursive`.
- Run `mise run check` for configuration/VimScript lint and both editor suites.
- Keep exact tools, full Action SHAs, and the Vim build-plugin commit pinned.
  Refresh `mise.lock` for Linux x64 and macOS arm64/x64 and commit `.mise/locks/`
  sidecars, including `uv.lock` if globally ignored. A successful `mise lock`
  can warn and omit Vint's dependency graph; verify its `uv` sidecar reference.
- Preserve Vim 8.2 and Neovim 0.6 in `mise.compat.toml`/`mise.compat.lock`;
  these intentionally test legacy regressions on Linux.
- Keep Vim's explicit build options independent of host language runtimes.
- See `docs/development.md` for setup, compatibility constraints, and updates.
