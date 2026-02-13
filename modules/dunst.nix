{
  config,
  pkgs,
  lib,
  ...
}:

{
  # ============================================================================
  # DUNST - Notification daemon with catppuccin styling
  # ============================================================================

  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
      size = "32x32";
    };

    settings = {
      global = {
        # Display
        monitor = 0;
        follow = "mouse";

        # Geometry
        width = "(300, 400)";
        height = 300;
        origin = "top-right";
        offset = "15x15";
        scale = 0;
        notification_limit = 5;

        # Progress bar
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 400;
        progress_bar_corner_radius = 5;

        # Appearance
        indicate_hidden = true;
        transparency = 0;
        separator_height = 2;
        padding = 15;
        horizontal_padding = 15;
        text_icon_padding = 15;
        frame_width = 2;
        frame_color = "#cba6f7";
        gap_size = 5;
        separator_color = "frame";
        sort = true;
        idle_threshold = 120;

        # Text
        font = "Inter 11";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;

        # Icons
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 64;

        # History
        sticky_history = true;
        history_length = 20;

        # Misc
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";
        browser = "${pkgs.firefox}/bin/firefox -new-tab";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 12;
        ignore_dbusclose = false;

        # Layer
        layer = "overlay";
        force_xwayland = false;

        # Mouse
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
      };

      experimental = {
        per_monitor_dpi = false;
      };

      # Urgency levels with Catppuccin Mocha colors
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
        timeout = 5;
        icon = "dialog-information";
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#cba6f7";
        timeout = 10;
        icon = "dialog-information";
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8";
        timeout = 0;
        icon = "dialog-error";
      };

      # App-specific rules
      discord = {
        appname = "discord";
        frame_color = "#89b4fa";
        timeout = 8;
      };

      spotify = {
        appname = "Spotify";
        frame_color = "#a6e3a1";
        timeout = 5;
      };

      slack = {
        appname = "Slack";
        frame_color = "#f9e2af";
        timeout = 10;
      };

      firefox = {
        appname = "Firefox";
        frame_color = "#fab387";
        timeout = 8;
      };

      screenshot = {
        appname = "screenshot";
        frame_color = "#94e2d5";
        timeout = 3;
      };

      volume = {
        appname = "volume";
        frame_color = "#89b4fa";
        timeout = 2;
        history_ignore = true;
      };

      brightness = {
        appname = "brightness";
        frame_color = "#f9e2af";
        timeout = 2;
        history_ignore = true;
      };
    };
  };
}
