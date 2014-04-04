-- Rules
awful.rules.rules = {
    -- All clients will match this rule.
    {
			rule = {},
      properties = {
				border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
				focus = awful.client.focus.filter,
				keys = clientkeys,
				buttons = clientbuttons
			}
		},
		 -- Set Skype to always map on the "comm" tag of screen 1.
    {
			rule = { class = "Skype" },
			properties = { tag = tags[1][2] }
		},
		-- Steam on "gaming" tag.
		{
			rule = { class = "Steam" },
			properties = { tag = tags[1][3] }
		},

		-- Arduino IDE.
		{
			rule = { class = "processing-app-Base" },
			properties = { floating = true }
		},

		-- Fix for Wine windows floating away
		{
			rule = { class = "Wine" },
			properties = { border_width = 0, floating = true }
		},
}

-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
	-- Enable sloppy focus
	c:connect_signal("mouse::enter", function(c)
		if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c) then
			client.focus = c
		end
	end)

	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
