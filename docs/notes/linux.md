- Burn .iso to USB
- Visualize disk usage


## Burn .iso to USB

1. Find device path via dmesg (e.g. `/dev/sda1`)
2. sudo umount `/dev/sda1`
3. sudo dd bs=4M if=<path to iso> of=<path to device>


## Visualize disk usage

`ncdu` which stands for NCurses Disk Usage, is built on the ncurses
library which allows for graphical interfaces within the terminal.

  <Enter>: enter into directory
  h: go up one directory
  j: move cursor down
  k: move cursor up
