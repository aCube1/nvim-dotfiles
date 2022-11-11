local dressing = require("dressing")

dressing.setup({
	input = {
		default_prompt = "➤ ",
		winhighlight = "Normal:Normal,NormalNC:Normal",
	},
	select = {
		backend = { "telescope", "builtin" },
		builtin = { winhighlight = "Normal:Normal,NormalNC:Normal" },
	},
})
