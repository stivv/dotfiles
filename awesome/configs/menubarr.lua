local M = {}

M.setup = function(awful, beautiful, gears, menubar)
	local wibox = require("wibox")
	menubar.utils.terminal = terminal -- Set the terminal for applications that require it

	awful.layout.layouts = {
		awful.layout.suit.max,
		awful.layout.suit.tile,
		awful.layout.suit.floating,
		awful.layout.suit.max.fullscreen,
	}

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

		s.mywibox = awful.wibar({
			position = "left",
			screen = s,
			width = 24,
		})

		-- Create a taglist widget
		-- Create a wibox for each screen and add it
		local taglist_buttons = gears.table.join(
			awful.button({}, 1, function(t)
				t:view_only()
			end),
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
			awful.button({}, 4, function(t)
				awful.tag.viewnext(t.screen)
			end),
			awful.button({}, 5, function(t)
				awful.tag.viewprev(t.screen)
			end)
		)

		-- Each screen has its own tag table.
		local names = { " ", " ", "", " ", "" }
		local l = awful.layout.suit
		local layouts = { l.tile, l.tile, l.max, l.tile, l.max }
		awful.tag(names, s, layouts)
		s.mytaglist = awful.widget.taglist({
			screen = s,
			filter = awful.widget.taglist.filter.all,
			buttons = taglist_buttons,
			layout = { spacing = 13, layout = wibox.layout.fixed.vertical },
		})
		--}}

		local clock = wibox.widget({
			{
				widget = wibox.widget.textbox,
				markup = " ",
				valign = "center",
				align = "center",
			},
			{
				widget = wibox.widget.textclock,
				format = "%H",
				valign = "center",
				align = "center",
			},
			{
				widget = wibox.widget.textclock,
				format = "%M",
				valign = "center",
				align = "center",
			},
			layout = wibox.layout.fixed.vertical,
		})

		local battery_perc = wibox.widget({
			{
				widget = wibox.widget.textbox,
				markup = " ",
				valign = "center",
				align = "center",
			},
			{
				widget = awful.widget.watch('bash -c "echo $(~/.config/awesome/scripts/battery_perc.sh")%', 60),
				valign = "center",
				align = "center",
			},
			layout = wibox.layout.fixed.vertical,
		})

		s.mywibox:setup({
			layout = wibox.layout.align.vertical,
			{
				layout = wibox.layout.align.vertical,
				s.mytaglist,
			},
			{
				layout = wibox.layout.align.vertical,
			},
			{
				layout = wibox.layout.fixed.vertical,
				spacing = 12,
				wibox.widget.systray(),
				clock,
				battery_perc,
			},
		})
	end)
end
return M
