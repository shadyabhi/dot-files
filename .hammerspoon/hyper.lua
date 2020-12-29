local hyper = {"cmd", "alt", "ctrl"}
local hypershift = {"cmd", "alt", "ctrl", "shift"}
local hyper_cmd_alt = {"cmd", "alt"}

function h_bind(key, func)
    hs.hotkey.bind(hyper, key, func)
end

function hs_bind(key, func)
    hs.hotkey.bind(hypershift, key, func)
end

function hca_bind(key, func)
    hs.hotkey.bind(hyper_cmd_alt, key, func)
end
