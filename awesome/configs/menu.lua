local M = {}

function M.get_menu(awful, beautiful)
	-- Load Debian menu entries
	local debian = require("debian.menu")
	local has_fdo, freedesktop = pcall(require, "freedesktop")
	local hotkeys_popup = require("awful.hotkeys_popup")

	-- {{{ Menu
	-- Create a launcher widget and a main menu
	myawesomemenu = {
		{
			"hotkeys",
			function()
				hotkeys_popup.show_help(nil, awful.screen.focused())
			end,
		},
		{ "manual", terminal .. " -e man awesome" },
		{ "edit config", editor_cmd .. " " .. awesome.conffile },
		{ "restart", awesome.restart },
		{
			"quit",
			function()
				awesome.quit()
			end,
		},
	}

	local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
	local menu_terminal = { "open terminal", terminal }

	if has_fdo then
		mymainmenu = freedesktop.menu.build({
			before = { menu_awesome },
			after = { menu_terminal },
		})
	else
		mymainmenu = awful.menu({
			items = {
				menu_awesome,
				{ "Debian", debian.menu.Debian_menu.Debian },
				menu_terminal,
			},
		})
	end

	return mymainmenu
end

return M
