local is_plugin_available = utils.is_plugin_available

local maps = { i = {}, n = {}, v = {}, t = {}, [""] = {} }

maps[""]["<Space>"] = "<Nop>"
maps.n[";"] = { "<cmd><CR>", "Enter CMD Line", opts = { nowait = true }}

-- [[ Normal ]]
-- Buffer delete --
if is_plugin_available("bufdelete") then
	maps.n["<leader>c"] = {
		function()
			require("bufdelete").bufdelete(0, false)
		end,
		desc = "Close current buffer",
	}
else
	maps.n["<leader>c"] = { "<cmd>bdelete<cr>", desc = "Close current buffer" }
end

-- Navigate buffers  --
if is_plugin_available("bufferline.nvim") then
  maps.n["<S-Right>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" }
  maps.n["<S-Left>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer tab" }
  maps.n["<Tab>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" }
  maps.n["<S-Tab>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer tab" }
else
  maps.n["<S-Right>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
  maps.n["<S-Left>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" }
  maps.n["<Tab>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
  maps.n["<S-Tab>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" }
end

-- [[
for mode, keymaps in pairs(maps) do
	for keymap, options in pairs(keymaps) do
		if options then
			local command = options
			local keymap_opts = {}

			if type(options) == "table" then
				command = options[1] -- The first index is always the command
				keymap_opts = options.opts
			end

			vim.keymap.set(mode, keymap, command, keymap_opts)
		end
	end
end
--]]
