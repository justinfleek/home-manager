# Hyprland

```
    ╦ ╦╦ ╦╔═╗╦═╗╦  ╔═╗╔╗╔╔╦╗
    ╠═╣╚╦╝╠═╝╠╦╝║  ╠═╣║║║ ║║
    ╩ ╩ ╩ ╩  ╩╚═╩═╝╩ ╩╝╚╝═╩╝
```

A dynamic tiling Wayland compositor with buttery smooth animations.

## Key Bindings

### Core Apps

| Key              | Action                  |
| ---------------- | ----------------------- |
| `Super + Return` | Open terminal (Ghostty) |
| `Super + Space`  | App launcher (Rofi)     |
| `Super + B`      | Browser (Firefox)       |
| `Super + E`      | File manager            |
| `Super + C`      | VS Code                 |
| `Super + O`      | Obsidian                |
| `Super + D`      | Discord                 |
| `Super + M`      | Spotify                 |

### Window Management

| Key                   | Action                 |
| --------------------- | ---------------------- |
| `Super + Q`           | Close window           |
| `Super + F`           | Toggle fullscreen      |
| `Super + Shift + F`   | Toggle fake fullscreen |
| `Super + T`           | Toggle floating        |
| `Super + P`           | Toggle pseudo-tiling   |
| `Super + S`           | Toggle split direction |
| `Super + G`           | Toggle group           |
| `Super + Tab`         | Cycle group forward    |
| `Super + Shift + Tab` | Cycle group backward   |

### Focus Navigation

| Key                  | Action                  |
| -------------------- | ----------------------- |
| `Super + H`          | Focus left              |
| `Super + J`          | Focus down              |
| `Super + K`          | Focus up                |
| `Super + L`          | Focus right             |
| `Super + Arrow Keys` | Focus (arrow direction) |

### Move Windows

| Key                          | Action                        |
| ---------------------------- | ----------------------------- |
| `Super + Shift + H`          | Move window left              |
| `Super + Shift + J`          | Move window down              |
| `Super + Shift + K`          | Move window up                |
| `Super + Shift + L`          | Move window right             |
| `Super + Shift + Arrow Keys` | Move window (arrow direction) |

### Resize Windows

| Key                | Action            |
| ------------------ | ----------------- |
| `Super + Ctrl + H` | Resize left       |
| `Super + Ctrl + J` | Resize down       |
| `Super + Ctrl + K` | Resize up         |
| `Super + Ctrl + L` | Resize right      |
| `Super + R`        | Enter resize mode |

#### Resize Mode

| Key                 | Action           |
| ------------------- | ---------------- |
| `H`                 | Shrink width     |
| `L`                 | Grow width       |
| `K`                 | Shrink height    |
| `J`                 | Grow height      |
| `Escape` / `Return` | Exit resize mode |

### Workspaces

| Key                      | Action                        |
| ------------------------ | ----------------------------- |
| `Super + 1-9, 0`         | Switch to workspace 1-10      |
| `Super + Shift + 1-9, 0` | Move window to workspace 1-10 |
| `Super + Alt + 1-5`      | Silent move (don't follow)    |
| `Super + [`              | Previous workspace            |
| `Super + ]`              | Next workspace                |
| `Super + Mouse Scroll`   | Scroll through workspaces     |
| `Super + Grave (`)`      | Toggle scratchpad             |
| `Super + Shift + Grave`  | Move to scratchpad            |

### Mouse Bindings

| Key                   | Action               |
| --------------------- | -------------------- |
| `Super + Left Click`  | Move window (drag)   |
| `Super + Right Click` | Resize window (drag) |

### Screenshots

| Key             | Action                   |
| --------------- | ------------------------ |
| `Print`         | Screenshot area (select) |
| `Shift + Print` | Screenshot fullscreen    |
| `Alt + Print`   | Screenshot active window |

### Utilities

| Key                      | Action                    |
| ------------------------ | ------------------------- |
| `Super + V`              | Clipboard history         |
| `Super + Shift + C`      | Color picker              |
| `Super + W`              | Random wallpaper          |
| `Super + N`              | Show last notification    |
| `Super + Shift + N`      | Dismiss all notifications |
| `Super + Shift + Escape` | Lock screen               |
| `Super + Escape`         | Power menu                |

### Media Keys

| Key               | Action                 |
| ----------------- | ---------------------- |
| `Volume Up`       | Increase volume 5%     |
| `Volume Down`     | Decrease volume 5%     |
| `Volume Mute`     | Toggle mute            |
| `Mic Mute`        | Toggle mic mute        |
| `Brightness Up`   | Increase brightness 5% |
| `Brightness Down` | Decrease brightness 5% |
| `Play/Pause`      | Toggle media playback  |
| `Previous`        | Previous track         |
| `Next`            | Next track             |

## Window Rules

Pre-configured rules for common apps:

- **Floating**: pavucontrol, blueman, file dialogs, imv, mpv
- **Picture-in-Picture**: Auto-pinned, sized 640x360, bottom-right
- **Discord**: Auto-opens on workspace 9
- **Spotify**: Auto-opens on workspace 8
- **Terminals**: 95% opacity with blur

## Hyprlock (Lock Screen)

Gorgeous lock screen with:

- Blurred screenshot background
- Time display (large)
- Date display
- Password input with rounded corners
- Catppuccin Mocha colors

## Hypridle (Auto-lock)

| Timeout | Action            |
| ------- | ----------------- |
| 2.5 min | Dim screen to 10% |
| 5 min   | Lock screen       |
| 5.5 min | Turn off display  |
| 30 min  | Suspend system    |

## Gestures (Touchpad)

| Gesture                   | Action                |
| ------------------------- | --------------------- |
| 3-finger swipe left/right | Switch workspace      |
| 3-finger swipe up/down    | Overview (if enabled) |

## Customization

### Monitor Setup

Edit `modules/hyprland.nix`:

```nix
monitor = [
  "DP-1,2560x1440@144,0x0,1"      # Primary
  "HDMI-A-1,1920x1080@60,2560x0,1" # Secondary
];
```

Find your monitor names:

```bash
hyprctl monitors
```

### Animation Speed

Adjust bezier curves in settings:

```nix
bezier = [
  "wind, 0.05, 0.9, 0.1, 1.05"  # Smooth
  "snap, 0.2, 1, 0.3, 1"         # Snappy
];
```

### Gaps & Borders

```nix
general = {
  gaps_in = 5;      # Gap between windows
  gaps_out = 10;    # Gap to screen edge
  border_size = 2;  # Border thickness
};
```

### Blur Settings

```nix
blur = {
  enabled = true;
  size = 8;
  passes = 3;
  noise = 0.02;
};
```

## Tips

1. **Quick window move**: Hold `Super` + drag with left mouse
2. **Quick resize**: Hold `Super` + drag with right mouse
3. **Cycle windows**: `Alt + Tab` behavior with `Super + Tab` in groups
4. **Scratchpad**: `Super + Grave` for a hidden workspace
5. **Check binds**: `hyprctl binds` to see all keybindings

## Troubleshooting

```bash
# View logs
cat ~/.local/share/hyprland/hyprland.log

# Reload config
hyprctl reload

# Check current config
hyprctl getoption general:gaps_in

# List all windows
hyprctl clients
```
