{ config, pkgs, lib, ... }:

{
  # ============================================================================
  # WAYBAR - Sick status bar with all the info you need
  # ============================================================================

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        spacing = 0;
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        
        modules-left = [
          "custom/logo"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        
        modules-center = [
          "clock"
        ];
        
        modules-right = [
          "tray"
          "custom/separator"
          "pulseaudio"
          "custom/separator"
          "network"
          "custom/separator"
          "cpu"
          "memory"
          "custom/separator"
          "battery"
          "custom/separator"
          "custom/power"
        ];

        # === LEFT MODULES ===
        
        "custom/logo" = {
          format = " ";
          tooltip = false;
          on-click = "rofi -show drun";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "";
            active = "";
            default = "";
            urgent = "";
          };
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 40;
          separate-outputs = true;
          rewrite = {
            "(.*) — Mozilla Firefox" = " $1";
            "(.*) - Visual Studio Code" = " $1";
            "(.*)Discord(.*)" = " Discord";
            "(.*) - Obsidian(.*)" = " $1";
            "Spotify" = " Spotify";
            "ghostty" = " Terminal";
            "kitty" = " Terminal";
            "" = " Desktop";
          };
        };

        # === CENTER MODULES ===

        clock = {
          format = "  {:%H:%M}";
          format-alt = "  {:%A, %B %d, %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#cba6f7'><b>{}</b></span>";
              days = "<span color='#cdd6f4'>{}</span>";
              weeks = "<span color='#89b4fa'><b>W{}</b></span>";
              weekdays = "<span color='#fab387'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        # === RIGHT MODULES ===

        "custom/separator" = {
          format = "|";
          tooltip = false;
        };

        tray = {
          icon-size = 16;
          spacing = 8;
          show-passive-items = true;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "  muted";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
          tooltip-format = "{desc}\n{volume}%";
        };

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "  {ipaddr}";
          format-disconnected = "  Disconnected";
          format-linked = "  {ifname}";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}\n{essid} ({signalStrength}%)\n↓ {bandwidthDownBits} ↑ {bandwidthUpBits}";
          on-click = "nm-connection-editor";
        };

        cpu = {
          format = "  {usage}%";
          interval = 2;
          tooltip-format = "CPU: {usage}%\n{avg_frequency} GHz";
          on-click = "ghostty -e btop";
        };

        memory = {
          format = "  {percentage}%";
          interval = 2;
          tooltip-format = "RAM: {used:0.1f}GB / {total:0.1f}GB";
          on-click = "ghostty -e btop";
        };

        battery = {
          states = {
            good = 80;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-full = " Full";
          format-icons = [ "" "" "" "" "" ];
          tooltip-format = "{timeTo}\nHealth: {health}%\nPower: {power:.1f}W";
        };

        "custom/power" = {
          format = "";
          tooltip = false;
          on-click = "~/.local/bin/powermenu";
        };
      };
    };

    style = ''
      /* =======================================================================
         WAYBAR CATPPUCCIN MOCHA STYLE
         Glassmorphism with beautiful gradients
         ======================================================================= */

      * {
        font-family: "JetBrainsMono Nerd Font", "Inter", sans-serif;
        font-size: 13px;
        font-weight: 600;
        min-height: 0;
        margin: 0;
        padding: 0;
      }

      window#waybar {
        background: transparent;
        color: #cdd6f4;
      }

      window#waybar > box {
        background: rgba(30, 30, 46, 0.85);
        border: 1px solid rgba(203, 166, 247, 0.3);
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
      }

      tooltip {
        background: rgba(30, 30, 46, 0.95);
        border: 1px solid #cba6f7;
        border-radius: 8px;
        padding: 8px 12px;
      }

      tooltip label {
        color: #cdd6f4;
      }

      /* === LEFT SECTION === */

      #custom-logo {
        font-size: 18px;
        color: #cba6f7;
        padding: 0 12px 0 16px;
        background: linear-gradient(135deg, rgba(203, 166, 247, 0.2) 0%, transparent 100%);
        border-radius: 12px 0 0 12px;
      }

      #custom-logo:hover {
        color: #f5c2e7;
        background: linear-gradient(135deg, rgba(203, 166, 247, 0.4) 0%, transparent 100%);
      }

      #workspaces {
        margin: 4px 8px;
        padding: 0;
        background: rgba(49, 50, 68, 0.6);
        border-radius: 8px;
      }

      #workspaces button {
        padding: 4px 10px;
        margin: 2px;
        color: #6c7086;
        background: transparent;
        border: none;
        border-radius: 6px;
        transition: all 0.3s ease;
      }

      #workspaces button:hover {
        color: #cba6f7;
        background: rgba(203, 166, 247, 0.2);
      }

      #workspaces button.active {
        color: #1e1e2e;
        background: linear-gradient(135deg, #cba6f7 0%, #89b4fa 100%);
        box-shadow: 0 2px 8px rgba(203, 166, 247, 0.4);
      }

      #workspaces button.urgent {
        color: #1e1e2e;
        background: #f38ba8;
        animation: pulse 1s ease-in-out infinite;
      }

      @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.6; }
      }

      #window {
        margin-left: 8px;
        padding: 0 12px;
        color: #a6adc8;
        font-weight: 500;
      }

      /* === CENTER SECTION === */

      #clock {
        padding: 0 20px;
        color: #cdd6f4;
        font-size: 14px;
        font-weight: 700;
        background: linear-gradient(135deg, rgba(137, 180, 250, 0.15) 0%, rgba(203, 166, 247, 0.15) 100%);
        border-radius: 8px;
        margin: 4px 0;
      }

      #clock:hover {
        background: linear-gradient(135deg, rgba(137, 180, 250, 0.3) 0%, rgba(203, 166, 247, 0.3) 100%);
      }

      /* === RIGHT SECTION === */

      #custom-separator {
        color: #45475a;
        padding: 0 4px;
        font-size: 10px;
      }

      #tray {
        padding: 0 8px;
        margin: 4px 0;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background: rgba(243, 139, 168, 0.3);
        border-radius: 4px;
      }

      #pulseaudio {
        padding: 0 12px;
        color: #89b4fa;
      }

      #pulseaudio.muted {
        color: #6c7086;
      }

      #pulseaudio:hover {
        color: #b4befe;
      }

      #network {
        padding: 0 12px;
        color: #a6e3a1;
      }

      #network.disconnected {
        color: #f38ba8;
      }

      #network.linked {
        color: #f9e2af;
      }

      #network:hover {
        color: #94e2d5;
      }

      #cpu {
        padding: 0 8px;
        color: #f9e2af;
      }

      #memory {
        padding: 0 8px;
        color: #fab387;
      }

      #cpu:hover, #memory:hover {
        background: rgba(249, 226, 175, 0.15);
        border-radius: 6px;
      }

      #battery {
        padding: 0 12px;
        color: #a6e3a1;
      }

      #battery.charging {
        color: #94e2d5;
        animation: charging-pulse 2s ease-in-out infinite;
      }

      @keyframes charging-pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.7; }
      }

      #battery.warning:not(.charging) {
        color: #f9e2af;
      }

      #battery.critical:not(.charging) {
        color: #f38ba8;
        animation: pulse 1s ease-in-out infinite;
      }

      #custom-power {
        font-size: 15px;
        color: #f38ba8;
        padding: 0 16px 0 12px;
        margin: 4px 0;
        background: linear-gradient(135deg, transparent 0%, rgba(243, 139, 168, 0.2) 100%);
        border-radius: 0 12px 12px 0;
      }

      #custom-power:hover {
        color: #eba0ac;
        background: linear-gradient(135deg, transparent 0%, rgba(243, 139, 168, 0.4) 100%);
      }

      /* === HOVER EFFECTS === */

      #pulseaudio:hover,
      #network:hover,
      #battery:hover {
        background: rgba(69, 71, 90, 0.5);
        border-radius: 6px;
      }

      /* === RESPONSIVE === */

      @media (max-width: 1366px) {
        window#waybar > box {
          margin: 5px 5px;
        }
        
        #workspaces button {
          padding: 3px 8px;
        }
        
        * {
          font-size: 12px;
        }
      }
    '';
  };
}
