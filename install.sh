#!/usr/bin/env bash
# Install omarchy-screen-zoom into ~/.config/hypr and load it from hyprland.lua.
set -euo pipefail

HYPR_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hypr"
REQUIRE_LINE='require("hypr.zoom")'

cp "$(dirname "$0")/zoom.lua" "$HYPR_DIR/zoom.lua"

if ! grep -qF "$REQUIRE_LINE" "$HYPR_DIR/hyprland.lua"; then
  cp "$HYPR_DIR/hyprland.lua" "$HYPR_DIR/hyprland.lua.bak.$(date +%s)"
  printf '\n-- Screen zoom (omarchy-screen-zoom)\n%s\n' "$REQUIRE_LINE" >> "$HYPR_DIR/hyprland.lua"
fi

hyprctl reload >/dev/null
errors="$(hyprctl configerrors)"
if [[ -n "${errors//[[:space:]]/}" ]]; then
  echo "Installed, but Hyprland reports config errors:" >&2
  echo "$errors" >&2
  exit 1
fi
echo "Installed. Try SUPER + CTRL + scroll, or SUPER + CTRL + pinch on a touchpad."
