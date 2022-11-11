require("core.utils")

local impatient = utils.safe_require("impatient")
if impatient then impatient.enable_profile() end


for _, plugin in ipairs({
	"core.options",
	"core.plugins",
	"core.mappings",
	"core.autocmds",
}) do
	utils.safe_require(plugin)
end
