{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  # ============================================================================
  # HYPRLAND - The Ultimate Wayland Compositor
  # Smooth animations, sick effects, keyboard-driven workflow
  # ============================================================================

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      # ========================================================================
      # MONITORS
      # ========================================================================
      # Configure your monitors here
      # Use `hyprctl monitors` to get monitor names
      monitor = [
        # Default fallback - adapt to any monitor
        ",preferred,auto,1"
        # Examples:
        # "DP-1,2560x1440@144,0x0,1"
        # "HDMI-A-1,1920x1080@60,2560x0,1"
      ];

      # ========================================================================
      # AUTOSTART
      # ========================================================================
      exec-once = [
        # Core services
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        # Wallpaper daemon
        "swww-daemon"
        "sleep 1 && ~/.local/bin/wallpaper"

        # Bar
        "waybar"

        # Clipboard
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        # Notification daemon
        "dunst"

        # Idle daemon
        "hypridle"

        # Cursor
        "hyprctl setcursor catppuccin-mocha-mauve-cursors 24"

        # Dock (macOS-style)
        "nwg-dock-hyprland -d -i 48 -p 'bottom' -mb 10 -ml 10 -mr 10"
      ];

      # ========================================================================
      # ENVIRONMENT VARIABLES
      # ========================================================================
      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];

      # ========================================================================
      # GENERAL
      # ========================================================================
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        # Catppuccin Mocha colors
        "col.active_border" = "rgba(cba6f7ee) rgba(89b4faee) 45deg";
        "col.inactive_border" = "rgba(313244aa)";

        layout = "dwindle";
        resize_on_border = true;
        extend_border_grab_area = 15;
        hover_icon_on_border = true;
      };

      # ========================================================================
      # DECORATION - The eye candy
      # ========================================================================
      decoration = {
        rounding = 12;

        active_opacity = 1.0;
        inactive_opacity = 0.92;
        fullscreen_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 20;
        shadow_render_power = 3;
        shadow_offset = "0 5";
        "col.shadow" = "rgba(1a1a2eee)";
        "col.shadow_inactive" = "rgba(1a1a2e77)";

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = true;
          xray = false;
          noise = 0.02;
          contrast = 0.9;
          brightness = 0.8;
          vibrancy = 0.17;
          vibrancy_darkness = 0.0;
          special = true;
          popups = true;
        };
      };

      # ========================================================================
      # ANIMATIONS - Smooth as butter
      # ========================================================================
      animations = {
        enabled = true;
        first_launch_animation = true;

        bezier = [
          # Smooth curves
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
          "linear, 0.0, 0.0, 1.0, 1.0"

          # Catppuccin-inspired
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"

          # Snappy
          "snap, 0.2, 1, 0.3, 1"
        ];

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 5, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 10, default"
          "borderangle, 1, 100, liner, loop"
          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces, 1, 5, wind"
          "specialWorkspace, 1, 5, wind, slidevert"
        ];
      };

      # ========================================================================
      # INPUT
      # ========================================================================
      input = {
        kb_layout = "us";
        kb_options = "caps:escape"; # Caps Lock as Escape (vim gang)

        follow_mouse = 1;
        mouse_refocus = true;

        sensitivity = 0;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = true;
          drag_lock = false;
          scroll_factor = 1.0;
        };
      };

      # ========================================================================
      # GESTURES
      # ========================================================================
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 300;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_forever = true;
      };

      # ========================================================================
      # LAYOUTS
      # ========================================================================
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = false;
        smart_resizing = true;
        force_split = 2;
        special_scale_factor = 0.95;
      };

      master = {
        new_status = "master";
        new_on_top = true;
        mfact = 0.55;
        special_scale_factor = 0.95;
      };

      # ========================================================================
      # MISC
      # ========================================================================
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;

        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;

        enable_swallow = true;
        swallow_regex = "^(ghostty|kitty|Alacritty|foot)$";
        swallow_exception_regex = "^(wev)$";

        focus_on_activate = false;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;

        new_window_takes_over_fullscreen = 2;

        vfr = true;
        vrr = 1;
      };

      # ========================================================================
      # WINDOW RULES
      # ========================================================================
      windowrulev2 = [
        # Floating windows
        "float, class:^(pavucontrol)$"
        "float, class:^(nm-connection-editor)$"
        "float, class:^(blueman-manager)$"
        "float, class:^(file-roller)$"
        "float, class:^(nwg-look)$"
        "float, class:^(qt5ct)$"
        "float, class:^(kvantummanager)$"
        "float, title:^(Open File)$"
        "float, title:^(Save File)$"
        "float, title:^(Confirm)$"
        "float, title:^(File Operation)$"
        "float, class:^(imv)$"
        "float, class:^(mpv)$"
        "float, class:^(swappy)$"

        # Picture in picture
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "size 640 360, title:^(Picture-in-Picture)$"
        "move 100%-660 100%-380, title:^(Picture-in-Picture)$"

        # Firefox
        "opacity 1.0 override 1.0 override, class:^(firefox)$"

        # Discord
        "workspace 9 silent, class:^(discord)$"

        # Spotify
        "workspace 8 silent, class:^(Spotify)$"

        # Steam
        "float, class:^(steam)$,title:^(Friends List)$"
        "float, class:^(steam)$,title:^(Steam - News)$"

        # XWayland video bridge (for screen sharing)
        "opacity 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"

        # Rofi
        "animation slide, class:^(Rofi)$"
        "noanim, class:^(Rofi)$"

        # Terminal opacity (let's see that blur)
        "opacity 0.95 override 0.90 override, class:^(ghostty)$"
        "opacity 0.95 override 0.90 override, class:^(kitty)$"
        "opacity 0.95 override 0.90 override, class:^(Alacritty)$"
      ];

      # ========================================================================
      # LAYER RULES
      # ========================================================================
      layerrule = [
        "blur, waybar"
        "ignorezero, waybar"
        "blur, rofi"
        "ignorezero, rofi"
        "blur, dunst"
        "ignorezero, dunst"
        "blur, logout_dialog"
      ];

      # ========================================================================
      # KEYBINDINGS
      # ========================================================================
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$fileManager" = "nautilus";
      "$menu" = "rofi -show drun";
      "$browser" = "firefox";

      bind = [
        # === CORE APPS ===
        "$mod, Return, exec, $terminal"
        "$mod, E, exec, $fileManager"
        "$mod, B, exec, $browser"
        "$mod, Space, exec, $menu"

        # Window management
        "$mod, Q, killactive"
        "$mod SHIFT, Q, exit"
        "$mod, F, fullscreen, 0"
        "$mod SHIFT, F, fullscreen, 1"
        "$mod, T, togglefloating"
        "$mod, P, pseudo"
        "$mod, S, togglesplit"
        "$mod, G, togglegroup"
        "$mod, Tab, changegroupactive, f"
        "$mod SHIFT, Tab, changegroupactive, b"

        # Focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "$mod, Left, movefocus, l"
        "$mod, Right, movefocus, r"
        "$mod, Up, movefocus, u"
        "$mod, Down, movefocus, d"

        # Move windows
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, Left, movewindow, l"
        "$mod SHIFT, Right, movewindow, r"
        "$mod SHIFT, Up, movewindow, u"
        "$mod SHIFT, Down, movewindow, d"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Silent move (don't follow)
        "$mod ALT, 1, movetoworkspacesilent, 1"
        "$mod ALT, 2, movetoworkspacesilent, 2"
        "$mod ALT, 3, movetoworkspacesilent, 3"
        "$mod ALT, 4, movetoworkspacesilent, 4"
        "$mod ALT, 5, movetoworkspacesilent, 5"

        # Scroll through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "$mod, bracketright, workspace, e+1"
        "$mod, bracketleft, workspace, e-1"

        # Special workspace (scratchpad)
        "$mod, grave, togglespecialworkspace, magic"
        "$mod SHIFT, grave, movetoworkspace, special:magic"

        # Screenshots
        ", Print, exec, ~/.local/bin/screenshot area"
        "SHIFT, Print, exec, ~/.local/bin/screenshot full"
        "ALT, Print, exec, ~/.local/bin/screenshot window"

        # Color picker
        "$mod SHIFT, C, exec, ~/.local/bin/colorpicker"

        # Clipboard history
        "$mod, V, exec, cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy"

        # Lock screen
        "$mod SHIFT, Escape, exec, hyprlock"

        # Power menu
        "$mod, Escape, exec, ~/.local/bin/powermenu"

        # Wallpaper
        "$mod, W, exec, ~/.local/bin/wallpaper"

        # Notification center
        "$mod, N, exec, dunstctl history-pop"
        "$mod SHIFT, N, exec, dunstctl close-all"

        # Apps
        "$mod, C, exec, code"
        "$mod, O, exec, obsidian"
        "$mod, D, exec, discord"
        "$mod, M, exec, spotify"
      ];

      # Resize mode
      binde = [
        "$mod CTRL, H, resizeactive, -50 0"
        "$mod CTRL, L, resizeactive, 50 0"
        "$mod CTRL, K, resizeactive, 0 -50"
        "$mod CTRL, J, resizeactive, 0 50"
        "$mod CTRL, Left, resizeactive, -50 0"
        "$mod CTRL, Right, resizeactive, 50 0"
        "$mod CTRL, Up, resizeactive, 0 -50"
        "$mod CTRL, Down, resizeactive, 0 50"
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Media keys
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];
    };

    # Extra config that doesn't fit in settings
    extraConfig = ''
      # Submap for resizing (vim-style resize mode)
      bind = $mod, R, submap, resize
      submap = resize
      binde = , h, resizeactive, -30 0
      binde = , l, resizeactive, 30 0
      binde = , k, resizeactive, 0 -30
      binde = , j, resizeactive, 0 30
      bind = , escape, submap, reset
      bind = , Return, submap, reset
      submap = reset
    '';
  };

  # ============================================================================
  # HYPRLOCK - Lock screen
  # ============================================================================

  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 3;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
          color = "rgba(30, 30, 46, 1.0)";
        }
      ];

      input-field = [
        {
          size = "250, 50";
          outline_thickness = 3;
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          outer_color = "rgb(203, 166, 247)";
          inner_color = "rgb(49, 50, 68)";
          font_color = "rgb(205, 214, 244)";
          fade_on_empty = true;
          fade_timeout = 1000;
          placeholder_text = "<i>Password...</i>";
          hide_input = false;
          rounding = 12;
          check_color = "rgb(166, 227, 161)";
          fail_color = "rgb(243, 139, 168)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_timeout = 2000;
          fail_transition = 300;
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Time
        {
          text = ''cmd[update:1000] echo "$(date +"%H:%M")"'';
          color = "rgb(205, 214, 244)";
          font_size = 120;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgb(166, 173, 200)";
          font_size = 24;
          font_family = "Inter";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        # User
        {
          text = "Hi, $USER";
          color = "rgb(203, 166, 247)";
          font_size = 18;
          font_family = "Inter";
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  # ============================================================================
  # HYPRIDLE - Idle daemon
  # ============================================================================

  services.hypridle = {
    enable = true;
    package = inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.hypridle;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # Dim screen
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        # Turn off keyboard backlight
        {
          timeout = 150;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        # Lock screen
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        # Turn off screen
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # Suspend
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
