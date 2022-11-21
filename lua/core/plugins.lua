local on_file_open = { "BufRead", "BufWinEnter", "BufNewFile" }

local plugins = {
	{ "lewis6991/impatient.nvim" }, -- Optimiser
  	{ "andweeb/presence.nvim", config = function() require("presence"):setup() end }, -- Rich presence
	{ "nvim-lua/plenary.nvim", module = "plenary" }, -- Lua functions
	{ "Darazaki/indent-o-matic", event = "BufEnter" }, -- Indent detection
	{ "nvim-lualine/lualine.nvim", config = function() require("configs.lualine") end }, -- Statusline

  	{ "p00f/clangd_extensions.nvim" }, -- Clang extensions
  	{ "ntpeters/vim-better-whitespace" }, -- Trailing spaces

	{ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" }, -- Parenthesis highlighting
	{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }, -- Autoclose tags
	{ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" }, -- Context based commenting
	{ "rafamadriz/friendly-snippets", opt = true }, -- Snippet collection

	{ "neovim/nvim-lspconfig", config = function() require("configs.lspconfig") end }, -- Native LSP
  	{ "williamboman/mason.nvim", config = function() require("configs.mason") end }, -- Package Manager
	{ "jayp0521/mason-null-ls.nvim", after = "null-ls.nvim", config = function() require "configs.mason-null-ls" end }, -- null-ls manager
	{ "stevearc/aerial.nvim", module = "aerial", config = function() require "configs.aerial" end }, -- LSP symbols
	-- LSP manager
	{
		"williamboman/mason-lspconfig.nvim",
		after = "nvim-lspconfig",
		config = function() require "configs.mason-lspconfig" end,
	},

	-- Color highlighting
	{
		"NvChad/nvim-colorizer.lua",
		event = on_file_open,
		config = function() require("configs.colorizer") end,
	},

	-- Theme
	{
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({ flavour = "mocha" })
			vim.api.nvim_command("colorscheme catppuccin")
		end,
	},

	-- Notification Enhancer
	{
		"rcarriga/nvim-notify",
		event = "UIEnter",
		config = function() require("configs.notify") end,
	},

	-- Neovim UI Enhancer
	{
		"stevearc/dressing.nvim",
		event = "UIEnter",
		config = function() require("configs.dressing") end,
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
		config = function() require("configs.window-picker") end,
	},

	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		disable = not vim.g.icons_enabled,
		module = "nvim-web-devicons",
		config = function() require("configs.nvim-web-devicons") end,
	},
	-- LSP Icons
	{
		"onsails/lspkind.nvim",
		module = "lspkind",
		config = function() require("configs.lspkind") end,
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		module = "bufferline",
		event = "UIEnter",
		config = function() require("configs.bufferline") end,
	},

	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		module = "neo-tree",
		cmd = "Neotree",
		requires = { { "MunifTanjim/nui.nvim", module = "nui" } },
		setup = function() vim.g.neo_tree_remove_legacy_commands = true end,
		config = function() require("configs.neo-tree") end,
	},

	-- Keymaps popup
	{
		"folke/which-key.nvim",
		event = "BufWinEnter",
		module = "which-key",
		config = function() require("configs.which-key") end,
	},

	-- Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		run = function() require("nvim-treesitter.install").update({ with_sync = true })() end,
		event = "BufEnter",
		config = function() require("configs.treesitter") end,
	},

	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		module = "luasnip",
		wants = "friendly-snippets",
		config = function() require("configs.luasnip") end,
	},

	-- Completion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function() require("configs.cmp") end,
	},
	{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }, -- Snippet completion source
	{ "hrsh7th/cmp-buffer", after = "nvim-cmp" }, -- Buffer completion source
	{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" }, -- CmdLine completion source
	{ "hrsh7th/cmp-path", after = "nvim-cmp" }, -- Path completion source
	{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }, -- LSP completion source
	{
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
		after = "nvim-cmp",
    },

	-- Commenting
	{
		"numToStr/Comment.nvim",
		module = { "Comment", "Comment.api" },
		keys = { "gc", "gb" },
		config = function() require("configs.comment") end,
	},

	-- Fuzzy finder (ripgrep required)
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		module = "telescope",
		config = function() require("configs.telescope") end,
	},

	-- Fuzzy finder syntax support
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		after = "telescope.nvim",
		disable = vim.fn.executable("make") == 0,
		run = "make",
		config = function() require("telescope").load_extension("fzf") end,
	},

	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		config = function() require("configs.gitsigns") end,
	},

	-- Formatting and linting
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = on_file_open,
		config = function() require("configs.null-ls") end,
	},
}

return plugins
