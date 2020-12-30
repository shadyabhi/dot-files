require "hyper"
require "launch"
require "win_absolute"
require "win_grid"
require "switcher"

-- Enable Apple Script support
hs.allowAppleScript(true)

-- Load spoons
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.alert.show("Hammerspoon reload finished successfully!")
