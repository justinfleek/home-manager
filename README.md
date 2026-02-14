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

### NixOS (Native — Full Desktop)

#### Prerequisites

1. NixOS with flakes enabled
2. NVIDIA GPU (optional, for AI/ML features)

#### Installation

```bash
# Clone the repo
git clone git@github.com:justinfleek/jpyxal-dots.git ~/.config/jpyxal-dots

# Build and activate
cd ~/.config/jpyxal-dots
home-manager switch --flake .#justin -b backup
```

#### Switching to Hyprland

1. Log out of current session
2. At SDDM login screen, select **Hyprland** from session dropdown (bottom-left)
3. Log in with your user credentials

---

### Windows (WSL2 — Dev Environment)

The WSL2 profile gives you the full dev toolchain (Neovim, Ghostty, shells, languages, containers, git tooling, PRISM themes) without the Wayland/desktop modules. GPU passthrough works automatically via the Windows NVIDIA driver.

#### One-Liner (Fresh Windows Box)

Open PowerShell **as Administrator** and run:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/justinfleek/jpyxal-dots/main/quickstart-windows.ps1" -OutFile quickstart.ps1
Set-ExecutionPolicy Bypass -Scope Process -Force
.\quickstart.ps1
```

This handles everything: WSL install, NixOS-WSL import, system config, cloning the dots, and building home-manager.

#### Manual Setup

If you prefer to do it step by step:

**1. Install WSL and NixOS**

```powershell
# Update WSL
wsl --update
wsl --install --no-distribution

# Download NixOS-WSL (2505.7.0+)
# https://github.com/nix-community/NixOS-WSL/releases/latest
# Download nixos.wsl from the Assets dropdown

