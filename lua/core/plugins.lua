local plugins = {
	-- Optimiser
	{ "lewis6991/impatient.nvim" },

	-- Lua functions
	{
		"nvim-lua/plenary.nvim",
		module = "plenary"
	},

	-- Indent detection
	{
		"Darazaki/indent-o-matic",
		event = "BufEnter"
	},

	-- Notification Enhancer
	{
		"rcarriga/nvim-notify",
		event = "UIEnter",
		config = function() require "configs.notify" end,
	},

	-- Neovim UI Enhancer
	{
		"stevearc/dressing.nvim",
		event = "UIEnter",
		config = function() require "configs.dressing" end,
	},

	 -- Better buffer closing
	{
		"famiu/bufdelete.nvim",
		module = "bufdelete",
		cmd = { "Bdelete", "Bwipeout"},
	},
	{
		"s1n7ax/nvim-window-picker",
		tag = "v1.*",
		module = "window-picker",
		config = function() require "configs.window-picker" end,
	},

	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		disable = not vim.g.icons_enabled,
		module = "nvim-web-devicons",
		config = function() require "configs.nvim-web-devicons" end,
	},
	-- LSP Icons
	{
		"onsails/lspkind.nvim",
		disable = not vim.g.icons_enabled,
		module = "lspkind",
		config = function() require "configs.lspkind" end,
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		module = "bufferline",
		event = "UIEnter",
		config = function() require "configs.bufferline" end,
	},
	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		module = "neo-tree",
		cmd = "Neotree",
		requires = { { "MunifTanjim/nui.nvim", module = "nui" } },
		setup = function() vim.g.neo_tree_remove_legacy_commands = true end,
		config = function() require "configs.neo-tree" end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		config = function() require "configs.lualine" end
	},
	
	-- Keymaps popup
	{
		"folke/which-key.nvim",
		module = "which-key",
		config = function() require "configs.which-key" end,
	},

	-- Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		run = function() require("nvim-treesitter.install").update { with_sync = true }() end,
		event = "BufEnter",
		config = function() require "configs.treesitter" end,
	},
	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		config = function() require "configs.gitsigns" end,
	},
	-- Package Manager
  	{
  		"williamboman/mason.nvim",
  		config = function() require "configs.mason" end,
  	},
}

utils.check_packer()

local packer = utils.safe_require("packer")
if packer then
	packer.init({
		compile_path = utils.compile_path,
		package_root = utils.package_root,
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
		auto_clean = true,
		compile_on_sync = true,
	})

	packer.startup(function(use)
		use("wbthomason/packer.nvim") -- Install by default
		for _, plugin in ipairs(plugins) do
			use(plugin)
		end
	end)
end
