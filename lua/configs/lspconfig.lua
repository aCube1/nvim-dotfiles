vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local setup_servers = function()
	vim.tbl_map(utils.lsp.setup)
	vim.cmd("silent! do FileType")
end

if utils.is_plugin_available("mason-lspconfig.nvim") then
	vim.api.nvim_create_autocmd("User", { pattern = "LSPSetup", once = true, callback = setup_servers })
else
	setup_servers()
end

