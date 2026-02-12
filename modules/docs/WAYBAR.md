# Waybar

```
    ╦ ╦╔═╗╦ ╦╔╗ ╔═╗╦═╗
    ║║║╠═╣╚╦╝╠╩╗╠═╣╠╦╝
    ╚╩╝╩ ╩ ╩ ╚═╝╩ ╩╩╚═
```

Highly customizable status bar for Wayland with glassmorphism styling.

## Bar Layout

```
┌──────────────────────────────────────────────────────────────────────┐
│  [Logo] [Workspaces] [Window Title]     [Clock]     [Tray] [Status] │
└──────────────────────────────────────────────────────────────────────┘
```

## Modules

### Left Side

| Module     | Display             | Click Action     |
| ---------- | ------------------- | ---------------- |
| Logo       | NixOS icon          | Open Rofi        |
| Workspaces | 1-5 with icons      | Switch workspace |
| Window     | Active window title | -                |

### Center

| Module | Display      | Click Action     |
| ------ | ------------ | ---------------- |
| Clock  | Time (HH:MM) | Toggle date view |

### Right Side

| Module  | Display              | Click Action                   |
| ------- | -------------------- | ------------------------------ |
| Tray    | System tray icons    | -                              |
| Volume  | Speaker icon + %     | Toggle mute / Open pavucontrol |
| Network | WiFi/Ethernet status | Open network settings          |
| CPU     | CPU usage %          | Open btop                      |
| Memory  | RAM usage %          | Open btop                      |
| Battery | Battery icon + %     | -                              |
| Power   | Power icon           | Power menu                     |

## Interactions

### Volume (pulseaudio)

| Action      | Result           |
| ----------- | ---------------- |
| Left click  | Toggle mute      |
| Right click | Open pavucontrol |
| Scroll up   | Volume +2%       |
| Scroll down | Volume -2%       |

### Workspaces

| Action      | Result              |
| ----------- | ------------------- |
| Left click  | Switch to workspace |
| Scroll up   | Next workspace      |
| Scroll down | Previous workspace  |

### Clock

| Action     | Result                   |
| ---------- | ------------------------ |
| Left click | Toggle between time/date |
| Hover      | Show calendar            |

### CPU/Memory

| Action     | Result                |
| ---------- | --------------------- |
| Left click | Open btop in terminal |

## Workspace Icons

| Workspace | Icon | Intended Use |
| --------- | ---- | ------------ |
| 1         |      | Terminal     |
| 2         |      | Browser      |
| 3         |      | Code/Editor  |
| 4         |      | Files        |
| 5         |      | Media        |
| 6         |      | Gaming       |
| 7         |      | Chat         |
| 8         |      | Music        |
| 9         |      | Discord      |
| 10        |      | Misc         |

## Styling

The bar features:

- **Glassmorphism**: Translucent background with blur
- **Rounded corners**: 12px border radius
- **Gradient accents**: Purple/blue gradients
- **Hover effects**: Subtle color transitions
- **Catppuccin Mocha**: Full theme integration

## Customization

### Change Position

```nix
# In modules/waybar.nix
position = "top";  # or "bottom", "left", "right"
```

### Adjust Height

```nix
height = 40;  # pixels
```

### Change Margins

```nix
margin-top = 5;
margin-left = 10;
margin-right = 10;
```

### Add/Remove Modules

```nix
modules-left = [
  "custom/logo"
  "hyprland/workspaces"
  # Add more here
];

modules-right = [
  "tray"
  "pulseaudio"
  # Remove or reorder
];
```

### Custom Module Example

```nix
"custom/spotify" = {
  format = " {}";
  exec = "playerctl -p spotify metadata --format '{{ artist }} - {{ title }}'";
  interval = 5;
  on-click = "playerctl -p spotify play-pause";
};
```

## Color Reference (Catppuccin Mocha)

| Element    | Color    | Hex       |
| ---------- | -------- | --------- |
| Background | Base     | `#1e1e2e` |
| Surface    | Surface0 | `#313244` |
| Active     | Mauve    | `#cba6f7` |
| Text       | Text     | `#cdd6f4` |
| Subtext    | Subtext0 | `#a6adc8` |
| Red        | Red      | `#f38ba8` |
| Green      | Green    | `#a6e3a1` |
| Yellow     | Yellow   | `#f9e2af` |
| Blue       | Blue     | `#89b4fa` |

## Tips

1. **Reload waybar**: `killall waybar && waybar &`
2. **Debug mode**: `waybar -l debug`
3. **Check config**: Errors show in journal `journalctl -f`
4. **Custom CSS**: Edit the `style` section in waybar.nix

## Troubleshooting

```bash
# Restart waybar
systemctl --user restart waybar

# Check logs
journalctl --user -u waybar -f

# Test config manually
waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css
```
