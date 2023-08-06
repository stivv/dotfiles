local M = {}

function M.get_menu(awful, beautiful)
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

end

return M
