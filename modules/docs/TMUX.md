# Tmux

```
    ████████╗███╗   ███╗██╗   ██╗██╗  ██╗
    ╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝
       ██║   ██╔████╔██║██║   ██║ ╚███╔╝
       ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗
       ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗
       ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝
```

Terminal multiplexer with Catppuccin styling and vim-like navigation.

## Prefix Key

**Prefix: `Ctrl + A`** (not `Ctrl + B`)

All commands start with the prefix unless noted otherwise.

## Key Bindings

### Session Management

| Key          | Action              |
| ------------ | ------------------- |
| `Prefix + S` | Create new session  |
| `Prefix + s` | Session switcher    |
| `Prefix + K` | Kill session        |
| `Prefix + d` | Detach from session |
| `Prefix + (` | Previous session    |
| `Prefix + )` | Next session        |

### Window Management

| Key                 | Action               |
| ------------------- | -------------------- |
| `Prefix + c`        | New window           |
| `Prefix + ,`        | Rename window        |
| `Prefix + &`        | Kill window          |
| `Prefix + Ctrl + H` | Previous window      |
| `Prefix + Ctrl + L` | Next window          |
| `Prefix + 0-9`      | Switch to window 0-9 |
| `Prefix + <`        | Swap window left     |
| `Prefix + >`        | Swap window right    |

### Pane Management

| Key            | Action                         |
| -------------- | ------------------------------ |
| `Prefix + \|`  | Split horizontally             |
| `Prefix + \`   | Split horizontally (alternate) |
| `Prefix + -`   | Split vertically               |
| `Prefix + x`   | Kill pane                      |
| `Prefix + z`   | Toggle zoom (fullscreen pane)  |
| `Prefix + !`   | Convert pane to window         |
| `Prefix + Tab` | Quick cycle panes              |

### Pane Navigation (Vim-style)

| Key          | Action           |
| ------------ | ---------------- |
| `Prefix + h` | Focus pane left  |
| `Prefix + j` | Focus pane down  |
| `Prefix + k` | Focus pane up    |
| `Prefix + l` | Focus pane right |

### Pane Resizing

| Key          | Action       |
| ------------ | ------------ |
| `Prefix + H` | Resize left  |
| `Prefix + J` | Resize down  |
| `Prefix + K` | Resize up    |
| `Prefix + L` | Resize right |

### Copy Mode (Vim-style)

| Key              | Action              |
| ---------------- | ------------------- |
| `Prefix + Enter` | Enter copy mode     |
| `v`              | Start selection     |
| `Ctrl + V`       | Rectangle selection |
| `y`              | Copy and exit       |
| `Escape`         | Cancel              |

In copy mode:

- `h/j/k/l` - Navigate
- `/` - Search forward
- `?` - Search backward
- `n/N` - Next/previous match

### Popup Windows

| Key       | Action        |
| --------- | ------------- |
| `Alt + G` | Popup Lazygit |
| `Alt + T` | Popup Btop    |

### Misc

| Key          | Action               |
| ------------ | -------------------- |
| `Prefix + r` | Reload config        |
| `Prefix + ?` | List all keybindings |
| `Prefix + :` | Command prompt       |
| `Prefix + t` | Show clock           |

## Features

### Session Persistence

- **Continuum**: Auto-saves sessions every 15 minutes
- **Resurrect**: Restores sessions after restart
- Captures pane contents and Neovim sessions

### Vim Integration

- **vim-tmux-navigator**: Seamless navigation between tmux panes and vim splits
- Use `Ctrl + h/j/k/l` to move between vim and tmux

### Status Bar (Catppuccin)

```
┌────────────────────────────────────────────────────────────────────┐
│ [windows...]                            [directory] [session]     │
└────────────────────────────────────────────────────────────────────┘
```

- Window tabs on the left
- Current directory + session name on the right
- All styled with Catppuccin Mocha

## Common Workflows

### New Project Workflow

```bash
# Create named session
tmux new -s myproject

# Or use alias
tn myproject
```

### Split Layout

```
Prefix + |     # Split right
Prefix + -     # Split down

# Results in:
┌─────────┬─────────┐
│         │         │
│   1     │    2    │
│         ├─────────┤
│         │    3    │
└─────────┴─────────┘
```

### Quick Git

```
Alt + G    # Opens lazygit in popup
```

### Monitor System

```
Alt + T    # Opens btop in popup
```

## Shell Aliases

| Alias | Command                |
| ----- | ---------------------- |
| `t`   | `tmux`                 |
| `ta`  | `tmux attach -t`       |
| `tl`  | `tmux list-sessions`   |
| `tn`  | `tmux new -s`          |
| `tk`  | `tmux kill-session -t` |

## Tips

1. **Zoom pane**: `Prefix + z` to fullscreen a pane, press again to restore
2. **Quick switch**: `Prefix + s` for visual session picker
3. **Popup terminal**: `Alt + G` for lazygit without leaving current layout
4. **Copy anything**: `Prefix + Enter`, select with `v`, yank with `y`
5. **Rename session**: `Prefix + $`

## Session Workflow

```bash
# Start working
tmux new -s work

# Detach when done
# Prefix + d

# Come back later
tmux attach -t work

# List all sessions
tmux ls
```

## Customization

### Change Prefix

Edit `modules/tmux.nix`:

```nix
extraConfig = ''
  unbind C-b
  set -g prefix C-Space  # Use Ctrl+Space instead
  bind C-Space send-prefix
'';
```

### Add Popup Shortcuts

```nix
# Add to extraConfig
bind -n M-h display-popup -d "#{pane_current_path}" -w 80% -h 80% -E "htop"
```

### Change Status Position

```nix
# Top or bottom
set -g status-position bottom
```

## Troubleshooting

### Colors look wrong

```bash
# Check terminal supports true color
echo $TERM
# Should be tmux-256color

# Inside tmux
tmux info | grep Tc
```

### Sessions not restoring

```bash
# Manual save
Prefix + Ctrl + S

# Manual restore
Prefix + Ctrl + R

# Check resurrect files
ls ~/.tmux/resurrect/
```

### Plugins not loading

```bash
# Reload tmux config
Prefix + r

# Or kill and restart
tmux kill-server && tmux
```
