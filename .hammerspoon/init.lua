require "hyper"
require "launch"
require "win/absolute"
require "win/grid"
require "win/switch"

-- Enable Apple Script support
hs.allowAppleScript(true)

-- Load spoons
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.alert.show("Hammerspoon reload finished successfully!")
