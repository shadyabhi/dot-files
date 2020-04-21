-- Tiling window manager related configs

local function mouseToCenter() 
	hs.mouse.setAbsolutePosition(hs.window.focusedWindow():frame().center)
end

local tiling = require "hs.tiling"
local hotkey = require "hs.hotkey"

local mash = {"ctrl", "cmd"}

hotkey.bind(mash, "c", function() 
	mouseToCenter()
	tiling.cycleLayout() 
end)

hotkey.bind(mash, "j", function() tiling.cycle(1) end)
hotkey.bind(mash, "k", function() tiling.cycle(-1) end)
hotkey.bind(mash, "space", function() tiling.promote() end)
hotkey.bind(mash, "f", function() tiling.goToLayout("fullscreen") end)

-- If you want to set the layouts that are enabled
tiling.set('layouts', {
  'gp-vertical', 'fullscreen', 'gp-horizontal'
})


local function center(window)
  frame = window:screen():frame()
  frame.x = (frame.w / 2) - (frame.w / 4)
  frame.y = (frame.h / 2) - (frame.h / 4)
  frame.w = frame.w / 2
  frame.h = frame.h / 2
  window:setFrame(frame)
end

hotkey.bind(mash, "f", function() tiling.toggleFloat(center) end)
