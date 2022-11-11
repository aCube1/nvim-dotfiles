local luasnip = require("luasnip")

for _, load_type in ipairs({"vscode", "lua", "snipmate"}) do
	local loader = require("luasnipe.loaders.from_" .. load_type)
	loader.lazy_load()
end
