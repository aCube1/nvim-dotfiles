local lualine = require("lualine")

local colors = require("default_theme.colors")
local components = require("configs.lualine.components")

lualine.setup({
	options = {
		icons_enabled = vim.g.icons_enabled,
		global_status = true,
		theme = "catppuccin",
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = { 'dashboard', 'NvimTree', 'packer' },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { 
			components.mode
		},
		lualine_b = {
			components.branch
		},
		lualine_c = {
			components.diff
		},
		lualine_x = {
			components.diagnostics,
			--components.lsp,
			components.space,
			components.filetype,
		},
		lualine_y = { components.locations },
		lualine_z = { components.progress },
    },
	inactive_sections = {
		lualine_a = { components.mode },
		lualine_b = { components.branch },
		lualine_c = { components.diff },
		lualine_x = {
			components.diagnostics,
			--components.lsp,
			components.space,
			components.filetype,
		},
		lualine_y = { components.locations },
		lualine_z = { components.progress },
	},
	tabline = {},
	extensions = {},
})
