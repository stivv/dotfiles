vim.g.editorconfig = false

-- [[ Setting options ]]

local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.termguicolors = true
opt.background = "dark"
opt.rnu = true
opt.undofile = true
opt.swapfile = false
opt.completeopt = { "menu", "menuone", "noselect" }
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.signcolumn = "no"
opt.list = true
opt.listchars = "trail:·,tab:»·,nbsp:_"
opt.timeout = true
opt.timeoutlen = 300
opt.updatetime = 250
opt.undolevels = 10000
opt.wildmode = "longest:full,full"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.pumblend = 10     -- Popup blend
opt.pumheight = 10    -- Maximum number of entries in a popup
opt.scrolloff = 4     -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.breakindent = true
