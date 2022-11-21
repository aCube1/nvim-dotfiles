local null_ls = require("null-ls")
local builtins = null_ls.builtins

null_ls.setup({
	sources = {
		-- [[ Formatting ]]
		builtins.formatting.clang_format, -- C/C++
		builtins.formatting.stylua, -- Lua

		-- [[ Diagnostics ]]
		builtins.diagnostics.cspell, -- All
		builtins.diagnostics.clang_check, -- C/C++
		builtins.diagnostics.selene, -- Lua

		-- [[ Completion ]]
		builtins.completion.luasnip, -- Lua
	},
	on_attach = utils.lsp.setup,
})
