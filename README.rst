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

  # CMake
  xargs rm < install_manifest.txt  # Uninstall
  cmake -DCMAKE_BULD_TYPE=Release
  cmake -DCMAKE_BULD_TYPE=Debug
  cmake -DCMAKE_BULD_TYPE=RelWithDebInfo

  # Network
  nmcli device
  nmcli device wifi list
  nmcli device wifi connect <SSID> password <PASSWORD>
  nmcli device disconnect ifname <INTERFACE>
  nmcli connection show
  nmcli connection up <NAME OR UUID>
  nmcli connection delete <NAME OR UUID>
  nmcli radio wifi off

  # Bluetooth
  sudo systemctl start bluetooth
  sudo systemctl stop bluetooth

  # Docker
  docker kill $(docker ps -q)            # Stop all docker instances
  docker rm -f $(docker ps -a -q)        # Forcefully stop all docker instances
  docker logs -f --tail 100 <container>  # Streams container logs (last 100 lines)
  docker system prune -a --volumes       # Removes all unused containers, networks, images
  docker volume prune                    # Removes all unused persistent storage volumes

  # Git
  git pull --rebase origin master
  git rebase -i ~HEAD[N]

  # Screen recording
  wf-recorder -f output.mp4
  ffmpeg -i output.mp4 -vcodec libx265 -crf 28 output-compressed.mp4

  # Copy local public key to remote server for passwordless SSH
  ssh-copy-id <username>@<remote server>
