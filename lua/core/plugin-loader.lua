local loader = {}

local stdpath = vim.fn.stdpath

local packer_path = stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = stdpath("data") .. "/site/plugin/packerpacker_compiled.lua"
local package_root = stdpath("data") .. "/site/pack"

function loader.initialize()
	local packer_exists = vim.fn.empty(vim.fn.glob(packer_path)) == 0

	if not packer_exists then
		vim.fn.delete(packer_path, "rf") -- Remove old install

		-- Clone packer from the github
		vim.fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			packer_path
		})

		vim.cmd.packadd("packer.nvim")
		local packer_loaded, _ = pcall(require, "packer")
		packer_exists = packer_loaded

		if not packer_loaded then
			vim.api.nvim_err_writeln(("Failed to load packer: %s"):format(packer_path))
		end
	end

	local init_cfg = {
		package_root = package_root,
		compile_path = compile_path,
		max_jobs = 100,
		log = { level = "warn" },
		git = {
			clone_timeout = 120,
		},
		display = {
			open_fn = function()
				return require("packer.util").float { border = "rounded" }
			end,
		},
		auto_clean = true,
		compile_on_sync = true,
	}

	if packer_exists then
		local packer = require("packer")
		local run_me, _ = loadfile(compile_path)
		run_me()
		packer.init(init_cfg)
		require("core.plugins")
	end
end

function loader.load(plugins)
	local packer = utils.safe_require("packer")
	if not packer then return end

	packer.reset()
	packer.startup({
		function(use)
			use("wbthomason/packer.nvim") -- Install by default
			for _, plugin in ipairs(plugins) do
				use(plugin)
			end
		end,
	})
end

return loader
