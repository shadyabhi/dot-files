local logger = hs.logger.new('win_absolute','info')

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


-- Absolute window movements

-- 2x2 grid
hca_bind("1", function() moveWindow(hs.window.focusedWindow(), 0, 0, 0.5, 0.5) end)
hca_bind("2", function() moveWindow(hs.window.focusedWindow(), 0.5, 0, 0.5, 0.5) end)
hca_bind("3", function() moveWindow(hs.window.focusedWindow(), 0, 0.5, 0.5, 0.5) end)
hca_bind("4", function() moveWindow(hs.window.focusedWindow(), 0.5, 0.5, 0.5, 0.5) end)

-- 2x1 wide
hca_bind("5", function() moveWindow(hs.window.focusedWindow(), 0, 0, 2/3, 1) end)
hca_bind("6", function() moveWindow(hs.window.focusedWindow(), 2/3, 0, 1, 1) end)

-- Right narrow, top/down
hca_bind("7", function() moveWindow(hs.window.focusedWindow(), 2/3, 0, 1, 1/2) end)
hca_bind("8", function() moveWindow(hs.window.focusedWindow(), 2/3, 1/2, 1, 1/2) end)
