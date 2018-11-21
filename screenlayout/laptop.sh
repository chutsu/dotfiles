#!/bin/sh
xrandr \
  --output DP-2 \
    --primary \
    --mode 1920x1080 \
    --pos 0x0 \
    --rotate normal \
  --output HDMI-0 --off \
  --output DP-0 --off \
  --output DP-1 --off \
  --output DP-4 --off \
  --output DP-3 --off
