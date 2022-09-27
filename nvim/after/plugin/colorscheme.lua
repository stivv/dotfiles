local one_ok, onedark = pcall(require, 'onedark')
if not one_ok then return end

onedark.setup {
	style = 'deep'
}
onedark.load()


vim.cmd [[colorscheme onedark]]


local cb_ok, colorbuddy = pcall(require, 'colorbuddy')
if not cb_ok then return end

local Color, colors, Group, groups, styles = colorbuddy.setup()

Color.new('background', '#1a212e') -- onedark: '#1a212e', catppuccin: '#282c34'
Color.new('red', '#f65866') -- onedark: '#f65866', catppuccin: '#f38ba8'
Color.new('green', '#8bcd5b') -- onedark: '#8bcd5b', catppuccin: '#a6e3a1'
Color.new('yellow', '#efbd5d') -- onedark: '#efbd5d', catppuccin:'#f9e2af'
Color.new('black', '#0c0e15') -- onedark: '#0c0e15', catppuccin: '#000000'
Color.new('base1', '#283347') -- onedark: '#283347', catppuccin: '#45475a'
Color.new('base03', '#2a324a') -- onedark: '#2a324a', catppuccin:'#313244'

Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
Group.new('Visual', colors.none, colors.base03, styles.reverse)

local cError = groups.Error.fg
local cInfo = groups.Information.fg
local cWarn = groups.Warning.fg
local cHint = groups.Hint.fg

Group.new('DiagnosticUnderlineError', colors.none, colors.none, styles.undercurl, cError)
Group.new('DiagnosticUnderlineWarn', colors.none, colors.none, styles.undercurl, cWarn)
Group.new('DiagnosticUnderlineInfo', colors.none, colors.none, styles.undercurl, cInfo)
Group.new('DiagnosticUnderlineHint', colors.none, colors.none, styles.undercurl, cHint)

-- helper function
local function update_hl(group, tbl)
	local old_hl = vim.api.nvim_get_hl_by_name(group, true)
	local new_hl = vim.tbl_extend('force', old_hl, tbl)
	vim.api.nvim_set_hl(0, group, new_hl)
end

update_hl('TSKeyword', { italic = true })
update_hl('TSConditional', { italic = true })
update_hl('TSUnderline', { italic = true })
update_hl('TSNamespace', { italic = true })
update_hl('TSKeywordFunction', { italic = true })

-- Group.new('DiagnosticVirtualTextError', cError, cError:dark():dark():dark():dark(), styles.NONE)
-- Group.new('DiagnosticVirtualTextInfo', cInfo, cInfo:dark():dark():dark(), styles.NONE)
-- Group.new('DiagnosticVirtualTextWarn', cWarn, cWarn:dark():dark():dark(), styles.NONE)
-- Group.new('DiagnosticVirtualTextHint', cHint, cHint:dark():dark():dark(), styles.NONE)


-- local ok, catppuccin = pcall(require, 'catppuccin')
-- if not ok then return end
--
-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
-- catppuccin.setup {
-- 	styles = {
-- 		comments = { "italic" },
-- 		conditionals = { "italic" }
-- 	}
-- }
