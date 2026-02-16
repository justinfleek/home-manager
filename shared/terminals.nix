{
  config,
  pkgs,
  lib,
  ...
}:

{
  # ============================================================================
  # TERMINALS (WSL) - Multiplexers only, no GUI terminals
  # ============================================================================

  # No GUI terminals for WSL - use Windows Terminal or Ghostty on Windows
  # rio, wezterm configs still generated for reference

  home.packages = with pkgs; [
    # No rio - it's a GUI terminal
  ];

  # ============================================================================
  # ZELLIJ - Terminal multiplexer (works in any terminal)
  # ============================================================================

  programs.zellij = {
    enable = true;
    enableBashIntegration = false;

    settings = {
      theme = "default";
      default_layout = "compact";
      default_mode = "normal";
      pane_frames = false;
      simplified_ui = false;
      mouse_mode = true;
      scroll_buffer_size = 50000;
      copy_on_select = true;
      session_serialization = true;
      serialize_pane_viewport = true;

      ui = {
        pane_frames = {
          rounded_corners = true;
          hide_session_name = false;
        };
      };

      keybinds = {
        normal = {
          "bind \"Ctrl g\"" = {
            SwitchToMode = "locked";
          };
          "bind \"Ctrl p\"" = {
            SwitchToMode = "pane";
          };
          "bind \"Ctrl t\"" = {
            SwitchToMode = "tab";
          };
          "bind \"Ctrl n\"" = {
            SwitchToMode = "resize";
          };
          "bind \"Ctrl s\"" = {
            SwitchToMode = "scroll";
          };
          "bind \"Ctrl o\"" = {
            SwitchToMode = "session";
          };
          "bind \"Ctrl h\"" = {
            MoveFocus = "Left";
          };
          "bind \"Ctrl j\"" = {
            MoveFocus = "Down";
          };
          "bind \"Ctrl k\"" = {
            MoveFocus = "Up";
          };
          "bind \"Ctrl l\"" = {
            MoveFocus = "Right";
          };
        };
      };
    };
  };

  xdg.configFile."zellij/layouts/dev.kdl".text = ''
    layout {
      default_tab_template {
        pane size=1 borderless=true {
          plugin location="tab-bar"
        }
        children
        pane size=2 borderless=true {
          plugin location="status-bar"
        }
      }

      tab name="code" focus=true {
        pane split_direction="vertical" {
          pane size="70%" command="nvim"
          pane size="30%" split_direction="horizontal" {
            pane command="lazygit"
            pane
          }
        }
      }

      tab name="term" {
        pane
      }

      tab name="logs" {
        pane command="btop"
      }
    }
  '';

  programs.bash.shellAliases = {
    zj = "zellij";
    zja = "zellij attach";
    zjl = "zellij list-sessions";
    zjd = "zellij --layout dev";
  };
}
