local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = "❯ ",
		path_display = { "truncate" },
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		mappings = {
			i = {
				["<Tab>"] = actions.cycle_history_next,
				["<S-Tab>"] = actions.cycle_history_prev,
				["<C-Right>"] = actions.move_selection_next,
				["<C-Left>"] = actions.move_selection_previous,
			},
			n = { ["q"] = actions.close },
		},
	},
})

utils.conditional_function(telescope.load_extension, pcall(require, "notify"), "notify")
utils.conditional_function(telescope.load_extension, pcall(require, "aerial"), "aerial")
