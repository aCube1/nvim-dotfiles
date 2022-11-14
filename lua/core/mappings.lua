local maps = { i = {}, n = {}, v = {}, t = {}, [""] = {} }

-- [[ Normal ]]
maps[""]["<Space>"] = "<Nop>"
maps.n[";"] = { ":", desc = "Enter CMD Line", nowait = true }

-- Buffer delete --
maps.n["<leader>c"] = {
	function()
		require("bufdelete").bufdelete(0, false)
	end,
	desc = "Close current buffer",
}

-- Navigate buffers
maps.n["<Tab>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
maps.n["<S-Tab>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" }

-- Packer
maps.n["<leader>pc"] = { "<cmd>PackerCompile<cr>", desc = "Packer Compile" }
maps.n["<leader>pi"] = { "<cmd>PackerInstall<cr>", desc = "Packer Install" }
maps.n["<leader>ps"] = { "<cmd>PackerSync<cr>", desc = "Packer Sync" }
maps.n["<leader>pS"] = { "<cmd>PackerStatus<cr>", desc = "Packer Status" }
maps.n["<leader>pu"] = { "<cmd>PackerUpdate<cr>", desc = "Packer Update" }

-- NeoTree
maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
maps.n["<leader>o"] = { "<cmd>Neotree focus<cr>", desc = "Focus Explorer" }

-- Package Manager
maps.n["<leader>pI"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
maps.n["<leader>pU"] = { "<cmd>MasonToolsUpdate<cr>", desc = "Mason Update" }

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

