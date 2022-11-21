local is_plugin_available = utils.is_plugin_available

local mappings = {
	n = {
		["<leader>"] = {
			f = { name = "File" },
			p = { name = "Packages" },
			l = { name = "LSP" },
			u = { name = "UI" },
		},
	},
}

if is_plugin_available("gitsigns.nvim") or is_plugin_available("telescope.nvim") then
	mappings.n["<leader>"].g = { name = "Git" }
end

if is_plugin_available("Comment.nvim") then
	for _, mode in ipairs({ "n", "v" }) do
		if not mappings[mode] then
			mappings[mode] = {}
		end
		if not mappings[mode].g then
			mappings[mode].g = {}
		end
		mappings[mode].g.c = "Comment toggle linewise"
		mappings[mode].g.b = "Comment toggle blockwise"
	end
end

utils.register_keys(mappings)
