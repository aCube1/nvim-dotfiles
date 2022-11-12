local is_plugin_available = utils.is_plugin_available
local which_key = utils.safe_require("which-key")

local maps = { i = {}, n = {}, v = {}, t = {}, [""] = {} }


-- [[ Normal ]]
maps[""]["<Space>"] = "<Nop>"
maps.n[";"] = { "<cmd><CR>", desc = "Enter CMD Line", nowait = true }

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

-- Navigate buffers
if is_plugin_available("bufferline.nvim") then
	vim.api.nvim_err_writeln("HEHE")
	maps.n["<S-Right>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
	maps.n["<S-Left>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" }
	maps.n["<Tab>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
	maps.n["<S-Tab>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" }
else
	maps.n["<S-Right>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
	maps.n["<S-Left>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" }
	maps.n["<Tab>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
	maps.n["<S-Tab>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" }
end

-- Packer
maps.n["<leader>pc"] = { "<cmd>PackerCompile<cr>", desc = "Packer Compile" }
maps.n["<leader>pi"] = { "<cmd>PackerInstall<cr>", desc = "Packer Install" }
maps.n["<leader>ps"] = { "<cmd>PackerSync<cr>", desc = "Packer Sync" }
maps.n["<leader>pS"] = { "<cmd>PackerStatus<cr>", desc = "Packer Status" }
maps.n["<leader>pu"] = { "<cmd>PackerUpdate<cr>", desc = "Packer Update" }

-- NeoTree
if is_plugin_available("neo-tree.nvim") then
  maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
  maps.n["<leader>o"] = { "<cmd>Neotree focus<cr>", desc = "Focus Explorer" }
end

-- Package Manager
if is_plugin_available("mason.nvim") then
	maps.n["<leader>pI"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
end

if is_plugin_available("mason-tool-installer.nvim") then
  maps.n["<leader>pU"] = { "<cmd>MasonToolsUpdate<cr>", desc = "Mason Update" }
end

-- [[
for mode, keymaps in pairs(maps) do
	for keymap, options in pairs(keymaps) do
		if options then
			local command = options
			local keymap_opts = {}

			if type(options) == "table" then
				command = options[1] -- The first index is always the command
				keymap_opts = options
				keymap_opts[1] = nil
			end

			vim.keymap.set(mode, keymap, command, keymap_opts)
		end
	end
end
--]]

