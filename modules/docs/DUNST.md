# Dunst

```
    ██████╗ ██╗   ██╗███╗   ██╗███████╗████████╗
    ██╔══██╗██║   ██║████╗  ██║██╔════╝╚══██╔══╝
    ██║  ██║██║   ██║██╔██╗ ██║███████╗   ██║
    ██║  ██║██║   ██║██║╚██╗██║╚════██║   ██║
    ██████╔╝╚██████╔╝██║ ╚████║███████║   ██║
    ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝
```

Lightweight notification daemon with Catppuccin styling.

## Key Bindings

| Key                 | Action                    |
| ------------------- | ------------------------- |
| `Super + N`         | Show last notification    |
| `Super + Shift + N` | Dismiss all notifications |

## Mouse Actions

| Click        | Action            |
| ------------ | ----------------- |
| Left click   | Do action + close |
| Middle click | Close all         |
| Right click  | Close current     |

## Notification Levels

### Low Priority

- Blue border (`#89b4fa`)
- Auto-dismiss: 5 seconds
- Used for: Info, completion notices

### Normal Priority

- Purple border (`#cba6f7`)
- Auto-dismiss: 10 seconds
- Used for: Standard notifications

### Critical Priority

- Red border (`#f38ba8`)
- Never auto-dismiss
- Used for: Errors, important alerts

## Features

### Layout

```
┌───────────────────────────────────────┐
│ 🔔 App Name                           │
│                                       │
│ Notification title                    │
│ Body text goes here with details      │
│                                       │
│ ▓▓▓▓▓▓▓▓░░░░░░░░ 50%    (progress)   │
└───────────────────────────────────────┘
```

Position: Top-right corner (15px offset)

### Progress Bar

For volume, brightness, and download notifications:

```
Volume: ▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░ 60%
```

### Stacking

Duplicate notifications stack:

```
┌───────────────────────────────────────┐
│ 💬 Discord                     (3)    │
│ You have 3 new messages              │
└───────────────────────────────────────┘
```

### History

- Up to 20 notifications remembered
- Access with `Super + N`
- Use `dunstctl history-pop` to show one at a time

## App-Specific Styling

| App         | Border Color     |
| ----------- | ---------------- |
| Discord     | Blue `#89b4fa`   |
| Spotify     | Green `#a6e3a1`  |
| Slack       | Yellow `#f9e2af` |
| Firefox     | Orange `#fab387` |
| Screenshots | Teal `#94e2d5`   |
| Volume      | Blue `#89b4fa`   |
| Brightness  | Yellow `#f9e2af` |

## Commands

### dunstctl

```bash
# Close current notification
dunstctl close

# Close all notifications
dunstctl close-all

# Show last notification
dunstctl history-pop

# Toggle do not disturb
dunstctl set-paused toggle

# Check if paused
dunstctl is-paused
```

### Send Test Notification

```bash
# Low priority
notify-send -u low "Low" "This is low priority"

# Normal priority
notify-send "Normal" "This is normal priority"

# Critical priority
notify-send -u critical "Critical" "This is critical!"

# With icon
notify-send -i firefox "Firefox" "Download complete"

# With progress
notify-send -h int:value:50 "Progress" "Halfway there"
```

## Notification Format

```
<b>Title</b>
Body text here
```

Supports:

- `<b>bold</b>`
- `<i>italic</i>`
- `<u>underline</u>`
- `<a href="...">link</a>`

## Configuration

### Position

Edit `modules/dunst.nix`:

```nix
global = {
  origin = "top-right";     # top-left, top-center, top-right
                            # bottom-left, bottom-center, bottom-right
  offset = "15x15";         # x, y offset from corner
};
```

### Dimensions

```nix
global = {
  width = "(300, 400)";     # min, max width
  height = 300;             # max height
  notification_limit = 5;   # max visible
};
```

### Timeouts

```nix
urgency_low = {
  timeout = 5;    # 5 seconds
};
urgency_normal = {
  timeout = 10;   # 10 seconds
};
urgency_critical = {
  timeout = 0;    # Never (0 = persistent)
};
```

### App-Specific Rules

```nix
# Add new rule
myapp = {
  appname = "myapp";
  frame_color = "#a6e3a1";
  timeout = 8;
};
```

## Do Not Disturb

Toggle with:

```bash
dunstctl set-paused toggle
```

Add to Hyprland keybind:

```nix
bind = "$mod, N, exec, dunstctl set-paused toggle"
```

## Tips

1. **Quick dismiss**: Click anywhere on notification
2. **History browse**: `Super + N` repeatedly to see older
3. **Copy text**: Middle-click copies notification body
4. **Action buttons**: Some apps add buttons (click to activate)

## Troubleshooting

### Notifications not showing

```bash
# Check if dunst is running
pgrep dunst

# Restart dunst
killall dunst && dunst &

# Check for errors
dunst -print
```

### Wrong monitor

```nix
global = {
  monitor = 0;  # Primary monitor
  follow = "mouse";  # Follow mouse cursor
};
```

### Icons not showing

```bash
# Check icon path
ls /run/current-system/sw/share/icons/

# Set in config
icon_theme = "Papirus-Dark";
```

### Sound notifications

Dunst doesn't play sounds. Use a script:

```nix
global = {
  startup_notification = false;
};

# In hyprland exec-once, run a script that listens for notifications
```

## Integration

### With Screenshots

The screenshot script sends notifications:

```bash
notify-send -a "screenshot" "Screenshot" "Saved to clipboard"
```

### With Volume

Volume changes send progress notifications:

```bash
notify-send -a "volume" -h int:value:$volume "Volume"
```
