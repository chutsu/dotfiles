#!/bin/sh
xrandr \
  --output HDMI-0 \
  --primary --mode 1920x1080 \
  --pos 0x0 \
  --rotate normal \
  --output DP-4 --off \
  --output DP-3 --off \
  --output DP-2 \
    --mode 1920x1080 \
    --pos 0x1080 \
    --rotate normal \
  --output DP-1 --off \
  --output DP-0 --off
