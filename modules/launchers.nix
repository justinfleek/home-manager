{
  config,
  pkgs,
  lib,
  ...
}:

# Desktop entries, dock shortcuts, and desktop icons
# Full launcher suite for j-pyxal dots

let
  # Define our key applications with icons and categories
  apps = {
    # Browsers
    firefox = {
      name = "Firefox";
      exec = "firefox";
      icon = "firefox";
      categories = [
        "Network"
        "WebBrowser"
      ];
      comment = "Browse the web";
    };
    chromium = {
      name = "Chromium";
      exec = "chromium";
      icon = "chromium";
      categories = [
        "Network"
        "WebBrowser"
      ];
      comment = "Browse the web with Chromium";
    };

    # Terminals
    ghostty = {
      name = "Ghostty";
      exec = "ghostty";
      icon = "terminal";
      categories = [
        "System"
        "TerminalEmulator"
      ];
      comment = "GPU-accelerated terminal";
    };
    kitty = {
      name = "Kitty";
      exec = "kitty";
      icon = "kitty";
      categories = [
        "System"
        "TerminalEmulator"
      ];
      comment = "Fast GPU terminal";
    };
    alacritty = {
      name = "Alacritty";
      exec = "alacritty";
      icon = "Alacritty";
      categories = [
        "System"
        "TerminalEmulator"
      ];
      comment = "GPU-accelerated terminal";
    };

    # Gaming
    steam = {
      name = "Steam";
      exec = "steam";
      icon = "steam";
      categories = [ "Game" ];
      comment = "Steam gaming platform";
    };
    lutris = {
      name = "Lutris";
      exec = "lutris";
      icon = "lutris";
      categories = [ "Game" ];
      comment = "Open gaming platform";
    };
    heroic = {
      name = "Heroic Games";
      exec = "heroic";
      icon = "heroic";
      categories = [ "Game" ];
      comment = "Epic/GOG launcher";
    };
    mangohud = {
      name = "MangoHud Config";
      exec = "mangohud";
      icon = "mangohud";
      categories = [
        "Game"
        "Settings"
      ];
      comment = "Gaming overlay config";
    };

    # AI / ComfyUI
    comfyui = {
      name = "ComfyUI";
      exec = "comfyui-launcher";
      icon = "applications-graphics";
      categories = [
        "Graphics"
        "Utility"
      ];
      comment = "Stable Diffusion node-based UI";
    };
    ollama = {
      name = "Ollama";
      exec = "kitty -e ollama run llama3";
      icon = "applications-science";
      categories = [
        "Utility"
        "Development"
      ];
      comment = "Local LLM inference";
    };

    # Development
    neovim = {
      name = "Neovim";
      exec = "kitty -e nvim";
      icon = "nvim";
      categories = [
        "Development"
        "TextEditor"
      ];
      comment = "Hyperextensible text editor";
    };
    vscode = {
      name = "VS Code";
      exec = "code";
      icon = "visual-studio-code";
      categories = [
        "Development"
        "TextEditor"
        "IDE"
      ];
      comment = "Code editor";
    };
    zed = {
      name = "Zed";
      exec = "zed";
      icon = "zed";
      categories = [
        "Development"
        "TextEditor"
      ];
      comment = "High-performance editor";
    };
    lazygit = {
      name = "LazyGit";
      exec = "kitty -e lazygit";
      icon = "git";
      categories = [ "Development" ];
      comment = "Terminal UI for git";
    };

    # File managers
    nautilus = {
      name = "Files";
      exec = "nautilus";
      icon = "org.gnome.Nautilus";
      categories = [
        "System"
        "FileManager"
      ];
      comment = "Browse files";
    };
    yazi = {
      name = "Yazi";
      exec = "kitty -e yazi";
      icon = "system-file-manager";
      categories = [
        "System"
        "FileManager"
      ];
      comment = "Terminal file manager";
    };

    # Media
    spotify = {
      name = "Spotify";
      exec = "spotify";
      icon = "spotify";
      categories = [
        "Audio"
        "Music"
      ];
      comment = "Music streaming";
    };
    mpv = {
      name = "MPV";
      exec = "mpv --player-operation-mode=pseudo-gui";
      icon = "mpv";
      categories = [
        "AudioVideo"
        "Video"
      ];
      comment = "Media player";
    };
    obs = {
      name = "OBS Studio";
      exec = "obs";
      icon = "com.obsproject.Studio";
      categories = [
        "AudioVideo"
        "Video"
      ];
      comment = "Streaming & recording";
    };

    # Communication
    discord = {
      name = "Discord";
      exec = "discord";
      icon = "discord";
      categories = [
        "Network"
        "InstantMessaging"
      ];
      comment = "Voice & text chat";
    };
    slack = {
      name = "Slack";
      exec = "slack";
      icon = "slack";
      categories = [
        "Network"
        "InstantMessaging"
      ];
      comment = "Team communication";
    };
    thunderbird = {
      name = "Thunderbird";
      exec = "thunderbird";
      icon = "thunderbird";
      categories = [
        "Network"
        "Email"
      ];
      comment = "Email client";
    };

    # Productivity
    obsidian = {
      name = "Obsidian";
      exec = "obsidian";
      icon = "obsidian";
      categories = [
        "Office"
        "TextEditor"
      ];
      comment = "Knowledge base";
    };
    # logseq = {
    #  name = "Logseq";
    #  exec = "logseq";
    #  icon = "logseq";
    #  categories = [ "Office" "Notes" ];
    #  comment = "Knowledge graph";
    # };

    # System
    btop = {
      name = "Btop";
      exec = "kitty -e btop";
      icon = "utilities-system-monitor";
      categories = [
        "System"
        "Utility"
      ];
      comment = "System monitor";
    };
    settings = {
      name = "Settings";
      exec = "gnome-control-center";
      icon = "preferences-system";
      categories = [ "Settings" ];
      comment = "System settings";
    };

    # Containers
    podman = {
      name = "Podman Desktop";
      exec = "podman-desktop";
      icon = "podman";
      categories = [
        "Development"
        "System"
      ];
      comment = "Container management";
    };

    # Security
    bitwarden = {
      name = "Bitwarden";
      exec = "bitwarden";
      icon = "bitwarden";
      categories = [
        "Utility"
        "Security"
      ];
      comment = "Password manager";
    };
  };

  # Generate desktop entry content
  mkDesktopEntry = name: app: ''
    [Desktop Entry]
    Type=Application
    Name=${app.name}
    Exec=${app.exec}
    Icon=${app.icon}
    Categories=${lib.concatStringsSep ";" app.categories};
    Comment=${app.comment}
    Terminal=false
  '';

  # ComfyUI launcher script
  comfyuiLauncher = pkgs.writeShellScriptBin "comfyui-launcher" ''
    #!/usr/bin/env bash
    # ComfyUI Launcher for j-pyxal dots

    COMFYUI_DIR="$HOME/workspace/ai/ComfyUI"

    if [ ! -d "$COMFYUI_DIR" ]; then
      notify-send "ComfyUI" "ComfyUI not found. Clone it first:\ngit clone https://github.com/comfyanonymous/ComfyUI $COMFYUI_DIR"
      exit 1
    fi

    cd "$COMFYUI_DIR"

    # Activate venv if exists
    if [ -f "venv/bin/activate" ]; then
      source venv/bin/activate
    fi

    # Launch ComfyUI
    python main.py --listen 0.0.0.0 --port 8188 &

    # Wait a moment then open browser
    sleep 3
    xdg-open "http://localhost:8188"
  '';

