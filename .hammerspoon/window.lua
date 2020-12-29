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

-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function moveWindow(win, x, y, w, h)
	return function()
		local f = win:frame()
		local screen = win:screen()
		local max = screen:frame()

		f.x = max.x + (max.w*x)
		f.y = max.y + (max.h*y)
		f.w = max.w*w
		f.h = max.h*h
		win:setFrame(f)
    end
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


hca_bind("1", moveWindow(hs.window.focusedWindow(), 0, 0, 0.5, 0.5))
hca_bind("2", moveWindow(hs.window.focusedWindow(), 0.5, 0, 0.5, 0.5))
hca_bind("3", moveWindow(hs.window.focusedWindow(), 0, 0.5, 0.5, 0.5))
hca_bind("4", moveWindow(hs.window.focusedWindow(), 0.5, 0.5, 0.5, 0.5))

-- Grid layout
hs.grid.setGrid('2x2')
hs.grid.setMargins('0x0')

h_bind("right", hs.grid.pushWindowRight)
h_bind("left", hs.grid.pushWindowLeft)
h_bind("down", hs.grid.pushWindowDown)
h_bind("up", hs.grid.pushWindowUp)


hca_bind("up", function()
	win, screen, sg, g = getWinInfo()
	if win == nil then return end

    if g.y + g.h >= sg.h and g.y ~= 0 then
        g.y = g.y - 1
        g.h = g.h + 1
        hs.grid.set(win, g)
    else
        g.h = g.h - 1
        hs.grid.set(win, g)
    end
end)


hca_bind("down", function()
	win, screen, sg, g = getWinInfo()
	if win == nil then return end

    if g.y + g.h == sg.h then
        g.y = g.y + 1
        g.h = g.h - 1
        hs.grid.set(win, g)
    else
        g.h = g.h + 1
        hs.grid.set(win, g)
    end
end)


hca_bind("right", function()
	win, screen, sg, g = getWinInfo()
	if win == nil then return end

    if g.x + g.w == sg.w then
        g.x = g.x + 1
        g.w = g.w - 1
        hs.grid.set(win, g)
    else
        g.w = g.w + 1
        hs.grid.set(win, g)
    end
end)

hca_bind("left", function()
	win, screen, sg, g = getWinInfo()
	if win == nil then return end

    if g.x + g.w >= sg.w and g.x ~= 0 then
        g.x = g.x - 1
        g.w = g.w + 1
        hs.grid.set(win, g)
    else
        g.w = g.w - 1
        hs.grid.set(win, g)
    end
end)

hca_bind("s", function()
	local win = hs.window.focusedWindow()
    if win == nil then return end
	hs.grid.snap(win)
end)

hca_bind("i", function()
	local win = hs.window.focusedWindow()
	if win == nil then return end
	hs.alert.show(win)
end)

function getWinInfo()
    local win = hs.window.focusedWindow()
	if win == nil then return nil, nil, nil, nil end

    local screen = win:screen()
    local sg = hs.grid.getGrid(screen)
    local g = hs.grid.get(win)

	return win, screen, sg, g
end