# Import it
mkdir $env:USERPROFILE\NixOS
wsl --import NixOS $env:USERPROFILE\NixOS $env:USERPROFILE\Downloads\nixos.wsl --version 2
wsl -s NixOS
```

**2. Configure NixOS**

Launch NixOS (`wsl -d NixOS`) and edit the system config:

```bash
sudo nano /etc/nixos/configuration.nix
```

Replace the contents with:

```nix
{ config, lib, pkgs, ... }:
{
  imports = [
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.useWindowsDriver = true;

  programs.nix-ld.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.sessionVariables = {
    LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
    # Set to "1" to reserve GPU 0 for Windows workloads (e.g. ComfyUI)
    # Set to "0,1" to use both GPUs in WSL
    CUDA_VISIBLE_DEVICES = "1";
  };

  system.stateVersion = "25.05";
}
```

Rebuild:

```bash
sudo nix-channel --update
sudo nixos-rebuild switch
```

Restart WSL from PowerShell (`wsl --shutdown && wsl -d NixOS`).

**3. Clone and Build**

```bash
nix-shell -p git home-manager

git clone https://github.com/justinfleek/jpyxal-dots.git ~/.config/jpyxal-dots
cd ~/.config/jpyxal-dots

home-manager switch --flake .#nixos-wsl -b backup
```

Restart WSL one more time and you're set.

**4. Or just run the setup script**

If NixOS-WSL is already imported:

```bash
bash setup-wsl.sh
```

#### GPU Notes (WSL2)

WSL2 passes through your Windows NVIDIA driver automatically — no Linux driver install needed. After setup:

```bash
nvidia-smi          # Should show all GPUs
echo $CUDA_VISIBLE_DEVICES  # Should show "1"
```

The default config reserves GPU 0 for Windows workloads and assigns GPU 1 to WSL. To use both GPUs in WSL, set `CUDA_VISIBLE_DEVICES=0,1` either per-command or in the NixOS config.

#### WSL2 Modules

The WSL profile (`#nixos-wsl`) includes these modules:

| Included | Excluded (needs Wayland) |
| --- | --- |
| neovim, ghostty, terminals | hyprland, hyprland-extras |
| shell, tmux, nushell | waybar, eww, dunst |
| git, dev, webdev | rofi, ags, hyprpanel |
| file-managers, editors-extra | firefox, browsers |
| containers, containers-extra | launchers, gaming |
| security, api-tools | nvidia (uses Windows driver) |
| prism-themes, research | sync (no desktop tray) |
| tools | music, chat, email |

---

## Current Status

**Build**: Working (Generation 3+)
**Warnings**: 6 upstream xorg deprecations (from hyprland flake inputs, not fixable locally)

### Disabled Modules (broken upstream)

| Module | Issue |
| --- | --- |
| `spicetify` | Network fetch failure |
| `ai-local` | Package conflicts |
| `ai-coding` | Package conflicts |
| `speech` | Package conflicts |
| `comfyui` | Package conflicts |

### SSH Configuration

Pre-configured for:

* **GitHub**: `git@github.com` / `gh:` (user: justinfleek)
* **FXY Fleet**: All machines with justin@id\_ed25519

## What's Included

### Core Desktop

| Component | Description |
| --- | --- |
| **Hyprland** | Tiling Wayland compositor with animations |
| **Waybar** | Glassmorphism status bar |
| **Dunst** | Notifications |
| **Rofi** | App launcher |
| **swww** | Wallpaper daemon |
| **Hyprlock** | Lock screen |
| **Hypridle** | Idle daemon |

### Terminals & Shells

| Component | Description |
| --- | --- |
| **Ghostty** | GPU-accelerated terminal (primary) |
| **Wezterm** | Lua-configurable GPU terminal |
| **Zellij** | Modern tmux alternative |
| **Bash** | With Starship + Atuin + Zoxide |

### Editors

| Component | Description |
| --- | --- |
| **Neovim** | LazyVim IDE with full LSP |
| **Neovide** | GPU Neovim GUI with animations |
| **Helix** | Post-modern modal editor |
| **VS Code** | VSCodium with extensions |

### File Managers

| Component | Description |
| --- | --- |
| **Yazi** | Fast rust file manager |
| **LF** | Minimal Go file manager |
| **Ranger** | Classic Python file manager |

### Development

| Component | Description |
| --- | --- |
| **Languages** | Rust, Go, Python, Node, Zig, Haskell |
| **Containers** | Docker, Podman, K8s, Lazydocker, K9s |
| **Git** | Lazygit, Delta (catppuccin), gh CLI |
| **Nix** | nil LSP, nixfmt, nix-tree |

### GPU/NVIDIA

| Component | Description |
| --- | --- |
| **CUDA** | Full toolkit via cudatoolkit |
| **nvtop/nvitop** | GPU monitoring |
| **TensorRT** | Inference optimization |

### Apps

| Component | Description |
| --- | --- |
| **Firefox** | With custom search engines |
| **Obsidian** | Knowledge management |
| **Discord** | Via Vesktop |
| **Spotify** | Native client |
| **OBS Studio** | Streaming/recording |

### Productivity

| Component | Description |
| --- | --- |
| **Syncthing** | P2P file sync (with tray) |
| **Restic/Borg** | Backups |
| **pass/gopass** | Password management |

## File Structure

```
.
├── flake.nix              # Main flake with inputs
├── flake.lock             # Locked dependencies
├── home.nix               # Core home config (NixOS desktop)
├── home-wsl.nix           # WSL2 home config (dev only)
├── quickstart-windows.ps1 # One-shot Windows setup script
├── setup-wsl.sh           # NixOS-WSL setup script
├── install.sh             # Legacy install script
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

| Key | Action |
| --- | --- |
| `Super + Return` | Terminal (Ghostty) |
| `Super + Space` | App launcher (Rofi) |
| `Super + Q` | Close window |
| `Super + F` | Fullscreen |
| `Super + H/J/K/L` | Focus vim-style |
| `Super + Shift + H/J/K/L` | Move window |
| `Super + 1-9` | Workspaces |
| `Super + V` | Clipboard history |
| `Print` | Screenshot |
| `Super + Escape` | Power menu |
| `Super + L` | Lock screen |

### Shell Aliases

```
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

* **Colorscheme**: Catppuccin Mocha
* **GTK**: catppuccin-gtk
* **QT**: catppuccin-kvantum
* **Cursors**: catppuccin-cursors (mocha mauve)
* **Icons**: catppuccin-papirus-folders

## Updating

### NixOS (Desktop)

```bash
cd ~/.config/jpyxal-dots
nix flake update
home-manager switch --flake .#justin
```

### WSL2

```bash
cd ~/.config/jpyxal-dots
nix flake update
home-manager switch --flake .#nixos-wsl -b backup
```

## Troubleshooting

### Services fail on KDE

Expected - waybar, cliphist, wlsunset require Hyprland/Wayland session.

### xorg deprecation warnings

These come from upstream hyprland flake inputs, not fixable locally.

### Package conflicts

Some packages are disabled due to buildEnv conflicts. Check git history for details.

### WSL: nvidia-smi not found

Make sure `wsl.useWindowsDriver = true;` and `programs.nix-ld.enable = true;` are in your NixOS config. Restart WSL after rebuilding (`wsl --shutdown` from PowerShell).

### WSL: CUDA SSL certificate errors

Your `python.nix` or `nvidia.nix` modules try to download CUDA packages. The WSL config excludes these — GPU access comes through the Windows driver, not Nix-packaged CUDA.

### WSL: home-wsl.nix not found

Nix flakes only see git-tracked files. Run `git add home-wsl.nix` before building.

## Credits

* [vimjoyer](https://www.youtube.com/@vimjoyer) - Inspiration
* [Catppuccin](https://catppuccin.com/) - Theme
* [Hyprland](https://hyprland.org/) - Compositor
* [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) - WSL2 support

---

**j-pyxal dots** - *the kitchen sink, riced to perfection*
