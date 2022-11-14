local plugin_loader = require("core.plugin-loader")
local plugins = require("core.plugins")

plugin_loader.initialize()
plugin_loader.load(plugins)
