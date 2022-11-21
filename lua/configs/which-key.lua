--vim.cmd("packadd whichkey.nvim")
local which_key = require("which-key")

if which_key then
	which_key.setup({
		plugins = {
			spelling = { enabled = true },
			presets = { operators = false },
		},
		window = {
			border = "rounded",
			padding = { 2, 2, 2, 2 },
		},
		disable = {
			filetypes = { "TelescopePrompt" }
		},
	})
end
