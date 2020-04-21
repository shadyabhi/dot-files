--[[
-- This file manages all window movements.
-- * Move window on the same screen
-- * Move window between screens
--]]

-- Notifications every time a window is changed (helpful for tiling window manager)
hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
	hs.alert.closeAll(0)
	hs.alert.show(window:title(), hs.alert.defaultStyle, hs.screen.mainScreen(), 0.8)
end)

-- vars for window management
hs.window.animationDuration=0
local same_screen_prefix = {"cmd", "alt"}
local move_screen_prefix = {"cmd", "alt", "ctrl"}

-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function moveWindow(win, x, y, w, h)
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w*x)
	f.y = max.y + (max.h*y)
	f.w = max.w*w
	f.h = max.h*h
	win:setFrame(f)
end

-- highlight mouse
function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition ()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end

-- Move window on same screen
hs.hotkey.bind(same_screen_prefix, "Left", function() moveWindow(hs.window.focusedWindow(), 0, 0, 0.5, 1) end)
hs.hotkey.bind(same_screen_prefix, "Right", function() moveWindow(hs.window.focusedWindow(), 0.5, 0, 0.5, 1) end)
hs.hotkey.bind(same_screen_prefix, "Up", function() moveWindow(hs.window.focusedWindow(), 0, 0, 1, 0.5) end)
hs.hotkey.bind(same_screen_prefix, "Down", function() moveWindow(hs.window.focusedWindow(), 0, 0.5, 1, 0.5) end)
-- maximize window
hs.hotkey.bind(same_screen_prefix, "f", function() hs.window.focusedWindow():maximize(0) end)

-- Move window between screens
hs.hotkey.bind(move_screen_prefix, "Right", function() hs.window.focusedWindow():moveOneScreenEast() end)
hs.hotkey.bind(move_screen_prefix, "Left", function() hs.window.focusedWindow():moveOneScreenWest() end)

-- Center mouse to currently focused screen
hs.hotkey.bind(move_screen_prefix, "m", function()
	win = hs.window.focusedWindow()
    hs.alert.show(win:title(), hs.alert.defaultStyle, hs.screen.mainScreen(), 0.5)
    hs.mouse.setAbsolutePosition(win:frame().center)
	mouseHighlight()
end)
--
-- Move mouse
hs.hotkey.bind(move_screen_prefix, 'n', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)

    -- hs.mouse.setRelativePosition(center, nextScreen)
    hs.mouse.setAbsolutePosition(center)
	hs.eventtap.leftClick(hs.mouse.getAbsolutePosition())
	mouseHighlight()
end)

hs.hotkey.bind(move_screen_prefix, 's', function()
    hs.alert.show("Moving apps....", 2)
	local laptopScreen =  hs.screen "Color LCD"
	local mainScreen = hs.screen "U32J59x"
	local verticalScreen = hs.screen "P27h"

	-- Chrome
	hs.window 'Chrome':moveToScreen(mainScreen)
	moveWindow(hs.window 'Chrome', 0,0, 0.5,1)

	-- Meeting Video on the macbook
	hs.window 'Blue':moveToScreen(laptopScreen)
	moveWindow(hs.window 'Blue', 0, 0, 0.5,1)
	hs.window 'Zoom':moveToScreen(laptopScreen)
	moveWindow(hs.window 'Zoom', 0.5,0, 0.5,1)

	-- Chats on the vertical screen
	hs.window 'Slack':moveToScreen(verticalScreen)
	moveWindow(hs.window 'Slack', 0, 0, 1, 0.5)
end)
