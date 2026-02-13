# j-pyxal dots

```
       ██╗      ██████╗ ██╗   ██╗██╗  ██╗ █████╗ ██╗
       ██║      ██╔══██╗╚██╗ ██╔╝╚██╗██╔╝██╔══██╗██║
       ██║█████╗██████╔╝ ╚████╔╝  ╚███╔╝ ███████║██║
  ██   ██║╚════╝██╔═══╝   ╚██╔╝   ██╔██╗ ██╔══██║██║
  ╚█████╔╝      ██║        ██║   ██╔╝ ██╗██║  ██║███████╗
   ╚════╝       ╚═╝        ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
```

**THE KITCHEN SINK** - A fully riced NixOS Home Manager configuration with EVERYTHING.

Catppuccin Mocha + Hyprland + vim joyer vibes + AI/ML stack + the works.

## Quick Start

### Prerequisites

1. NixOS with flakes enabled
2. NVIDIA GPU (optional, for AI/ML features)

### Installation

```bash
# Clone the repo
git clone git@github.com:justinfleek/jpyxal-dots.git ~/.config/jpyxal-dots

# Build and activate
cd ~/.config/jpyxal-dots
home-manager switch --flake .#justin -b backup
```

### Switching to Hyprland

1. Log out of current session
2. At SDDM login screen, select **Hyprland** from session dropdown (bottom-left)
3. Log in with your user credentials

## Current Status

**Build**: Working (Generation 3+)
**Warnings**: 6 upstream xorg deprecations (from hyprland flake inputs, not fixable locally)

### Disabled Modules (broken upstream)

| Module      | Issue                 |
| ----------- | --------------------- |
| `spicetify` | Network fetch failure |
| `ai-local`  | Package conflicts     |
| `ai-coding` | Package conflicts     |
| `speech`    | Package conflicts     |
| `comfyui`   | Package conflicts     |

### SSH Configuration

Pre-configured for:

- **GitHub**: `git@github.com` / `gh:` (user: justinfleek)
- **FXY Fleet**: All machines with justin@id_ed25519

## What's Included

### Core Desktop

| Component    | Description                               |
| ------------ | ----------------------------------------- |
| **Hyprland** | Tiling Wayland compositor with animations |
| **Waybar**   | Glassmorphism status bar                  |
| **Dunst**    | Notifications                             |
| **Rofi**     | App launcher                              |
| **swww**     | Wallpaper daemon                          |
| **Hyprlock** | Lock screen                               |
| **Hypridle** | Idle daemon                               |

### Terminals & Shells

| Component   | Description                        |
| ----------- | ---------------------------------- |
| **Ghostty** | GPU-accelerated terminal (primary) |
| **Wezterm** | Lua-configurable GPU terminal      |
| **Zellij**  | Modern tmux alternative            |
| **Bash**    | With Starship + Atuin + Zoxide     |

### Editors

| Component   | Description                    |
| ----------- | ------------------------------ |
| **Neovim**  | LazyVim IDE with full LSP      |
| **Neovide** | GPU Neovim GUI with animations |
| **Helix**   | Post-modern modal editor       |
| **VS Code** | VSCodium with extensions       |

### File Managers

| Component  | Description                 |
| ---------- | --------------------------- |
| **Yazi**   | Fast rust file manager      |
| **LF**     | Minimal Go file manager     |
| **Ranger** | Classic Python file manager |

### Development

| Component      | Description                          |
| -------------- | ------------------------------------ |
| **Languages**  | Rust, Go, Python, Node, Zig, Haskell |
| **Containers** | Docker, Podman, K8s, Lazydocker, K9s |
| **Git**        | Lazygit, Delta (catppuccin), gh CLI  |
| **Nix**        | nil LSP, nixfmt, nix-tree            |

### GPU/NVIDIA

| Component        | Description                  |
| ---------------- | ---------------------------- |
| **CUDA**         | Full toolkit via cudatoolkit |
| **nvtop/nvitop** | GPU monitoring               |
| **TensorRT**     | Inference optimization       |

### Apps

| Component      | Description                |
| -------------- | -------------------------- |
| **Firefox**    | With custom search engines |
| **Obsidian**   | Knowledge management       |
| **Discord**    | Via Vesktop                |
| **Spotify**    | Native client              |
| **OBS Studio** | Streaming/recording        |

### Productivity

| Component       | Description               |
| --------------- | ------------------------- |
| **Syncthing**   | P2P file sync (with tray) |
| **Restic/Borg** | Backups                   |
| **pass/gopass** | Password management       |

## File Structure

```
.
├── flake.nix              # Main flake with inputs
├── flake.lock             # Locked dependencies
├── home.nix               # Core home config
└── modules/
    ├── hyprland.nix       # Window manager + hyprlock + hypridle
    ├── hyprland-extras.nix # Screenshots, brightness, etc.
    ├── waybar.nix         # Status bar
    ├── dunst.nix          # Notifications
    ├── terminals.nix      # Zellij, Wezterm
    ├── ghostty.nix        # Primary terminal
    ├── shell.nix          # Bash + Starship + Atuin
    ├── neovim.nix         # Editor (LazyVim)
    ├── git.nix            # Git + gh CLI + delta
    ├── security.nix       # SSH, GPG, hardening
    ├── nvidia.nix         # GPU tools, CUDA
    ├── firefox.nix        # Browser config
    ├── file-managers.nix  # LF, Ranger, Yazi
    ├── containers.nix     # Docker, Podman
    ├── sync.nix           # Syncthing, backups
    ├── dev.nix            # Languages, tools
    ├── webdev.nix         # Node, web tools
    └── docs/              # Module documentation
```

## Keybindings

### Hyprland

| Key                       | Action              |
| ------------------------- | ------------------- |
| `Super + Return`          | Terminal (Ghostty)  |
| `Super + Space`           | App launcher (Rofi) |
| `Super + Q`               | Close window        |
| `Super + F`               | Fullscreen          |
| `Super + H/J/K/L`         | Focus vim-style     |
| `Super + Shift + H/J/K/L` | Move window         |
| `Super + 1-9`             | Workspaces          |
| `Super + V`               | Clipboard history   |
| `Print`                   | Screenshot          |
| `Super + Escape`          | Power menu          |
| `Super + L`               | Lock screen         |

### Shell Aliases

```bash
# Navigation
lg             # Lazygit
fm             # Yazi file manager
lzd            # Lazydocker
k9             # K9s

# Nix
hms            # home-manager switch
nfu            # nix flake update

# Git
gs             # git status -sb
gl             # git log --oneline
gd             # git diff
```

## Theming

- **Colorscheme**: Catppuccin Mocha
- **GTK**: catppuccin-gtk
- **QT**: catppuccin-kvantum
- **Cursors**: catppuccin-cursors (mocha mauve)
- **Icons**: catppuccin-papirus-folders

## Updating

```bash
cd ~/.config/jpyxal-dots
nix flake update
home-manager switch --flake .#justin
```

## Troubleshooting

### Services fail on KDE

Expected - waybar, cliphist, wlsunset require Hyprland/Wayland session.

### xorg deprecation warnings

These come from upstream hyprland flake inputs, not fixable locally.

### Package conflicts

Some packages are disabled due to buildEnv conflicts. Check git history for details.

## Credits

- [vimjoyer](https://www.youtube.com/@vimjoyer) - Inspiration
- [Catppuccin](https://catppuccin.com/) - Theme
- [Hyprland](https://hyprland.org/) - Compositor

---

**j-pyxal dots** - _the kitchen sink, riced to perfection_
