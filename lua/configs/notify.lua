local notify = require("notify")

notify.setup({
	stages = "fade_in_slide_out",
})

vim.notify = notify
