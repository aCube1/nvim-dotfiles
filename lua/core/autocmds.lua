local cmd = vim.cmd

cmd([[
	augroup packer_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])
