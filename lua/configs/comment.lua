local comment = require("Comment")
local comment_utils = require("Comment.utils")

comment.setup({
	pre_hook = function(ctx)
		local location = nil
		if ctx.ctype == comment_utils.ctype.blockwise then
			location = require("ts_context_commentstring.utils").get_cursor_location()
		elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
			location = require("ts_context_commentstring.utils").get_visual_start_location()
		end

		return require("ts_context_commentstring.internal").calculate_commentstring {
			key = ctx.ctype == comment_utils.ctype.linewise and "__default" or "__multiline",
			location = location,
		}
	end,
})
