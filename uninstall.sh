#!/usr/bin/env bash
# Remove omarchy-screen-zoom from ~/.config/hypr.
set -euo pipefail

HYPR_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hypr"

rm -f "$HYPR_DIR/zoom.lua"
sed -i '/^-- Screen zoom (omarchy-screen-zoom)$/d; /^require("hypr.zoom")$/d' "$HYPR_DIR/hyprland.lua"

hyprctl reload >/dev/null
hyprctl keyword cursor:zoom_factor 1 >/dev/null 2>&1 || true
echo "Uninstalled."
