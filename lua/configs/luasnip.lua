local luasnip = require("luasnip")

for _, load_type in ipairs({"lua", "snipmate"}) do
	local loader = require("luasnip.loaders.from_" .. load_type)
	loader.lazy_load()
end
