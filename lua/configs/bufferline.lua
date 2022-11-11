local bufferline = require("bufferline")

local close_fn = function(bufnum)
	local bufdelete = utils.safe_require("bufdelete")
	if bufdelete then
		bufdelete.bufdelete(bufnum, true)
	else
		vim.cmd["bdelete!"]({ args = { bufnum } })
	end
end

bufferline.setup({
	options = {
		offsets = {
			{ filetype = "NvimTree", text = "", padding = 1 },
			{ filetype = "neo-tree", text = "", padding = 1 },
			{ filetype = "Outline", text = "", padding = 1 },
		},
		buffer_close_icon = "",
		modified_icon = "",
		close_icon = "",
		close_command = close_func,
		right_mouse_command = close_func,
		max_name_length = 14,
		max_prefix_length = 13,
		tab_size = 20,
		separator_style = "thin",
  },
})
