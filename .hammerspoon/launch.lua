--[[
    Creates shortcuts related to launching apps via shortcuts
]]

-- Helper functions
function file_exists(path)
    local f=io.open(path,"r")
    if f~=nil then io.close(f) return true else return false end
    -- ~= is != in other languages
end

function launchApp(name)
    -- .. is concat string operator
    return function()
        path = "/Applications/" .. name .. ".app"
        if file_exists(path) then
            hs.application.launchOrFocus(path)
            return
        end
        path = "/System/Library/CoreServices/" .. name .. ".app"
        if file_exists(path) then
            hs.application.launchOrFocus(path)
            return
        end
        path = "/System/Applications/" .. name .. ".app"
        if file_exists(path) then
            hs.application.launchOrFocus(path)
            return
        end
    end
end

-- Shortcuts
h_bind("c", launchApp("Google Chrome"))
h_bind("v", launchApp("Visual Studio Code"))
h_bind("t", launchApp("iTerm"))
h_bind("w", launchApp("Typora"))
h_bind("s", launchApp("Slack"))
