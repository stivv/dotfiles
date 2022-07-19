require("settings")
require("mappings")
require("packer-config")

-- Plugins configs
require("packer-config.plugin-configs")

-- Plugins from scratch ;)
vim.o.winbar = "%{%v:lua.require('winbar').eval()%}"
vim.o.statusline = "%{%v:lua.require('statusline').eval()%}"
