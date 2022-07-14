require("settings")
require("mappings")
require("packer-config")

-- Plugins configs
require("packer-config.plugin-configs")

-- Custom stuff
vim.o.winbar = "%{%v:lua.require('utils.winbar').eval()%}"
