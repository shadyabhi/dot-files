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
        path = "/Users/arastogi/Applications/Edge Apps.localized/" .. name .. ".app"
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
        path = "/System/Applications/" .. name .. ".app"
        if file_exists(path) then
            hs.application.launchOrFocus(path)
            return
        end
		path = "/Users/arastogi/Applications/Chrome Apps.localized/" .. name .. ".app"
        if file_exists(path) then
            hs.application.launchOrFocus(path)
            return
        end
    end
end

-- Shortcuts
h_bind("b", launchApp("Google Chrome"))
h_bind("v", launchApp("Visual Studio Code"))
h_bind("t", launchApp("iTerm"))
h_bind("m", launchApp("Microsoft Teams"))
h_bind("w", launchApp("Obsidian"))
h_bind("s", launchApp("Slack"))
h_bind("o", launchApp("Microsoft Outlook"))
h_bind("d", launchApp("DevDocs"))
h_bind("f", launchApp("Firefox"))
h_bind("r", launchApp("Reclaim"))
h_bind("a", launchApp("Chatbox"))
