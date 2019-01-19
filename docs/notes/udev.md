# Reload udev rules

  udevadm control --reload-rules && udevadm trigger

You may need udevtrigger (or rather udevadm trigger on most distributions)
instead (that, or plug the device out and back it). `--reload-rules` is
almost always useless as it happens automatically.
