IMPORTANT: When running tmux in a terminal you need to be able to send commands
to tmux. In tmux vocabulary, they call it the prefix (which is ctrl-b in our
case). This tells the terminal I want to send a command to tmux, for example,
lets say I want to create a new tmux tab (which is prefix + c), you would then
press ctrl-b + c to create a new tab.


## Tmux Tabs

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


## Tmux Splits

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


## Tmux Sessions

**List sessions**

    tmux list-sessions

**Switch session**

    tmux switch -t<session id>

**Kill session**

    tmux kill-session -t<session id>


**Kill all detached sessions**

    tmux kill-session -a
