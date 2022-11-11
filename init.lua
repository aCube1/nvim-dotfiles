require("core.utils")

local impatient = utils.safe_require("impatient")
if impatient then impatient.enable_profile() end

utils.safe_require("core.options")
utils.safe_require("core.plugins")
utils.safe_require("core.mappings")
utils.safe_require("core.autocmds")
utils.safe_require("configs.which-key-register")
