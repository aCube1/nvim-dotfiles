-- Lazy loading
local status_ok, impatient = pcall(require, "impatient")
if status_ok then
	impatient.enable_profile()
end

for _, source in ipairs({
	"core.utils",
	"core.options",
	"core.bootstrap",
	"core.autocmds",
	"core.mappings",
	"configs.which-key-register",
}) do
	local status_ok, err = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln(("Failed to load %s\n\n%s"):format(source, err))
	end
end
