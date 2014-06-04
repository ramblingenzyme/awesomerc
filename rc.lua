-- Standard awesome library --
local awful = require("awful")
local naughty = require("naughty")
local menubar = require("menubar")

awful.rules = require("awful.rules")
require("awful.autofocus")

local beautiful = require("beautiful")
local gears = require("gears")
-- ================ --

-- Other modules --

-- ================ --


-- Various definitions --
--local THEME_PATH = string.format("%s/themes/%s/theme.lua", awful.util.getdir("config"),"darkbow")
local THEME_PATH = string.format("themes/%s/theme.lua", "darkbow")

local APPLICATIONS = {
	terminal = "sakura",
	veditor = "textadept",
	webbrowser = "firefox"
}

local LAYOUTS = {
	awful.layout.suit.floating,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.tile
}

local TAGLIST = {
	tags = { "[main]", "[aux]", "[comm]", "[gaming]" },
	layout = { layouts[2], layouts[1], layouts[1] }
}

MODKEY = "Mod4"
-- ================ --


-- Handle runtime Lua errors --
local in_error = false
awesome.connect_signal("debug::error", function (err)
	if in_error then return end -- Make sure we don't go into an endless error loop.
	in_error = true

	naughty.notify{
		preset = naughty.config.presets.critical,
		title = "A Lua error has occured.",
		text = err
	}

	in_error = false
end)
-- ================ --

-- Set theme --
beautiful.init(THEME_PATH)

-- Put the wallpaper on all screens.
if beautiful.wallpaper then
	for s = 1, screen.count() do
		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end
-- ================ --

-- Setup tags --
local tags = {}
for s = 1, screen.count() do
	tags[s] = awful.tag(TAGLIST.tags, s, TAGLIST.layout)
end
-- ================ --

-- Set the terminal for applications that require it --
menubar.utils.terminal = APPLICATIONS.terminal
-- ================ --

-- Main widget box --
require("main.wibox.main")
-- ================ --

-- Main key/mouse bindings --
root.keys( require("main.bindings.global.keys") )
-- ================ --

-- Client rules --
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			keys = require("bindings.client.keys"),
			buttons = require("bindings.client.buttons")
		}
	}
}
-- ================ --

-- Client signals --
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
		--awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- ================ --
