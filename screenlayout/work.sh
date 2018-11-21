#!/bin/sh
xrandr \
  --output DP-2 \
    --mode 1920x1080 \
    --pos 0x1080 \
    --rotate normal \
  --output HDMI-0 \
    --primary \
    --mode 1920x1200 \
    --pos 1920x960 \
    --rotate normal \
  --output DP-0 --off \
  --output DP-1 --off \
  --output DP-3 --off \
  --output DP-4 --off
