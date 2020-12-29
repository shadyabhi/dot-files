-- require "window"

-- Start message

-- Enable Apple Script support
hs.allowAppleScript(true)

-- Load spoons
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Pradadad
local hyper = {"cmd", "alt", "ctrl"}
local hypershift = {"cmd", "alt", "ctrl", "shift"}
local hyper_cmd_alt = {"cmd", "alt"}


hs.alert.show("Hammerspoon reload finished successfully!")
