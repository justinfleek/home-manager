# ============================================================================
# j-pyxal dots — Windows Quickstart
# Sets up NixOS-WSL + jpyxal-dots on a fresh Windows box
# Run as Administrator in PowerShell
# ============================================================================

$ErrorActionPreference = "Stop"

Write-Host @"

       ██╗      ██████╗ ██╗   ██╗██╗  ██╗ █████╗ ██╗
       ██║      ██╔══██╗╚██╗ ██╔╝╚██╗██╔╝██╔══██╗██║
       ██║█████╗██████╔╝ ╚████╔╝  ╚███╔╝ ███████║██║
  ██   ██║╚════╝██╔═══╝   ╚██╔╝   ██╔██╗ ██╔══██║██║
  ╚█████╔╝      ██║        ██║   ██╔╝ ██╗██║  ██║███████╗
   ╚════╝       ╚═╝        ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

  Windows Quickstart — NixOS-WSL Edition

"@ -ForegroundColor Magenta

# --- Step 1: Ensure WSL is installed and up to date ---
Write-Host "[1/5] Updating WSL..." -ForegroundColor Cyan
wsl --update
wsl --install --no-distribution

# --- Step 2: Download NixOS-WSL ---
$nixosWslUrl = "https://github.com/nix-community/NixOS-WSL/releases/download/2505.7.0/nixos.wsl"
$downloadPath = "$env:USERPROFILE\Downloads\nixos.wsl"

if (Test-Path $downloadPath) {
    Write-Host "[2/5] nixos.wsl already downloaded, skipping..." -ForegroundColor Yellow
} else {
    Write-Host "[2/5] Downloading NixOS-WSL..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $nixosWslUrl -OutFile $downloadPath -UseBasicParsing
    Write-Host "      Downloaded to $downloadPath" -ForegroundColor Green
}

# --- Step 3: Import NixOS ---
$existingDistros = wsl --list --quiet 2>$null
if ($existingDistros -match "NixOS") {
    Write-Host "[3/5] NixOS already imported, skipping..." -ForegroundColor Yellow
} else {
    Write-Host "[3/5] Importing NixOS into WSL..." -ForegroundColor Cyan
    $nixosDir = "$env:USERPROFILE\NixOS"
    if (!(Test-Path $nixosDir)) {
        New-Item -ItemType Directory -Path $nixosDir | Out-Null
    }
    wsl --import NixOS $nixosDir $downloadPath --version 2
    Write-Host "      NixOS imported successfully" -ForegroundColor Green
}

# --- Step 4: Set NixOS as default ---
Write-Host "[4/5] Setting NixOS as default WSL distro..." -ForegroundColor Cyan
wsl -s NixOS

# --- Step 5: Run NixOS-side setup ---
Write-Host "[5/5] Launching NixOS setup..." -ForegroundColor Cyan
Write-Host ""
Write-Host "  NixOS will now boot and run the setup script." -ForegroundColor Yellow
Write-Host "  This will:" -ForegroundColor Yellow
Write-Host "    - Enable flakes and nix-ld" -ForegroundColor Yellow
Write-Host "    - Configure GPU passthrough" -ForegroundColor Yellow
Write-Host "    - Clone jpyxal-dots" -ForegroundColor Yellow
Write-Host "    - Build the WSL home-manager config" -ForegroundColor Yellow
Write-Host ""

# Copy the setup script into WSL and run it
$setupScript = @'
#!/usr/bin/env bash
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

# --- Install git ---
echo "[3/6] Getting git and home-manager..."
export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"

# --- Clone jpyxal-dots ---
echo "[4/6] Cloning jpyxal-dots..."
if [ -d "$HOME/.config/jpyxal-dots" ]; then
    echo "    Already cloned, pulling latest..."
    cd "$HOME/.config/jpyxal-dots"
    nix-shell -p git --run "git pull"
else
    nix-shell -p git --run "git clone https://github.com/justinfleek/jpyxal-dots.git $HOME/.config/jpyxal-dots"
fi

cd "$HOME/.config/jpyxal-dots"

# --- Create home-wsl.nix if it doesn't exist ---
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
echo "  ║  Run 'wsl --shutdown' then 'wsl -d NixOS'   ║"
echo "  ║  from PowerShell to start fresh.             ║"
echo "  ║                                              ║"
echo "  ║  nvidia-smi should show your GPUs.           ║"
echo "  ║  CUDA_VISIBLE_DEVICES=1 (GPU 1 for WSL)     ║"
echo "  ║                                              ║"
echo "  ║  Dots: ~/.config/jpyxal-dots                 ║"
echo "  ║  Update: cd ~/.config/jpyxal-dots            ║"
echo "  ║          home-manager switch --flake          ║"
echo "  ║            .#nixos-wsl -b backup             ║"
echo "  ╚══════════════════════════════════════════════╝"
echo ""
'@

# Write the setup script to a temp location and execute it in WSL
$tempScript = "$env:TEMP\jpyxal-wsl-setup.sh"
$setupScript | Set-Content -Path $tempScript -Encoding UTF8 -NoNewline

# Convert Windows path to WSL path and run
$wslTempPath = wsl wslpath -u ($tempScript -replace '\\', '\\')
wsl -d NixOS -- bash -c "chmod +x $wslTempPath && bash $wslTempPath"

Write-Host ""
Write-Host "  All done! Restart WSL to pick up all env changes:" -ForegroundColor Green
Write-Host "    wsl --shutdown" -ForegroundColor White
Write-Host "    wsl -d NixOS" -ForegroundColor White
Write-Host ""
