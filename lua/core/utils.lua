local stdpath = vim.fn.stdpath

_G.utils = {}

local install_path = stdpath("data") .. "/site/pack/packer/start/packer.nvim"

utils.compile_path = stdpath("data") .. "/site/plugin/packer_compiled.lua"
utils.package_root = stdpath("data") .. "/site/pack"

function utils.safe_require(path)
	local ok, module = pcall(require, path)
	if not ok then
		vim.notify(string.format("Error loading: %s", module), vim.log.levels.ERROR)
		return ok
	end

	return module
end

function utils.is_plugin_available(plugin)
	return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
end

-- Get highlight properties for given highlight name
function utils.get_hlgroup(name, fallback)
	if vim.fn.hlexists(name) == 1 then
		local hl = vim.api.nvim_get_hl_by_name(name, vim.o.termguicolors)
		if not hl["foreground"] then
			hl["foreground"] = "NONE"
		end
		if not hl["background"] then
			hl["background"] = "NONE"
		end
		hl.fg, hl.bg, hl.sp = hl.foreground, hl.background, hl.special
		hl.ctermfg, hl.ctermbg = hl.foreground, hl.background

		return hl
	else
		return fallback
	end
end

-- Register keys with which-key.
-- Doesn't work without which-key installed.
function utils.register_keys(maps, options)
	local which_key = utils.safe_require("which-key")

	if which_key then
		for mode, prefixes in pairs(maps) do
			for prefix, map_table in pairs(prefixes) do
				which_key.register(
					map_table,
					utils.default_table(options, {
						mode = mode,
						prefix = prefix,
						buffer = nil,
						silent = true,
						noremap = true,
						nowait = true,
					})
				)
			end
		end
	else
		vim.notify("Cannot load keymaps without which-key plugin", vim.log.levels.WARN)
	end
end

function utils.default_table(options, table)
	options = options or {}
	return default and vim.tbl_deep_extend("force", default, options) or options
end

function utils.check_packer()
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd("packadd packer.nvim")
	end
end

function utils.initialize_icons()
	utils.icons = require("core.icons")
end

function utils.get_icon(kind)
	if not utils.icons then utils.initialize_icons() end
	return utils.icons and utils.icons[kind] or ""
end
