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
  # YAZI - File manager (configured in file-managers.nix)
  # ============================================================================

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
