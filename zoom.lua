-- omarchy-screen-zoom: macOS-style full-screen zoom for Omarchy / Hyprland (Lua config)
-- https://github.com/rallevondalle/omarchy-screen-zoom
--
--   SUPER + CTRL + scroll wheel   zoom the whole screen in/out around the cursor
--   SUPER + CTRL + pinch          same, on a touchpad (two-finger pinch/spread)
--   SUPER + CTRL + ALT + Z        reset zoom (Omarchy default)

-- Multiplicative step per scroll notch, and the maximum zoom.
local STEP = 1.1
local MAX_ZOOM = 10

local function zoom_by(factor)
  return function()
    local zoom = hl.get_config("cursor.zoom_factor") or 1
    zoom = math.max(1, math.min(zoom * factor, MAX_ZOOM))
    hl.config({ cursor = { zoom_factor = zoom } })
  end
end

o.bind("SUPER + CTRL + mouse_up", "Zoom screen in", zoom_by(STEP))
o.bind("SUPER + CTRL + mouse_down", "Zoom screen out", zoom_by(1 / STEP))

-- Hyprland never sends touchpad scrolling to scroll bindings, so use a pinch gesture there.
hl.gesture({ fingers = 2, direction = "pinch", mods = "SUPER + CTRL", action = "cursorZoom", mode = "live" })

-- Zoom otherwise inherits Omarchy's global animation (~1s per step), which feels choppy.
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 1.5, bezier = "easeOutQuint" })

-- Hyprland throttles scroll bindings to one every 300ms by default, dropping most wheel notches.
-- Note: this applies to all scroll bindings (e.g. SUPER + scroll to switch workspace).
hl.config({ binds = { scroll_event_delay = 30 } })
