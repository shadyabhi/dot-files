require "window"
require "tiling"

-- Enable Apple Script support
hs.allowAppleScript(true)

-- Load spoons
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
