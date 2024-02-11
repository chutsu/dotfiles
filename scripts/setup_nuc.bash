#!/bin/bash
set -e

PREFIX=$HOME/projects

setup_env() {
  mkdir -p $PREFIX
  sudo apt-get install -qy git

  if [ ! -d "$PREFIX/dotfiles" ]; then
    cd $PREFIX
    git clone https://github.com/chutsu/dotfiles
  fi

  cd $PREFIX/dotfiles
  make deps
  make dotfiles
  sudo usermod -aG dialout $USER
}

install_librealsense() {
  if [ ! -d "$PREFIX/librealsense" ]; then
    cd $PREFIX
    git clone https://github.com/IntelRealSense/librealsense
  fi

  sudo apt-get install -qy libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev cmake
  sudo apt-get install -qy libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at  # Ubuntu 22.04
  sudo apt-get install -qy g++  # Ubuntu 22.04

  cd $PREFIX/librealsense
  sudo ./scripts/setup_udev_rules.sh

  mkdir -p build
  cd build
  cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_EXAMPLES=true \
    -DFORCE_RSUSB_BACKEND=true \
    ..
  make -j4
  cd -
}

install_yac() {
  if [ ! -d "$PREFIX/yac" ]; then
    cd $PREFIX
    git clone https://github.com/chutsu/yac
  fi

  cd $PREFIX/yac
  make deps
  make lib
  sudo make install
  cd -
}

install_proto() {
  if [ ! -d "$PREFIX/proto" ]; then
    cd $PREFIX
    git clone https://github.com/chutsu/proto
  fi

  cd $PREFIX/proto
  make third_party
  make build
  sudo make install
  cd -
}

install_okvis2() {
  if [ ! -d "$PREFIX/okvis2" ]; then
    cd $PREFIX
    git clone git@bitbucket.org:smartroboticslab/okvis2.git
  fi

  cd $PREFIX/okvis2
  git checkout feature/ros2
  git submodule update --init --recursive
  cd -
}

install_proto_ros2() {
  if [ ! -d "$PREFIX/proto_ros2" ]; then
    cd $PREFIX
    git clone https://github.com/chutsu/proto_ros2
  fi

  sudo apt install -qy software-properties-common
  sudo add-apt-repository -y universe
  sudo apt update && sudo apt install curl -y
  sudo curl -sSL \
    https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    -o /usr/share/keyrings/ros-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
  sudo apt update
  sudo apt install -qy ros-humble-desktop python3-argcomplete
  sudo apt install -qy ros-dev-tools
  source /opt/ros/humble/setup.bash

  mkdir -p $HOME/colcon_ws/src
  cd $HOME/colcon_ws/src
  ln -sf $PREFIX/proto_ros2 .
}

# setup_env
# install_librealsense
# install_yac
# install_proto
# install_okvis2
# install_proto_ros2
