local tbl_contains = vim.tbl_contains
local tbl_isempty = vim.tbl_isempty

utils.lsp = {}
utils.lsp.formatting = {
	format_on_save = { enabled = true },
}

utils.lsp.format_opts = vim.deepcopy(utils.lsp.formatting)
utils.lsp.format_opts.disabled = nil
utils.lsp.format_opts.format_on_save = nil
utils.lsp.format_opts.filter = function(client)
	local filter = utils.lsp.formatting.filter
	local disabled = utils.lsp.formatting.disabled or {}
	-- If client is fully disabled or filtered by function
	return not (tbl_contains(disabled, client.name) or (type(filter) == "function" and not filter(client)))
end


local function setup(server)
	local opts = utils.lsp.server_settings(server)
	require("lspconfig")[server].setup(opts)
end

local function on_attach(client, bufnr)
	local capabilities = client.server.capabilities
	local lsp_mappings = {
		n = {
			["<leader>ld"] = {
				function() vim.diagnostic.open_float() end,
				desc = "Open Diagnostics",
			},
			["gl"] = {
				function() vim.diagnostic.open_float() end,
				desc = "Open Diagnostics",
			},
			["[d"] = {
				function() vim.diagnostic.goto_prev() end,
				desc = "Previous Diagnostic",
			},
			["]d"] = {
				function() vim.diagnostic.goto_next() end,
				desc = "Next Diagnostic",
			},
		}
	}

	if capabilities.codeActionProvider then
		lsp_mappings.n["<leader>la"] = {
			function() vim.lsp.buf.code_action() end,
			desc = "LSP Code Action",
		}
		lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]
	end

	if capabilities.codeLensProvider then
		lsp_mappings.n["<leader>ll"] = {
			function() vim.lsp.codelens.refresh() end,
			desc = "LSP Codelens Refresh",
		}
		lsp_mappings.n["<leader>lL"] = {
			function() vim.lsp.codelens.run() end,
			desc = "LSP Codelens Run",
		}
	end

	if capabilities.declarationProvider then
		lsp_mappings.n["gD"] = {
			function() vim.lsp.buf.declaration() end,
			desc = "Declaration of Current Symbol",
		}
	end

	if capabilities.definitionsProvider then
		lsp_mappings.n["gd"] = {
			function() vim.lsp.buf.definition() end,
			desc = "Show the Definition of Current Symbol",
		}
	end

	if capabilities.documentFormattingProvider then
		lsp_mappings.n["<leader>lf"] = {
			function() vim.lsp.buf.format(utils.lsp.format_opts) end,
			desc = "Format Code",
		}
		lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]
	end

	vim.api.nvim_buf_create_user_command(
		bufnr,
		"Format",
		function() vim.lsp.buf.format(utils.lsp.format_opts) end,
		{ desc = "LSP Format File" }
	)

	local autoformat = utils.lsp.formatting.format_on_save
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
	if autoformat.enabled
	and (tbl_isempty(autoformat.allow_filetypes or {}) or tbl_contains(autoformat.allow_filetypes, filetype))
	and (tbl_isempty(autoformat.ignore_filetypes or {}) or not tbl_contains(autoformat.ignore_filetypes, filetype)) then
		local autocmd_group = ("auto_format_%d"):format(bufnr)
		vim.api.nvim_create_augroup(autocmd_group, { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = autocmd_group,
			buffer = bufnr,
			desc = ("Auto format buffer %d before save"):format(bufnr),
			callback = function()
				vim.lsp.buf.format(utils.default_table({ bufnr = bufnr }, utils.lsp.format_opts))
			end,
		})
	end

	if capabilities.documentHighlightProvider then
		local highlight_name = vim.fn.printf("lsp_document_highlight_%d", bufnr)
		vim.api.nvim_create_augroup(highlight_name, {})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = highlight_name,
			buffer = bufnr,
			callback = function() vim.lsp.buf.document_highlight() end,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = highlight_name,
			buffer = bufnr,
			callback = function() vim.lsp.buf.clear_references() end,
		})
	end

	if capabilities.renameProvider then
		lsp_mappings.n["<leader>lr"] = { function() vim.lsp.buf.rename() end, desc = "Rename current symbol" }
	end

	if capabilities.signatureHelpProvider then
		lsp_mappings.n["<leader>lh"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" }
	end

	utils.set_mappings(lsp_mappings, { buffer = bufnr })
	if not tbl_isempty(lsp_mappings.v) then
		utils.register_keys({
			v = { ["<leader>l"] = { name = "LSP" } },
		}, { buffer = bufnr })
	end
end

utils.lsp.capabilities = vim.lsp.protocol.make_client_capabilities()
utils.lsp.capabilities = vim.lsp.protocol.make_client_capabilities()
utils.lsp.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
utils.lsp.capabilities.textDocument.completion.completionItem.snippetSupport = true
utils.lsp.capabilities.textDocument.completion.completionItem.preselectSupport = true
utils.lsp.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
utils.lsp.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
utils.lsp.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
utils.lsp.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
utils.lsp.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
utils.lsp.capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

function utils.lsp.server_settings(server_name)
	local server = require("lspconfig")[server_name]
	local opts = {
		capabilities = vim.tbl_deep_extend("force", utils.lsp.capabilities, server.capabilities or {}),
		flags = server.flags or {},
	}

	opts.on_attach = function(client, bufnr)
		utils.conditional_function(server.on_attach, true, client, bufnr)
		utils.lsp.on_attach(client, bufnr)
	end

	return opts
end

return utils.lsp
