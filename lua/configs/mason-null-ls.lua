local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
	ensure_installed = { "stylua" },
	automatic_setup = true,
})
