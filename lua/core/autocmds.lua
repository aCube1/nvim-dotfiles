local is_plugin_available = utils.is_plugin_available
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Reload config
vim.cmd([[
  augroup packer_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])

cmd("FileType", {
  desc = "Unlist quickfist buffers",
  group = augroup("unlist_quickfist", { clear = true }),
  pattern = "qf",
  callback = function() vim.opt_local.buflisted = false end,
})

if is_plugin_available("neo-tree.nvim") then
  cmd("BufEnter", {
    desc = "Open Neo-Tree on startup with directory",
    group = augroup("neotree_start", { clear = true }),
    callback = function()
      local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
      if stats and stats.type == "directory" then
        require("neo-tree.setup.netrw").hijack()
      end
    end,
  })
end
