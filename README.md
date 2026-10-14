# omarchy-screen-zoom

macOS-style full-screen zoom for [Omarchy](https://omarchy.org) (Hyprland with Lua config).
It zooms the whole screen around the cursor, not the text in the app.

| Shortcut | Action |
|---|---|
| `SUPER + CTRL + scroll wheel` | Zoom in / out |
| `SUPER + CTRL + pinch` (touchpad) | Zoom in / out, following your fingers |
| `SUPER + CTRL + ALT + Z` | Reset zoom (Omarchy default) |

Omarchy's built-in `SUPER + CTRL + Z` (zoom in one step) keeps working.

## Install

```bash
git clone https://github.com/rallevondalle/omarchy-screen-zoom
cd omarchy-screen-zoom
./install.sh
```

This copies `zoom.lua` to `~/.config/hypr/zoom.lua` and adds `require("hypr.zoom")` to the end of
`~/.config/hypr/hyprland.lua` (a backup is made first). Uninstall with `./uninstall.sh`.

Requires Hyprland with the Lua config, as shipped with current Omarchy (tested on Hyprland 0.56.2).

## Notes

- **Why not two-finger scroll on the touchpad?** Hyprland never passes touchpad scrolling to
  scroll bindings, so on a touchpad you pinch instead. The pinch takes a moment to register,
  because libinput first has to tell a pinch apart from a scroll; start the pinch decisively.
- **Smoothness.** Two settings make the scroll wheel feel smooth:
  - a fast `zoomFactor` animation (otherwise zoom uses Omarchy's ~1 second global animation),
  - `binds:scroll_event_delay = 30` (Hyprland's default of 300 ms drops most wheel notches).
    This applies to every scroll binding, including `SUPER + scroll` to switch workspace.
- Tweak `STEP` (zoom per notch) and `MAX_ZOOM` at the top of `zoom.lua`.

## License

MIT