in
{
  # Install the ComfyUI launcher script and dock packages
  home.packages = with pkgs; [
    comfyuiLauncher
    nwg-dock-hyprland # macOS-style dock for Hyprland
    nwg-drawer # Application drawer/grid launcher
    nwg-menu # Application menu
    nwg-look # GTK settings editor
    pcmanfm # File manager with desktop icon support
  ];

  # Create .desktop files for all apps
  xdg.desktopEntries = lib.mapAttrs (name: app: {
    inherit (app) name comment categories;
    exec = app.exec;
    icon = app.icon;
    terminal = false;
  }) apps;

  # =========================================================================
  # DOCK - Using nwg-dock-hyprland for a macOS-style dock
  # =========================================================================

  home.file.".config/nwg-dock-hyprland/style.css".text = ''
    /* Catppuccin Mocha dock styling */
    window {
      background-color: rgba(30, 30, 46, 0.85);
      border-radius: 16px;
      padding: 4px;
    }

    #box {
      padding: 4px 8px;
    }

    button {
      padding: 4px;
      margin: 2px;
      border-radius: 8px;
      background-color: transparent;
      border: none;
    }

    button:hover {
      background-color: rgba(203, 166, 247, 0.3);
    }

    button:focus {
      background-color: rgba(203, 166, 247, 0.5);
      box-shadow: 0 0 0 2px rgba(203, 166, 247, 0.8);
    }

    image {
      padding: 4px;
    }
  '';

  # Dock pinned apps configuration
  home.file.".config/nwg-dock-hyprland/dock.json".text = builtins.toJSON {
    pinned = [
      "firefox"
      "ghostty"
      "nautilus"
      "neovim"
      "discord"
      "spotify"
      "steam"
      "comfyui"
      "obsidian"
      "btop"
    ];
  };

  # =========================================================================
  # DESKTOP ICONS - Using nwg-drawer or pcmanfm for desktop icons
  # =========================================================================

  # Create a Desktop folder with symlinks to .desktop files
  home.file."Desktop/Firefox.desktop".text = mkDesktopEntry "firefox" apps.firefox;
  home.file."Desktop/Terminal.desktop".text = mkDesktopEntry "ghostty" apps.ghostty;
  home.file."Desktop/Files.desktop".text = mkDesktopEntry "nautilus" apps.nautilus;
  home.file."Desktop/Steam.desktop".text = mkDesktopEntry "steam" apps.steam;
  home.file."Desktop/ComfyUI.desktop".text = mkDesktopEntry "comfyui" apps.comfyui;
  home.file."Desktop/Discord.desktop".text = mkDesktopEntry "discord" apps.discord;
  home.file."Desktop/Neovim.desktop".text = mkDesktopEntry "neovim" apps.neovim;
  home.file."Desktop/Obsidian.desktop".text = mkDesktopEntry "obsidian" apps.obsidian;

  # Make desktop files executable
  home.activation.makeDesktopExecutable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    chmod +x $HOME/Desktop/*.desktop 2>/dev/null || true
  '';

  # =========================================================================
  # WAYBAR DOCK MODULE - Alternative dock in waybar
  # =========================================================================

  # Add a custom waybar module for quick launch
  # This is configured in waybar.nix but here's the launcher scripts

  home.file.".local/bin/quick-launch".source = pkgs.writeShellScript "quick-launch" ''
    #!/usr/bin/env bash
    # Quick launch menu for waybar

    case "$1" in
      browser) firefox ;;
      terminal) ghostty ;;
      files) nautilus ;;
      editor) kitty -e nvim ;;
      games) steam ;;
      ai) comfyui-launcher ;;
      music) spotify ;;
      chat) discord ;;
      *) rofi -show drun ;;
    esac
  '';
}
