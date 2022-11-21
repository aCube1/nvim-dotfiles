local is_plugin_available = utils.is_plugin_available
local maps = { i = {}, n = {}, v = {}, t = {}, [""] = {} }

-- [[ Normal ]]
maps[""]["<Space>"] = "<Nop>"
maps.n[";"] = { ":", desc = "Enter CMD Line", nowait = true }

-- Buffer delete --
if is_plugin_available("bufdelete.nvim") then
	maps.n["<leader>c"] = {
		function() require("bufdelete").bufdelete(0, false) end,
		desc = "Close buffer"
	}
else
	maps.n["<leader>c"] = {
		"<cmd>bdelete<cr>",
		desc = "Close buffer"
	}
end

-- Navigate buffers
if is_plugin_available("bufferline.nvim") then
	maps.n["<Tab>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
	maps.n["<S-Tab>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" }
else
	maps.n["<S-l>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
	maps.n["<S-h>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" }
end

-- Comment
if is_plugin_available("Comment.nvim") then
	maps.n["<leader>/"] = { function() require("Comment.api").toggle.linewise.current() end, desc = "Comment line" }
	maps.v["<leader>/"] = {
		"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
		desc = "Toggle comment line",
	}
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
	maps.n["<leader>lI"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
	maps.n["<leader>lU"] = { "<cmd>MasonToolsUpdate<cr>", desc = "Mason Update" }
end

-- LSP Installer
if is_plugin_available("mason-lspconfig.nvim") then
	maps.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" }
end

-- Telescope
if is_plugin_available("telescope.nvim") then
	maps.n["<leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Search words" }
	maps.n["<leader>fW"] = {
		function()
			require("telescope.builtin").live_grep {
				additional_args = function(args)
					return vim.list_extend(args, { "--hidden", "--no-ignore" })
				end,
			}
		end,
		desc = "Search words in all files",
	}

	maps.n["<leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Search files" }
	maps.n["<leader>fF"] = {
		function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
		desc = "Search all files",
	}
	maps.n["<leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "Search buffers" }
	maps.n["<leader>fh"] = { function() require("telescope.builtin").help_tags() end, desc = "Search help" }
	maps.n["<leader>fm"] = { function() require("telescope.builtin").marks() end, desc = "Search marks" }
	maps.n["<leader>fo"] = { function() require("telescope.builtin").oldfiles() end, desc = "Search history" }
	maps.n["<leader>fc"] = { function() require("telescope.builtin").grep_string() end, desc = "Search for word under cursor" }

	maps.n["<leader>ls"] = {
		function()
			local aerial_avail, _ = pcall(require, "aerial")
			if aerial_avail then
				require("telescope").extensions.aerial.aerial()
			else
				require("telescope.builtin").lsp_document_symbols()
			end
		end,
		desc = "Search symbols",
	}
	maps.n["<leader>lG"] = {
		function() require("telescope.builtin").lsp_workspace_symbols() end,
		desc = "Search workspace symbols"
	}
	maps.n["<leader>lR"] = {
		function() require("telescope.builtin").lsp_references() end,
		desc = "Search references"
	}
	maps.n["<leader>lD"] = {
		function() require("telescope.builtin").diagnostics() end,
		desc = "Search diagnostics"
	}
end

utils.set_mappings(maps)
