#!/usr/bin/env bash
# ============================================================================
# j-pyxal dots — NixOS-WSL Setup
# Run this INSIDE NixOS-WSL after importing nixos.wsl
# Usage: bash setup-wsl.sh
# ============================================================================

set -euo pipefail

echo ""
echo "  ╔══════════════════════════════════════════════╗"
echo "  ║  j-pyxal dots — NixOS-WSL Setup             ║"
echo "  ╚══════════════════════════════════════════════╝"
echo ""

# --- Configure NixOS ---
echo "[1/6] Configuring NixOS (flakes, GPU, nix-ld)..."

sudo tee /etc/nixos/configuration.nix > /dev/null << 'NIXCONF'
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
NIXCONF

echo "    configuration.nix written"

# --- Rebuild NixOS ---
echo "[2/6] Rebuilding NixOS (this may take a minute)..."
sudo nix-channel --update
sudo nixos-rebuild switch

# --- Ensure PATH ---
echo "[3/6] Setting up environment..."
export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"

# --- Clone jpyxal-dots ---
echo "[4/6] Cloning jpyxal-dots..."
if [ -d "$HOME/.config/jpyxal-dots" ]; then
    echo "    Already cloned, pulling latest..."
    cd "$HOME/.config/jpyxal-dots"
    nix-shell -p git --run "git pull || true"
else
    nix-shell -p git --run "git clone https://github.com/justinfleek/jpyxal-dots.git $HOME/.config/jpyxal-dots"
fi

cd "$HOME/.config/jpyxal-dots"

# --- Create home-wsl.nix ---
echo "[5/6] Setting up WSL home config..."
if [ ! -f "home-wsl.nix" ]; then
    cat > home-wsl.nix << 'HOMEWSL'
{
  config,
  pkgs,
  pkgs-bun,
  lib,
  inputs,
  username,
  nix-colors,
  ...
}:

{
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "24.11";

    sessionVariables = {
      FLAKE = "$HOME/.config/jpyxal-dots";
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "ghostty";
      FZF_DEFAULT_OPTS = lib.mkForce ''
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
        --border="rounded" --border-label="" --preview-window="border-rounded"
        --prompt="> " --marker=">" --pointer=">"
        --separator="─" --scrollbar="│"
      '';
    };

    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
      "$HOME/go/bin"
    ];
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  home.packages = with pkgs; [
    coreutils findutils gnugrep gnused gawk
    ripgrep fd sd jq yq tree file which
    htop btop procs dust duf ncdu
    pkgs-bun.bun
    git gh lazygit delta difftastic
    nodejs_22 deno rustup go
    nil nixfmt
    nodePackages.typescript-language-server
    nodePackages.prettier
    lua-language-server stylua
    marksman taplo yaml-language-server
    eza bat zoxide fzf atuin
    glow silicon hyperfine tokei
    fastfetch cpufetch onefetch nitch
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.caskaydia-cove
    nerd-fonts.geist-mono
    inter lexend
    wget curl httpie aria2
    zip unzip p7zip
    pass gnupg
  ];

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      videos = "${config.home.homeDirectory}/videos";
    };
  };

  programs = {
    home-manager.enable = true;
    bat = {
      enable = true;
      config = {
        theme = "Catppuccin Mocha";
        style = "numbers,changes,header";
        italic-text = "always";
      };
    };
    eza = {
      enable = true;
      enableBashIntegration = true;
      icons = "auto";
      git = true;
      extraOptions = [ "--group-directories-first" "--header" ];
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd cd" ];
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
      changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
    };
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
        rounded_corners = true;
        graph_symbol = "braille";
        shown_boxes = "cpu mem net proc";
      };
    };
    lazygit = {
      enable = true;
      settings = {
        gui = {
          theme = {
            activeBorderColor = [ "#cba6f7" "bold" ];
            inactiveBorderColor = [ "#a6adc8" ];
            optionsTextColor = [ "#89b4fa" ];
            selectedLineBgColor = [ "#313244" ];
            cherryPickedCommitBgColor = [ "#45475a" ];
            cherryPickedCommitFgColor = [ "#cba6f7" ];
            unstagedChangesColor = [ "#f38ba8" ];
            defaultFgColor = [ "#cdd6f4" ];
            searchingActiveBorderColor = [ "#f9e2af" ];
          };
          nerdFontsVersion = "3";
          showFileTree = true;
          showRandomTip = false;
          showCommandLog = false;
        };
        git.paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
HOMEWSL
    echo "    home-wsl.nix created"
else
    echo "    home-wsl.nix already exists, skipping"
fi

# Stage for flake visibility
nix-shell -p git --run "git add home-wsl.nix 2>/dev/null || true"

# --- Build home-manager config ---
echo "[6/6] Building home-manager config (this will take a while on first run)..."
nix-shell -p home-manager --run "home-manager switch --flake .#nixos-wsl -b backup"

echo ""
echo "  ╔══════════════════════════════════════════════╗"
echo "  ║  Setup complete!                             ║"
echo "  ║                                              ║"
echo "  ║  From PowerShell, run:                       ║"
echo "  ║    wsl --shutdown                            ║"
echo "  ║    wsl -d NixOS                              ║"
echo "  ║                                              ║"
echo "  ║  nvidia-smi should show your GPUs.           ║"
echo "  ║  CUDA_VISIBLE_DEVICES=1 (GPU 1 for WSL)     ║"
echo "  ║                                              ║"
echo "  ║  Dots: ~/.config/jpyxal-dots                 ║"
echo "  ║  Update:                                     ║"
echo "  ║    cd ~/.config/jpyxal-dots                  ║"
echo "  ║    home-manager switch \                     ║"
echo "  ║      --flake .#nixos-wsl -b backup           ║"
echo "  ╚══════════════════════════════════════════════╝"
echo ""
