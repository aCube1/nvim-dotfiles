local is_plugin_available = utils.is_plugin_available

local mappings = {
  n = {
    ["<leader>"] = {
      f = { name = "File" },
      p = { name = "Packages" },
      l = { name = "LSP" },
      u = { name = "UI" },
    },
  },
}

local extra_sections = {
  g = "Git",
  s = "Search",
  S = "Session",
  t = "Terminal",
}

local function init_table(mode, prefix, idx)
  if not mappings[mode][prefix][idx] then
    mappings[mode][prefix][idx] = { name = extra_sections[idx] }
  end
end

if is_plugin_available("gitsigns.nvim") then
	init_table("n", "<leader>", "g")
end

if is_plugin_available("telescope.nvim") then
  init_table("n", "<leader>", "s")
  init_table("n", "<leader>", "g")
end

if is_plugin_available("Comment.nvim") then
  for _, mode in ipairs { "n", "v" } do
    if not mappings[mode] then mappings[mode] = {} end
    if not mappings[mode].g then mappings[mode].g = {} end
    mappings[mode].g.c = "Comment toggle linewise"
    mappings[mode].g.b = "Comment toggle blockwise"
  end
end

utils.register_keys(mappings)
