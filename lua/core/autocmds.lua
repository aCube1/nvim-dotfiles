local cmd = vim.cmd

-- Reload config
cmd([[
	augroup packer_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])
