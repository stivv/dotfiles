-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- {{{ Variable definitions
-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"

-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/configs/theme.lua")

-- Error handling
require("configs.errors")

-- menubar
local menubar = require("menubar")
require("configs.menubarr").setup(awful, beautiful, gears, menubar)

-- keybinds
require("configs.keybinds").setup(awful, beautiful, gears, menubar, modkey)

-- Rules
require("configs.rules").setup(awful, beautiful, gears, modkey)

-- focus
require("configs.sloppyfocus").setup(beautiful)
