chutsu's dotfiles
=================

**WARNING**: DO NOT BLINDLY USE MY CONFIGURATIONS, THEY CAN BE DANGEROUS TO
YOUR NEEDS!

This dotfile repo contains a backup of my custom configuration files. Of
particular interest to you is probably `init.sh`, this shell script essentially
creates all kinds of symlinks to make the configuration files active on the
system.

This dotfile repo contains configuration for things like `bash`, `i3`,
`arandr`, `tmux`, `vifm`, `vim`, ...


Install
=======

For the lazy:

```
curl -L https://git.io/fjBqV > setup.bash && bash setup.bash
```


Contents
========

- [vim](#vim)
- [tmux](#tmux)
- [i3](#i3)
- [screenlayouts](#screenlayouts)


vim
===

```
# Tabbing in vim

- Create new tab (in command mode): :tabnew
- Kill tab (in command mode): :q
- Tab left: Ctrl-h
- Tab right: Ctrl-l

# Splits in vim

- Split horizontally :split
- Split vertically: :vsplit
- Switch to left split: <Shift> + h
- Switch to down split: <Shift> + j
- Switch to up split: <Shift> + k
- Switch to right split: <Shift> + l

# Surround

- Add double quote surround by highlighting word: viwS"
- Change current double quote surround to single quote under cursor: cs"'
- Remove current surround under cursor: ds
```


tmux
====

IMPORTANT: When running tmux in a terminal you need to be able to send commands
to tmux. In tmux vocabulary, they call it the prefix (which is ctrl-b in our
case). This tells the terminal I want to send a command to tmux, for example,
lets say I want to create a new tmux tab (which is prefix + c), you would then
press ctrl-b + c to create a new tab.

```
# Tabbing in tmux

- Create new tab: prefix + c
- Kill tab: ctrl-d
- Next tab: prefix + n
- Previous tab: prefix + p
- Go back to previous tab: prefix + prefix

# Splits in tmux

- Split horizontally: prefix + "
- Split vertically: prefix + %
- Kill split: Ctrl-d
- Switch to split (hjkl arrow keys: vim inspired):

    switch left: prefix + h
    switch down: prefix + j
    switch up: prefix + k
    switch right: prefix + l


# Sessions in tmux

- List sessions: tmux list-sessions
- Switch session: tmux switch -t<session id>
- Kill session: tmux kill-session -t<session id>
- Kill all detached sessions: tmux kill-session -a
```
