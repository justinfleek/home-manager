# Ghostty

```
     ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗████████╗██╗   ██╗
    ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝╚══██╔══╝╚██╗ ██╔╝
    ██║  ███╗███████║██║   ██║███████╗   ██║      ██║    ╚████╔╝
    ██║   ██║██╔══██║██║   ██║╚════██║   ██║      ██║     ╚██╔╝
    ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║      ██║      ██║
     ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝      ╚═╝      ╚═╝
```

GPU-accelerated terminal emulator that's fast AND beautiful.

## Key Bindings

### Window Management

| Key                    | Action            |
| ---------------------- | ----------------- |
| `Ctrl + Shift + Enter` | New split (right) |
| `Ctrl + Shift + \`     | New split (down)  |
| `Ctrl + Shift + W`     | Close split/tab   |
| `Ctrl + Shift + F`     | Toggle fullscreen |

### Split Navigation

| Key                | Action            |
| ------------------ | ----------------- |
| `Ctrl + Shift + H` | Focus split left  |
| `Ctrl + Shift + J` | Focus split down  |
| `Ctrl + Shift + K` | Focus split up    |
| `Ctrl + Shift + L` | Focus split right |

### Tabs

| Key                        | Action        |
| -------------------------- | ------------- |
| `Ctrl + Shift + T`         | New tab       |
| `Ctrl + Shift + Page Up`   | Previous tab  |
| `Ctrl + Shift + Page Down` | Next tab      |
| `Ctrl + Shift + 1-5`       | Go to tab 1-5 |

### Font Size

| Key        | Action             |
| ---------- | ------------------ |
| `Ctrl + +` | Increase font size |
| `Ctrl + -` | Decrease font size |
| `Ctrl + 0` | Reset font size    |

### Clipboard

| Key                | Action                 |
| ------------------ | ---------------------- |
| `Ctrl + Shift + C` | Copy                   |
| `Ctrl + Shift + V` | Paste                  |
| Select text        | Auto-copy to clipboard |

### Scrolling

| Key                   | Action           |
| --------------------- | ---------------- |
| `Ctrl + Shift + Up`   | Scroll page up   |
| `Ctrl + Shift + Down` | Scroll page down |
| `Ctrl + Shift + Home` | Scroll to top    |
| `Ctrl + Shift + End`  | Scroll to bottom |
| Mouse scroll          | Scroll buffer    |

### Misc

| Key                | Action           |
| ------------------ | ---------------- |
| `Ctrl + Shift + R` | Reload config    |
| `Ctrl + Shift + ,` | Open config file |
| `Ctrl + Shift + I` | Toggle inspector |

## Features

### Visual

- **GPU Rendering**: Buttery smooth scrolling
- **Background Blur**: 20px blur radius
- **Transparency**: 92% opacity
- **Font Ligatures**: Enabled (calt, liga, dlig)
- **Cursor**: Blinking block

### Typography

```
Font: JetBrainsMono Nerd Font
Size: 13px
Features: Ligatures enabled

Examples:
->  =>  !=  ==  >=  <=  ::  ++  --
```

### Colors (Catppuccin Mocha)

| Element    | Color     |
| ---------- | --------- |
| Background | `#1e1e2e` |
| Foreground | `#cdd6f4` |
| Cursor     | `#f5e0dc` |
| Selection  | `#45475a` |

#### Normal Colors

| Color   | Hex       |
| ------- | --------- |
| Black   | `#45475a` |
| Red     | `#f38ba8` |
| Green   | `#a6e3a1` |
| Yellow  | `#f9e2af` |
| Blue    | `#89b4fa` |
| Magenta | `#f5c2e7` |
| Cyan    | `#94e2d5` |
| White   | `#bac2de` |

#### Bright Colors

| Color          | Hex       |
| -------------- | --------- |
| Bright Black   | `#585b70` |
| Bright Red     | `#f38ba8` |
| Bright Green   | `#a6e3a1` |
| Bright Yellow  | `#f9e2af` |
| Bright Blue    | `#89b4fa` |
| Bright Magenta | `#f5c2e7` |
| Bright Cyan    | `#94e2d5` |
| Bright White   | `#a6adc8` |

## Configuration

Config location: `~/.config/ghostty/config`

### Change Font

```
font-family = "Fira Code"
font-size = 14
```

### Adjust Opacity

```
background-opacity = 0.85  # More transparent
background-opacity = 1.0   # Fully opaque
```

### Disable Blur

```
background-blur-radius = 0
```

### Change Cursor Style

```
cursor-style = bar       # Thin bar
cursor-style = underline # Underline
cursor-style = block     # Block (default)
```

### Quick Terminal (Dropdown)

Ghostty can act as a dropdown terminal:

```
quick-terminal-position = top
quick-terminal-animation-duration = 0.15
```

Bind it in Hyprland:

```nix
bind = "$mod, grave, exec, ghostty --quick-terminal"
```

## Shell Integration

Ghostty auto-detects and integrates with your shell:

- **Cursor tracking**: Cursor changes based on shell context
- **Sudo detection**: Visual indicator for sudo
- **Title updates**: Window title shows current command/directory

## Tips

1. **Quick split**: `Ctrl+Shift+Enter` for vertical, `Ctrl+Shift+\` for horizontal
2. **Navigate splits**: Use vim-like `Ctrl+Shift+HJKL`
3. **Scrollback**: 50,000 lines by default
4. **Config reload**: `Ctrl+Shift+R` applies changes instantly
5. **Inspector**: `Ctrl+Shift+I` for debugging

## Troubleshooting

### Font not rendering correctly

```bash
# Rebuild font cache
fc-cache -fv

# Check font is installed
fc-list | grep -i "JetBrains"
```

### Blur not working

Make sure your compositor (Hyprland) supports blur:

```nix
# In hyprland config
decoration.blur.enabled = true;
```

### Colors look wrong

Check terminal reports true color:

```bash
echo $COLORTERM  # Should be "truecolor"
```

### Performance issues

```
# In ghostty config
vfr = true  # Variable frame rate (saves GPU)
```
