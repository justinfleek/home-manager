{ config, pkgs, lib, ... }:

{
  # ============================================================================
  # ADDITIONAL TOOLS - System utilities and enhancements
  # ============================================================================

  # ============================================================================
  # FASTFETCH - System info fetch with custom config
  # ============================================================================

  xdg.configFile."fastfetch/config.jsonc".text = builtins.toJSON {
    "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
    logo = {
      type = "small";
      color = {
        "1" = "magenta";
      };
    };
    display = {
      separator = " -> ";
      color = {
        keys = "magenta";
        title = "blue";
      };
    };
    modules = [
      "title"
      "separator"
      {
        type = "os";
        key = " OS";
      }
      {
        type = "kernel";
        key = " Kernel";
      }
      {
        type = "uptime";
        key = " Uptime";
      }
      {
        type = "packages";
        key = " Packages";
      }
      {
        type = "shell";
        key = " Shell";
      }
      {
        type = "de";
        key = " DE";
      }
      {
        type = "wm";
        key = " WM";
      }
      {
        type = "terminal";
        key = " Terminal";
      }
      {
        type = "terminalfont";
        key = " Font";
      }
      "separator"
      {
        type = "cpu";
        key = " CPU";
      }
      {
        type = "gpu";
        key = " GPU";
      }
      {
        type = "memory";
        key = " Memory";
      }
      {
        type = "disk";
        key = " Disk";
      }
      "separator"
      {
        type = "colors";
        paddingLeft = 2;
        symbol = "circle";
      }
    ];
  };

  # Small config for quick display
  xdg.configFile."fastfetch/small.jsonc".text = builtins.toJSON {
    "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
    logo.type = "none";
    display = {
      separator = " ";
      color.keys = "magenta";
    };
    modules = [
      {
        type = "custom";
        format = "{#35}    {#36}    {#32}    {#33}    {#34}    {#35}    {#31}   ";
      }
    ];
  };

  # ============================================================================
  # SWAPPY - Screenshot annotation tool
  # ============================================================================

  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=$HOME/pictures/screenshots
    save_filename_format=screenshot-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Inter
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';

  # ============================================================================
  # BOTTOM (btm) - Alternative system monitor
  # ============================================================================

  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        avg_cpu = true;
        temperature_type = "c";
        rate = "500ms";
        tree = true;
        battery = true;
        network_use_binary_prefix = true;
        network_use_bytes = true;
      };
      colors = {
        # Catppuccin Mocha
        table_header_color = "#cba6f7";
        all_cpu_color = "#cba6f7";
        avg_cpu_color = "#f38ba8";
        cpu_core_colors = [ "#f38ba8" "#fab387" "#f9e2af" "#a6e3a1" "#94e2d5" "#89b4fa" "#cba6f7" "#f5c2e7" ];
        ram_color = "#a6e3a1";
        swap_color = "#fab387";
        rx_color = "#89b4fa";
        tx_color = "#f38ba8";
        widget_title_color = "#cdd6f4";
        border_color = "#45475a";
        highlighted_border_color = "#cba6f7";
        text_color = "#cdd6f4";
        selected_text_color = "#1e1e2e";
        selected_bg_color = "#cba6f7";
        graph_color = "#6c7086";
        disabled_text_color = "#585b70";
        high_battery_color = "#a6e3a1";
        medium_battery_color = "#f9e2af";
        low_battery_color = "#f38ba8";
      };
    };
  };

  # ============================================================================
  # YAZI - File manager
  # ============================================================================

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    
    settings = {
      manager = {
        ratio = [ 1 4 3 ];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "size";
        show_hidden = true;
        show_symlink = true;
      };
      
      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        image_filter = "triangle";
        image_quality = 75;
        sixel_fraction = 15;
        ueberzug_scale = 1;
        ueberzug_offset = [ 0 0 0 0 ];
      };
      
      opener = {
        edit = [
          { run = ''nvim "$@"''; block = true; for = "unix"; }
        ];
        play = [
          { run = ''mpv "$@"''; orphan = true; for = "unix"; }
        ];
        open = [
          { run = ''xdg-open "$@"''; orphan = true; for = "linux"; }
        ];
      };
    };
    
    theme = {
      manager = {
        cwd = { fg = "#94e2d5"; };
        hovered = { fg = "#1e1e2e"; bg = "#cba6f7"; };
        preview_hovered = { underline = true; };
        find_keyword = { fg = "#f9e2af"; italic = true; };
        find_position = { fg = "#f5c2e7"; bg = "reset"; italic = true; };
        marker_selected = { fg = "#a6e3a1"; bg = "#a6e3a1"; };
        marker_copied = { fg = "#f9e2af"; bg = "#f9e2af"; };
        marker_cut = { fg = "#f38ba8"; bg = "#f38ba8"; };
        tab_active = { fg = "#1e1e2e"; bg = "#cba6f7"; };
        tab_inactive = { fg = "#cdd6f4"; bg = "#45475a"; };
        tab_width = 1;
        border_symbol = "│";
        border_style = { fg = "#45475a"; };
      };
      
      status = {
        separator_open = "";
        separator_close = "";
        separator_style = { fg = "#45475a"; bg = "#45475a"; };
        mode_normal = { fg = "#1e1e2e"; bg = "#89b4fa"; bold = true; };
        mode_select = { fg = "#1e1e2e"; bg = "#a6e3a1"; bold = true; };
        mode_unset = { fg = "#1e1e2e"; bg = "#f38ba8"; bold = true; };
        progress_label = { fg = "#cdd6f4"; bold = true; };
        progress_normal = { fg = "#89b4fa"; bg = "#45475a"; };
        progress_error = { fg = "#f38ba8"; bg = "#45475a"; };
        permissions_t = { fg = "#89b4fa"; };
        permissions_r = { fg = "#f9e2af"; };
        permissions_w = { fg = "#f38ba8"; };
        permissions_x = { fg = "#a6e3a1"; };
        permissions_s = { fg = "#6c7086"; };
      };
      
      input = {
        border = { fg = "#89b4fa"; };
        title = { };
        value = { };
        selected = { reversed = true; };
      };
      
      select = {
        border = { fg = "#89b4fa"; };
        active = { fg = "#f5c2e7"; };
        inactive = { };
      };
      
      tasks = {
        border = { fg = "#89b4fa"; };
        title = { };
        hovered = { underline = true; };
      };
      
      which = {
        mask = { bg = "#313244"; };
        cand = { fg = "#94e2d5"; };
        rest = { fg = "#6c7086"; };
        desc = { fg = "#f5c2e7"; };
        separator = " -> ";
        separator_style = { fg = "#45475a"; };
      };
      
      help = {
        on = { fg = "#f5c2e7"; };
        exec = { fg = "#94e2d5"; };
        desc = { fg = "#6c7086"; };
        hovered = { bg = "#45475a"; bold = true; };
        footer = { fg = "#45475a"; bg = "#cdd6f4"; };
      };
      
      filetype = {
        rules = [
          { mime = "image/*"; fg = "#94e2d5"; }
          { mime = "video/*"; fg = "#f9e2af"; }
          { mime = "audio/*"; fg = "#f9e2af"; }
          { mime = "application/zip"; fg = "#f5c2e7"; }
          { mime = "application/gzip"; fg = "#f5c2e7"; }
          { mime = "application/x-tar"; fg = "#f5c2e7"; }
          { mime = "application/x-bzip"; fg = "#f5c2e7"; }
          { mime = "application/x-bzip2"; fg = "#f5c2e7"; }
          { mime = "application/x-7z-compressed"; fg = "#f5c2e7"; }
          { mime = "application/x-rar"; fg = "#f5c2e7"; }
          { name = "*"; fg = "#cdd6f4"; }
          { name = "*/"; fg = "#89b4fa"; }
        ];
      };
    };
  };

  # ============================================================================
  # IMHEX - Hex editor (optional binary analysis)
  # ============================================================================

  # Additional config files
  
  # ripgrep config
  xdg.configFile."ripgrep/config".text = ''
    --smart-case
    --hidden
    --glob=!.git/*
    --glob=!node_modules/*
    --glob=!target/*
    --glob=!.direnv/*
    --colors=line:fg:yellow
    --colors=line:style:bold
    --colors=path:fg:green
    --colors=path:style:bold
    --colors=match:fg:red
    --colors=match:style:bold
  '';

  # fd ignore
  xdg.configFile."fd/ignore".text = ''
    .git/
    node_modules/
    target/
    .direnv/
    result
    result-*
  '';
}
