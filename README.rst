chutsu's dotfiles
=================

.. image:: https://github.com/chutsu/dotfiles/actions/workflows/ci.yml/badge.svg
  :target: https://github.com/chutsu/dotfiles/actions/workflows/ci.yml


Install
=======

.. code-block::

  sudo apt-get update
  sudo apt-get install make git -yqq
  git clone git@github.com:chutsu/dotfiles.git
  cd dotfiles && make deps && make dotfiles


Cheatsheet
==========

.. code-block::

  # Bluetooth
  bluetoothctl devices
  bluetoothctl scan on
  bluetoothctl connect
  bluetoothctl disconnect

  # Network
  nmcli device
  nmcli device wifi list
  nmcli device wifi connect <SSID> password <PASSWORD>
  nmcli device disconnect ifname <INTERFACE>
  nmcli connection show
  nmcli connection up <NAME OR UUID>
  nmcli connection delete <NAME OR UUID>
  nmcli radio wifi off

  # Screen recording
  wf-recorder -f output.mp4
  ffmpeg -i output.mp4 -vcodec libx265 -crf 28 output-compressed.mp4

  # Copy local public key to remote server for passwordless SSH
  ssh-copy-id <username>@<remote server>
