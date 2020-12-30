--[[
-- This file manages all window movements.
-- * Move window on the same screen
-- * Move window between screens
--]]

local logger = hs.logger.new('grid','info')

-- Grid layout
hs.grid.setGrid('2x2')
hs.grid.setMargins('0x0')

-- Shortcuts: move windows between grids
h_bind("right", hs.grid.pushWindowRight)
h_bind("left", hs.grid.pushWindowLeft)
h_bind("down", hs.grid.pushWindowDown)
h_bind("up", hs.grid.pushWindowUp)

-- Shortcuts: resize window spanning multiple grids
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

function getWinInfo()
    local win = hs.window.focusedWindow()
	if win == nil then return nil, nil, nil, nil end

    local screen = win:screen()
    local sg = hs.grid.getGrid(screen)
    local g = hs.grid.get(win)

	return win, screen, sg, g
end


-- Shortcut: Snap the window to the closest grid
hca_bind("s", function()
	local win = hs.window.focusedWindow()
    if win == nil then return end
	hs.grid.snap(win)
end)

-- Shortcuts: Change mouse focus between multiple windows in grid
hca_bind("h", function() hs.window.focusedWindow().focusWindowWest() end)
hca_bind("l", function() hs.window.focusedWindow().focusWindowEast() end)
hca_bind("k", function() hs.window.focusedWindow().focusWindowNorth() end)
hca_bind("j", function() hs.window.focusedWindow().focusWindowSouth() end)

-- Center mouse to currently focused screen
hca_bind("m", function()
	win = hs.window.focusedWindow()
    hs.alert.show(win:title(), hs.alert.defaultStyle, hs.screen.mainScreen(), 0.5)
    hs.mouse.setAbsolutePosition(win:frame().center)
	mouseHighlight()
end)

-- Grid: change the grid size
local chooser = hs.chooser.new(function(choice)
	if not choice then return end
	hs.grid.setGrid(choice["text"])

	-- Arrange windows (most recently used comes first)
	drawGrid(hs.grid.getGrid(), hs.window.filter.defaultCurrentSpace:getWindows())
end)

function drawGrid(grid, windows)
	local n=1
	for h=0,grid.h-1 do
		for w=0,hs.grid.getGrid().w-1 do
            logger:i(w, h, n, windows[n])
			hs.grid.set(windows[n], {x=w, y=h, w=0, h=0}, windows[n]:screen())
			n = n + 1
			if n > hs.grid.getGrid().w*hs.grid.getGrid().h then return end
		end
	end
end


chooser:choices({
      {
         ["text"] = "2x1\n",
      },
      {
         ["text"] = "3x1\n",
      },
      {
         ["text"] = "2x2\n",
      },
      {
         ["text"] = "3x2\n",
      },
      {
         ["text"] = "3x3\n",
      },
      {
         ["text"] = "5x5\n",
      },
})



hca_bind("x", function()
	local windows = hs.fnutils.map(hs.window.filter.default:getWindows(), function(win)
        if win ~= hs.window.focusedWindow() then
          return {
            text = win:title(),
            subText = win:application():title(),
            image = hs.image.imageFromAppBundle(win:application():bundleID()),
            id = win:id()
          }
        end
	  end)

	  hs.logger.new('my', 'info'):i(windows)
end )

-- Grid Operations

-- Choose the grid you want to apply
hca_bind("g", function() chooser:show() end )

-- Rearrange windows in the grid
h_bind("g", function() drawGrid(hs.grid.getGrid(), hs.window.filter.defaultCurrentSpace:getWindows()) end)

-- Rearrange all windows in appropriate grid
hs_bind("g", function()
    local windows = hs.window.filter.defaultCurrentSpace:getWindows()
    local nGrid = math.ceil(math.sqrt(#windows))

    hs.alert.show("Found " .. #windows .. " windows, switching to " .. nGrid .. "x" .. nGrid .. " grid")

    hs.grid.setGrid(nGrid .. "x" .. nGrid)
    drawGrid(hs.grid.getGrid(), hs.window.filter.defaultCurrentSpace:getWindows())

end)
