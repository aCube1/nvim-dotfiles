local o = vim.opt
local g = vim.g

-- [[ Appearance ]]
o.backspace = vim.opt.backspace + { "nostop" } -- Don't stop backspace at insert
o.cmdheight = 0 -- Hide command line
o.completeopt = { "menuone", "noselect" }
o.cursorline = true -- Highlight cursor line
o.laststatus = 3 -- Global status
o.lazyredraw = true
o.number = true -- Show numbers
o.mouse = "a"
o.scrolloff = 8
o.sidescrolloff = 8
o.signcolumn = "yes" -- Always show the sign column
o.showmode = false
o.smartcase = true -- Case sensitive search
o.updatetime = 300

-- [[ Text ]]
o.expandtab = false -- Don't use spaces in tabs
o.showtabline = 2 -- Always display tabline
o.shiftwidth = 4
o.tabstop = 4
o.preserveindent = true
o.timeoutlen = 300 -- Length of time to wait for mapped sequence
o.clipboard = "unnamedplus" -- Use system clipboard

-- [[ Popup ]]
o.pumheight = 10 -- Height of popup menu
o.pumblend = 10

-- [[ Filetype ]]
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.copyindent = true
o.fillchars = { eob = " " }
o.history = 100

-- [[ Theme ]]
o.syntax = "ON"
o.termguicolors = true -- Enable 24-bit RGB Color

-- [[ Backup ]]
o.swapfile = true
o.undofile = true -- Persistent undo
o.writebackup = false

-- [[ Split ]]
o.splitbelow = true
o.splitright = true

-- [[ Shortmess ]]
o.shortmess = o.shortmess + {
	A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
	I = true, -- don't give the intro message when starting Vim |:intro|.
	W = true, -- don't give "written" or "[w]" when writing a file
	c = true, -- don't give |ins-completion-menu| messages
	m = true, -- use "[+]" instead of "[Modified]"
}

-- [[ Global ]]
g.highlighturl_enabled = true -- Highlight urls by default
g.mapleader = " "
g.icons_enabled = true
-- [[ Disable plguins ]]
g.loaded_2html_plugin = true -- disable 2html
g.loaded_getscript = true -- disable getscript
g.loaded_getscriptPlugin = true -- disable getscript
g.loaded_gzip = true -- disable gzip
g.loaded_logipat = true -- disable logipat
g.loaded_matchit = true -- disable matchit
g.loaded_netrwFileHandlers = true -- disable netrw
g.loaded_netrwPlugin = true -- disable netrw
g.loaded_netrwSettngs = true -- disable netrw
g.loaded_remote_plugins = true -- disable remote plugins
g.loaded_tar = true -- disable tar
g.loaded_tarPlugin = true -- disable tar
g.loaded_zip = true -- disable zip
g.loaded_zipPlugin = true -- disable zip
g.loaded_vimball = true -- disable vimball
g.loaded_vimballPlugin = true -- disable vimball
