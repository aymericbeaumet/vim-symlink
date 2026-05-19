local M = {}

local resolving = false

local function resolve_symlink()
  if vim.g.symlink_enabled == 0 or resolving then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.bo[bufnr].buftype
  if buftype ~= '' then
    return
  end

  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == '' then
    return
  end

  fname = vim.fn.fnamemodify(fname, ':p')
  if vim.fn.filereadable(fname) == 0 then
    return
  end

  local resolved = vim.fn.resolve(fname)
  if resolved == fname then
    return
  end

  resolving = true

  local ok, err = pcall(function()
    local existing = vim.fn.bufnr(resolved)
    if existing ~= -1 and existing ~= bufnr then
      local winid = vim.api.nvim_get_current_win()
      vim.api.nvim_set_current_buf(existing)
      vim.api.nvim_buf_delete(bufnr, { force = true })
      vim.api.nvim_set_current_win(winid)
    else
      vim.api.nvim_buf_set_name(bufnr, resolved)
      local old = vim.fn.bufnr(fname)
      if old ~= -1 and old ~= bufnr then
        pcall(vim.api.nvim_buf_delete, old, { force = true })
      end
      vim.cmd('filetype detect')
    end

    if vim.g.symlink_redraw == 1 then
      vim.cmd('redraw')
    end

    vim.api.nvim_exec_autocmds('User', { pattern = 'SymlinkResolve' })
  end)

  resolving = false

  if not ok then
    vim.notify('vim-symlink: ' .. tostring(err), vim.log.levels.WARN)
  end
end

function M.setup()
  vim.api.nvim_create_augroup('symlink_plugin', { clear = true })
  vim.api.nvim_create_autocmd('BufReadPost', {
    group = 'symlink_plugin',
    pattern = '*',
    callback = resolve_symlink,
  })
end

return M
