

##### Tmux Hierarchy
-This is how your Tmux will organize all of your work

```
> tmux
  > sessions
    > windows
      > panes
```


### Working with Tmux Sessions
-The "Session" will be hosting your "windows"

- List tmux sessions currently running
```
tmux ls
```

```
tmux list-sessions
```

- Create a new "named" session
```
tmux new -s <session-name>
```

>>NOTE
>**`prefix` = `ctrl + b`**

- Detach from a session, and leave it running in the back
- This will also keep all your windows running as well
```
<prefix> d
```

- Attach to a session by using `-t` and the name of that session
```
tmux attach -t <session-name>
-
tmux attach-session -t <session-name>
```

- Kill a specific session by calling its name
```
tmux kill-session -t <session-name>
```


### Opening windows

##### Multiple windows (like "tabs") within a single session

- Create a new window, in the same parent
```
<prefix> c
```

- Close the current window, and stay at the last tmux window
	- If all windows are closed, tmux will terminate the whole session
```
exit
```

- Switch between windows `p` previous `n` next
- You also use the index of the window to go a specific window 
```
<prefix> p
<prefix> n
```

```
<prefix> 2
<prefix> 5
```

- Close only the single current Pane inside a Window (in case you have more than 1 in your working window)
```
<prefix> x
```

- List all your working windows that are "within" your Session, so that you can switch to any one
```
<prefix> w
```

- Rename your current window
```
<prefix> (comma)
```


### Panes

- Create a new pane in the same window downwards (horizontally)
```
<prefix> "
```

- Create a new pane in the same window, to the side (vertically)
```
<prefix> %
```

- Move inside all the panes open in the same window
```
<prefix> <arrow-keys>
```

- Cycle between panes, which can also move panes around
```
<prefix> o
```

- Close the current pane
```
<prefix> x
--
exit
```


#### Rearranging panes

- Rearrange panes in a sideways manner
```
<prefix> { / }
```

- Rearrange all panes together, but equally
```
<prefix> space-bar
```


### Commands / command-mode
-Tmux has a "command running system" just like Vim

- Open the command prompt for tmux (so, only within tmux)
```
<prefix> :
```

- List all your available commands from the command prompt
```
list-commands
```

- List all the keybindings available within tmux, from the command prompt
```
list-keys
```
