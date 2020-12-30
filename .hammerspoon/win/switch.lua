local logger = hs.logger.new('grid','info')

-- Constants
local textStyle = {
  font = {
    name = hs.styledtext.defaultFonts.boldSystem,
    size = 80,
  },
  color = {white = 1, alpha = 1},
}
local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

-- Global state
local targets = {}

-- Binding entry point
local binding = hs.hotkey.modal.new({"alt"}, "tab")
local bindingSwap = hs.hotkey.modal.new({"alt", "shift"}, "tab")

local spaceWatcher = hs.spaces.watcher.new(function()
  binding:exit()
  spaceWatcher:stop()
end)

-- Alternative exit points
binding:bind({}, "escape", nil, function() binding:exit() end)
bindingSwap:bind({}, "escape", nil, function() bindingSwap:exit() end)

binding:bind({"alt"}, "tab", nil, function() binding:exit() end)
bindingSwap:bind({"alt", "shift"}, "tab", nil, function() bindingSwap:exit() end)


function clearTargetBox(target)
    target.box:setFillColor({white = 0.125, alpha = 0.8})
    target.box:hide(0.3)
    hs.timer.doAfter(0.3, function() target.box:delete() end)
    target.text:hide(0.3)
    hs.timer.doAfter(0.3, function() target.text:delete() end)
    target.app:hide(0.3)
    hs.timer.doAfter(0.3, function() target.app:delete() end)
end

-- Making a selection
for i in alphabet:gmatch(".") do
  local letter = i

  binding:bind({}, letter, nil, function()
    local target = targets[letter]

    if target ~= nil then
      target.window:focus()
      target.window:focus()
      local frame = target.window:frame()
      hs.mouse.setAbsolutePosition(hs.geometry.point(
        frame.x + frame.w / 2,
        frame.y + frame.h / 2))

      clearTargetBox(target)
      targets[letter] = nil
      binding:exit()
    end
  end)

  bindingSwap:bind({}, letter, nil, function()
    local last = hs.window.filter.defaultCurrentSpace:getWindows()[1]
    local target = targets[letter]


    if target ~= nil then
      -- swap frames b/w windows
      lastFrame = last:frame()
      targetFrame = target.window:frame()

      target.window:setFrame(lastFrame)
      last:setFrame(targetFrame)

      -- Focus and mouse
      target.window:focus()
      target.window:focus()
      local frame = target.window:frame()

      hs.mouse.setAbsolutePosition(hs.geometry.point(
        frame.x + frame.w / 2,
        frame.y + frame.h / 2))

      clearTargetBox(target)

      targets[letter] = nil
      bindingSwap:exit()
    end
  end)
end


function buildTargets()
  targets = {}
  spaceWatcher:start()

  -- Get list of windows
  local filteredWindows = {}
  local windows = hs.window.orderedWindows()
  for i, window in ipairs(windows) do
    if window:isStandard() and window:isVisible() or
       window:id() == window:application():mainWindow():id() then
      filteredWindows[#filteredWindows + 1] = window
    end
  end
  table.sort(filteredWindows, function(a, b)
    af = a:frame()
    bf = b:frame()

    if af.x ~= bf.x then return af.x < bf.x end
    if af.y ~= bf.y then return af.y < bf.y end
    return nil
  end)

  -- Parse, render, and bind shortcuts
  for i, window in ipairs(filteredWindows) do
    local t = {window = window}

    -- Convert window's application initial to a shortcut
    local appName = window:application():title():sub(1, 1):upper()
    if not alphabet:find(appName) then
      appName = "A"
    end
    local tries = 0
    while targets[appName] ~= nil do
      local i = (alphabet:find(appName) % #alphabet) + 1
      appName = alphabet:sub(i, i)
      tries = tries + 1
      if tries == 26 then return end -- we've run out of shortcuts
    end

    -- Render shortcut
    local styledText = hs.styledtext.new(appName, textStyle)
    local textDims = hs.drawing.getTextDrawingSize(styledText)
    local frame = window:frame()
    local textRect = hs.geometry.rect(
      frame.x + frame.w / 2 - textDims.w / 2 - 2,
      frame.y + frame.h / 2 - textDims.h / 2 - 16,
      textDims.w + 8,
      textDims.h)
    local boxRect = hs.geometry.rect(
      frame.x + frame.w / 2 - textDims.w / 2 - 26,
      frame.y + frame.h / 2 - textDims.h / 2 - 24,
      textDims.w + 52,
      textDims.h + 48)
    local appRect = hs.geometry.rect(
      frame.x + frame.w / 2 - 16,
      frame.y + frame.h / 2 + 20,
      32,
      32)
    t.box = hs.drawing.rectangle(boxRect)
    t.box:setLevel("overlay")
    t.box:setFillColor({white = 0.125, alpha = 0.7})
    t.box:setFill(true)
    t.box:setStroke(false)
    t.box:setRoundedRectRadii(8, 8)
    t.text = hs.drawing.text(textRect, styledText)
    t.text:setLevel("overlay")
    t.app = hs.drawing.appImage(appRect, window:application():bundleID())
    t.box:show()
    t.text:show()
    t.app:show()

    -- Add to targets
    targets[appName] = t
  end

  return targets
end


-- Binding exit
function clearTargets()
  for k in pairs(targets) do
    targets[k].box:delete()
    targets[k].text:delete()
    targets[k].app:delete()
  end
  targets = {}
end


-- Binding enter/exit
binding.entered = buildTargets
binding.exited = clearTargets

bindingSwap.entered = buildTargets
bindingSwap.exited = clearTargets
