local mason = require("mason")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_uninstalled = "✗",
			package_pending = "⟳",
		}
	}
})
