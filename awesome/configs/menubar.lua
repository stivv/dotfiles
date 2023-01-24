local M = {}

function M.setup(awful, beautiful, gears, menubar, wibox)

	-- Table of layouts to cover with awful.layout.inc, order matters.
	awful.layout.layouts = {
		awful.layout.suit.max,
		awful.layout.suit.tile,
		awful.layout.suit.floating,
		awful.layout.suit.max.fullscreen,
		awful.layout.suit.tile.left,
		awful.layout.suit.tile.bottom,
		awful.layout.suit.tile.top,
	}
	-- }}}

	mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
		menu = require('configs.menu').get_menu(awful, beautiful) })

	-- Menubar configuration
	menubar.utils.terminal = terminal -- Set the terminal for applications that require it
	-- }}}

	-- Keyboard map indicator and switcher
	mykeyboardlayout = awful.widget.keyboardlayout()

	-- {{{ Wibar
	-- Create a textclock widget
	mytextclock = wibox.widget.textclock()

	-- Create a wibox for each screen and add it
	local taglist_buttons = gears.table.join(
		awful.button({}, 1, function(t) t:view_only() end),
		awful.button({ modkey }, 1, function(t)
			if client.focus then
				client.focus:move_to_tag(t)
			end
		end),
		awful.button({}, 3, awful.tag.viewtoggle),
		awful.button({ modkey }, 3, function(t)
			if client.focus then
				client.focus:toggle_tag(t)
			end
		end),
		awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
		awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
	)

	local tasklist_buttons = gears.table.join(
		awful.button({}, 1, function(c)
			if c == client.focus then
				c.minimized = true
			else
				c:emit_signal(
					"request::activate",
					"tasklist",
					{ raise = true }
				)
			end
		end),
		awful.button({}, 3, function()
			awful.menu.client_list({ theme = { width = 250 } })
		end),
		awful.button({}, 4, function()
			awful.client.focus.byidx(1)
		end),
		awful.button({}, 5, function()
			awful.client.focus.byidx(-1)
		end))

	local function set_wallpaper(s)
		-- Wallpaper
		if beautiful.wallpaper then
			local wallpaper = beautiful.wallpaper
			-- If wallpaper is a function, call it with the screen
			if type(wallpaper) == "function" then
				wallpaper = wallpaper(s)
			end
			gears.wallpaper.maximized(wallpaper, s, true)
		end
	end

	-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
	screen.connect_signal("property::geometry", set_wallpaper)

	awful.screen.connect_for_each_screen(function(s)
		-- Wallpaper
		set_wallpaper(s)

		-- Each screen has its own tag table.
		local names = { ' ', ' ', ' ', ' ', '' }
		local l = awful.layout.suit
		local layouts = { l.tile, l.tile, l.max, l.tile, l.max }

		awful.tag(names, s, layouts)

		-- Create a promptbox for each screen
		s.mypromptbox = awful.widget.prompt()
		-- Create an imagebox widget which will contain an icon indicating which layout we're using.
		-- We need one layoutbox per screen.
		s.mylayoutbox = awful.widget.layoutbox(s)
		s.mylayoutbox:buttons(gears.table.join(
			awful.button({}, 1, function() awful.layout.inc(1) end),
			awful.button({}, 3, function() awful.layout.inc(-1) end),
			awful.button({}, 4, function() awful.layout.inc(1) end),
			awful.button({}, 5, function() awful.layout.inc(-1) end)))
		-- Create a taglist widget
		s.mytaglist = awful.widget.taglist {
			screen  = s,
			filter  = awful.widget.taglist.filter.all,
			buttons = taglist_buttons,
			layout  = { spacing = beautiful.xresources.apply_dpi(10), layout = wibox.layout.fixed.vertical },
		}

		-- Create a tasklist widget
		s.mytasklist = awful.widget.tasklist {
			screen  = s,
			-- filter  = awful.widget.tasklist.filter.currenttags,
			buttons = tasklist_buttons
		}

		-- Create the wibox
		s.mywibox = awful.wibar({
			position = "left",
			screen = s,
			width = 30,
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, 14)
			end,
			shape_bounding = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, 14)
			end,
		})

		-- Add widgets to the wibox
		s.mywibox:setup {
			layout = wibox.layout.align.vertical,
			{ -- Left widgets
				layout = wibox.layout.fixed.vertical,
				-- mylauncher,
				s.mytaglist,
				s.mypromptbox,
			},
			s.mytasklist, -- Middle widget
			{ -- Right widgets
				layout = wibox.layout.fixed.vertical,
				spacing = beautiful.xresources.apply_dpi(10),
				mykeyboardlayout,
				wibox.widget.systray(),
				mytextclock,
				s.mylayoutbox,
			},
		}
	end)
	-- }}}

end

return M
