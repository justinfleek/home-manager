# Rofi

```
    ██████╗  ██████╗ ███████╗██╗
    ██╔══██╗██╔═══██╗██╔════╝██║
    ██████╔╝██║   ██║█████╗  ██║
    ██╔══██╗██║   ██║██╔══╝  ██║
    ██║  ██║╚██████╔╝██║     ██║
    ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝
```

Application launcher and dmenu replacement with beautiful styling.

## Launch

| Key             | Action            |
| --------------- | ----------------- |
| `Super + Space` | Open Rofi (apps)  |
| `Super + V`     | Clipboard history |

## Modes

Switch between modes with `Ctrl + Tab` or click the mode buttons.

| Mode        | Icon | Description     |
| ----------- | ---- | --------------- |
| drun        |      | Applications    |
| run         |      | Commands        |
| filebrowser |      | File browser    |
| window      |      | Window switcher |

## Key Bindings

### Navigation

| Key                 | Action        |
| ------------------- | ------------- |
| `Up` / `Ctrl + K`   | Previous item |
| `Down` / `Ctrl + J` | Next item     |
| `Tab`               | Next mode     |
| `Shift + Tab`       | Previous mode |
| `Enter`             | Select        |
| `Escape`            | Cancel        |

### Text Input

| Key         | Action           |
| ----------- | ---------------- |
| `Backspace` | Delete character |
| `Ctrl + W`  | Delete word      |
| `Ctrl + U`  | Clear input      |
| `Ctrl + A`  | Select all       |

### Selection

| Key             | Action             |
| --------------- | ------------------ |
| `Shift + Enter` | Run custom command |
| `Ctrl + Enter`  | Run in terminal    |

## Features

### Fuzzy Matching

Type any part of the app name:

```
"fire" → Firefox
"cod"  → VS Code
"spot" → Spotify
"disc" → Discord
```

### Search Operators

| Operator | Example    | Description                 |
| -------- | ---------- | --------------------------- |
| Space    | `fire fox` | AND - both words must match |
| `!`      | `!game`    | NOT - exclude matches       |

### History

- Recently used apps appear first
- Up to 25 entries remembered
- Sorted by frequency + recency

## Custom Commands

Type any command in run mode:

```
htop           → Opens htop
echo "hello"   → Runs command
```

## Appearance

### Layout

```
┌─────────────────────────────────────┐
│  [🔍] Search...                    │
├─────────────────────────────────────┤
│  🦊 Firefox                         │
│  💻 Ghostty                         │
│  📝 Obsidian                        │
│  🎵 Spotify                         │
│  ...                                │
├─────────────────────────────────────┤
│ [ Apps] [ Run] [ Files] [ Win]   │
└─────────────────────────────────────┘
```

### Colors (Catppuccin Mocha)

| Element          | Color     |
| ---------------- | --------- |
| Background       | `#1e1e2e` |
| Input background | `#313244` |
| Selected         | `#45475a` |
| Border           | `#cba6f7` |
| Text             | `#cdd6f4` |
| Accent           | `#cba6f7` |

## Customization

### Change Width

Edit `modules/rofi.nix`:

```nix
window = {
  width = mkLiteral "800px";  # Wider
};
```

### Change Number of Rows

```nix
listview = {
  lines = 10;  # More items visible
};
```

### Add Custom Modes

```nix
extraConfig = {
  modi = "drun,run,filebrowser,window,ssh,calc";
};
```

### Custom Theme Colors

```nix
"*" = {
  accent = mkLiteral "rgb(137, 180, 250)";  # Blue instead of purple
};
```

## Scripts

### Power Menu

```bash
~/.local/bin/powermenu
```

Options:

- Lock
- Logout
- Suspend
- Reboot
- Shutdown

### Clipboard History

```bash
cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy
```

Bound to `Super + V`

## Tips

1. **Quick launch**: Start typing immediately, no need to click
2. **Keyboard only**: Never need the mouse
3. **Calculator**: Add `calc` mode for quick math
4. **Custom scripts**: Use `rofi -dmenu` in your scripts

## Troubleshooting

### Icons not showing

```bash
# Check icon theme
ls /run/current-system/sw/share/icons/

# Rebuild icon cache
gtk-update-icon-cache -f /usr/share/icons/Papirus-Dark/
```

### Slow startup

```nix
# Disable some features
extraConfig = {
  show-icons = false;  # If icons are slow
  drun-show-actions = false;
};
```

### Wrong terminal

```nix
extraConfig = {
  terminal = "ghostty";
};
```
