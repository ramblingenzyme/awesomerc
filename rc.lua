-- Standard awesome library
gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
wibox = require("wibox")

-- Theme handling library
beautiful = require("beautiful")

-- Notification library
naughty = require("naughty")
menubar = require("menubar")

------------------------------------------------
-- Various definitions.
THEME = "darkbow"
USERTHEME = true

AUTOSTART = {
	{ "jackdbus", "/home/legospacy/scripts/jack/jack_start.sh" },

	"xbindkeys",
	"dropboxd",
	"skype",

	--"qjackctl"
}

-- Default applications.
terminal = "sakura"
editor = os.getenv("EDITOR") or "vim"
filemanager = "thunar"
browser = "luakit"
-----------------------------------------------

-- Handle runtime errors after startup.
require('main.error_handler')

-- Load the theme defined near the top.
require('main.theme')


-- Define avaliable layouts.
layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	--awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	--awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	--awful.layout.suit.spiral,
	--awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	--awful.layout.suit.max.fullscreen,
	--awful.layout.suit.magnifier
}

-- Setup tags.
-- Tags
taglist = { -- List of tags. Will be added to each screen.
	tags = { '[main]', '[comm]', '[util]' },
	layout = {layouts[2], layouts[1], layouts[1]}
}

tags = {} -- All tags.
for s = 1, screen.count() do  tags[s] = awful.tag(taglist.tags, s, taglist.layout)  end

-- Menubar configuration.
menubar.utils.terminal = terminal -- Set the terminal for applications that require it.

-- The modifier key.
modkey = "Mod4"

-- Add the main wibox.
require('main.wibox_main')

-- Keyboard and mouse bindings.
require('main.bindings')

-- Client rules and signals.
require('main.client')

-- Autostart.
require('main.autostart')