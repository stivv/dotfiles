local M = {}

function M.setup(awful, beautiful, gears, modkey)
	-- {{{ Rules
	-- Rules to apply to new clients (through the "manage" signal).
	awful.rules.rules = {
		-- All clients will match this rule.
		{
			rule = {},
			properties = {
				border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
				focus = awful.client.focus.filter,
				raise = true,
				keys = require("configs.keybinds").clientkeys(awful, gears, modkey),
				buttons = require("configs.keybinds").clientbuttons(awful, gears, modkey),
				screen = awful.screen.preferred,
				placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			},
		},
	}

	-- {{{ Signals
	-- Signal function to execute when a new client appears.
	client.connect_signal("manage", function(c)
		if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
			-- Prevent clients from being unreachable after screen count changes.
			awful.placement.no_offscreen(c)
		end
	end)
end

return M
