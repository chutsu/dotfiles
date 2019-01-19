chutsu's dotfiles
-----------------

**WARNING**: DO NOT BLINDLY USE MY CONFIGURATIONS, THEY CAN BE DANGEROUS TO
YOUR NEEDS!

This dotfile repo contains a backup of my custom configuration files. Of
particular interest to you is probably `init.sh`, this shell script essentially
creates all kinds of symlinks to make the configuration files active on the
system.

This dotfile repo contains configuration for:

- bash
- i3
- arandr
- tmux
- vifm
- vim


Install
-------

For the lazy:

```
curl -L https://git.io/vPzOt > init.sh && sh init.sh
```


---


Contents
--------
- [vim](#vim)
    - [Tabs](#tabbing-in-vim)
    - [Surround](#surround)
- [tmux](#tmux)
    - [Tabs](#tmux-tabs)
    - [Splits](#tmux-splits)
    - [Sessions](#tmux-sessions)


---


vim
---

### Tabbing in vim

    :tabnew  Create new tab (in command mode)
    :q  Kill tab (in command mode)
    Ctrl-h Tab left
    Ctrl-l Tab right


### Surround

**Add double quote surround by highlighting word**

    viwS"

**Change current double quote surround to single quote under cursor**

    cs"'

**Remove current surround under cursor**

    ds



---



tmux
----

IMPORTANT: When running tmux in a terminal you need to be able to send commands
to tmux. In tmux vocabulary, they call it the prefix (which is ctrl-b in our
case). This tells the terminal I want to send a command to tmux, for example,
lets say I want to create a new tmux tab (which is prefix + c), you would then
press ctrl-b + c to create a new tab.


### Tabs

**Create new tab**

    prefix + c

**Kill tab**

    ctrl-d

**Next tab**

    prefix + n

**Previous tab**

    prefix + p

**previous visited tab**

    prefix + prefix



### Splits

**Split Navigation shortcuts (hjkl arrow keys: vim inspired)**

    navigate up: prefix + k
    navigate down: prefix + j
    navigate left: prefix + h
    navigate right: prefix + l

**Split horizontally**

    prefix + "


**Split vertically**

    prefix + %


**Kill split**

    Ctrl-d


### Sessions

**List sessions**

    tmux list-sessions

**Switch session**

    tmux switch -t<session id>

**Kill session**

    tmux kill-session -t<session id>


**Kill all detached sessions**

    tmux kill-session -a
