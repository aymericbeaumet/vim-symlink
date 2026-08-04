local M = {}

local resolving = false
local pending_reopens = {}

local function buffer_exists(bufnr)
  return vim.fn.bufexists(bufnr) == 1
end

local function delete_buffer(bufnr)
  if not buffer_exists(bufnr) then
    return
  end

  pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
  if buffer_exists(bufnr) then
    vim.cmd('silent! bwipeout ' .. bufnr)
  end
end

local function goto_window(winid)
  return vim.fn.win_gotoid(winid) == 1
end

local function restore_window(winid)
  if winid ~= 0 then
    pcall(vim.fn.win_gotoid, winid)
  end
end

local function switch_windows_to_buffer(winids, target)
  local current = vim.fn.win_getid()
  for _, winid in ipairs(winids) do
    if goto_window(winid) then
      vim.cmd('keepalt buffer ' .. target)
    end
  end
  restore_window(current)
end

local function reopen_nvim_buffer(bufnr, resolved)
  if not buffer_exists(bufnr) then
    return
  end

  local winids = vim.fn.win_findbuf(bufnr)
  if #winids == 0 then
    return
  end

  local current = vim.fn.win_getid()
  if goto_window(winids[1]) and vim.api.nvim_get_current_buf() == bufnr then
    vim.cmd('keepalt file ' .. vim.fn.fnameescape(vim.fn.tempname()))
  end

  vim.cmd('badd ' .. vim.fn.fnameescape(resolved))
  local target = vim.fn.bufnr(resolved)
  switch_windows_to_buffer(winids, target)

  if buffer_exists(bufnr) and bufnr ~= vim.api.nvim_get_current_buf() then
    delete_buffer(bufnr)
  end
  restore_window(current)
end

function M.reopen_pending_nvim_buffers()
  local pending = pending_reopens
  pending_reopens = {}
  for _, item in ipairs(pending) do
    reopen_nvim_buffer(item.bufnr, item.resolved)
  end
end

function M.resolve_symlink()
  if vim.g.symlink_enabled == 0 or resolving then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.fn.getbufvar(bufnr, '&buftype')
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
      switch_windows_to_buffer(vim.fn.win_findbuf(bufnr), existing)
      delete_buffer(bufnr)
    else
      vim.cmd('keepalt file ' .. vim.fn.fnameescape(resolved))
      if vim.v.vim_did_enter == 0 and vim.fn.argc() > 1 then
        table.insert(pending_reopens, { bufnr = bufnr, resolved = resolved })
      else
        reopen_nvim_buffer(bufnr, resolved)
      end
    end

    if vim.g.symlink_redraw == 1 then
      vim.cmd('redraw')
    end

    vim.cmd('silent! doautocmd <nomodeline> User SymlinkResolve')
  end)

  resolving = false

  if not ok then
    local message = 'vim-symlink: ' .. tostring(err)
    if vim.notify then
      local level = vim.log and vim.log.levels and vim.log.levels.WARN or nil
      vim.notify(message, level)
    else
      vim.api.nvim_err_writeln(message)
    end
  end
end

function M.setup()
  if vim.g.symlink_redraw == nil then
    vim.g.symlink_redraw = 1
  end
  if vim.g.symlink_enabled == nil then
    vim.g.symlink_enabled = 1
  end

  vim.cmd([[
    augroup symlink_plugin
      autocmd!
      autocmd BufReadPost * lua require('symlink').resolve_symlink()
      autocmd VimEnter * lua require('symlink').reopen_pending_nvim_buffers()
    augroup END
  ]])
end

return M
