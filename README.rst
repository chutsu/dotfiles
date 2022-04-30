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
  cd dotfiles && bash setup.bash full

Keybinds
========

.. code-block::

  # tmux
  Ctrl-b + h  # Select pane left
  Ctrl-b + j  # Select pane down
  Ctrl-b + k  # Select pane up
  Ctrl-b + l  # Select pane right
  Ctrl-b + b  # Select last window
  Ctrl-b + r  # Reload tmux config

  # vifm
  Space  # Enable preview mode
  'h     # Go to $HOME
  'p     # Go $HOME/projects
  'd     # Go $HOME/Downloads
