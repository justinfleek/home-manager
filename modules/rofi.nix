{ config, pkgs, lib, ... }:

{
  # ============================================================================
  # ROFI - Application launcher with sick styling
  # ============================================================================

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    
    extraConfig = {
      modi = "drun,run,filebrowser,window";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      display-drun = " Apps";
      display-run = " Run";
      display-filebrowser = " Files";
      display-window = " Windows";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
      font = "JetBrainsMono Nerd Font 12";
      
      # Behavior
      case-sensitive = false;
      cycle = true;
      filter = "";
      scroll-method = 0;
      normalize-match = true;
      
      # Matching
      matching = "fuzzy";
      tokenize = true;
      
      # SSH/Window
      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      parse-hosts = true;
      parse-known-hosts = true;
      
      # History
      disable-history = false;
      sorting-method = "fzf";
      max-history-size = 25;
      
      # Layout
      terminal = "ghostty";
      run-shell-command = "{terminal} -e {cmd}";
      
      # Keybindings
      kb-remove-to-eol = "";
      kb-accept-entry = "Return,KP_Enter";
      kb-row-up = "Up,Control+k";
      kb-row-down = "Down,Control+j";
      kb-mode-next = "Control+Tab";
      kb-mode-previous = "Control+Shift+Tab";
      kb-mode-complete = "";
      kb-remove-char-back = "BackSpace";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        # Catppuccin Mocha colors
        bg = mkLiteral "#1e1e2e";
        bg-alt = mkLiteral "#313244";
        bg-selected = mkLiteral "#45475a";
        fg = mkLiteral "#cdd6f4";
        fg-alt = mkLiteral "#a6adc8";
        border = mkLiteral "#cba6f7";
        accent = mkLiteral "#cba6f7";
        urgent = mkLiteral "#f38ba8";
        
        background-color = mkLiteral "@bg";
        text-color = mkLiteral "@fg";
      };

      window = {
        width = mkLiteral "600px";
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = false;
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";
        enabled = true;
        border = mkLiteral "2px solid";
        border-color = mkLiteral "@border";
        border-radius = mkLiteral "16px";
        cursor = "default";
        background-color = mkLiteral "@bg";
      };

      mainbox = {
        enabled = true;
        spacing = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = map mkLiteral [ "inputbar" "listbox" "mode-switcher" ];
      };

      inputbar = {
        enabled = true;
        spacing = mkLiteral "10px";
        padding = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
        orientation = mkLiteral "horizontal";
        children = map mkLiteral [ "textbox-prompt-colon" "entry" ];
      };

      textbox-prompt-colon = {
        enabled = true;
        expand = false;
        str = "";
        padding = mkLiteral "12px 15px";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg";
        font = "JetBrainsMono Nerd Font 14";
      };

      entry = {
        enabled = true;
        expand = true;
        padding = mkLiteral "12px 16px";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@fg";
        cursor = mkLiteral "text";
        placeholder = "Search...";
        placeholder-color = mkLiteral "@fg-alt";
      };

      listbox = {
        spacing = mkLiteral "10px";
        padding = mkLiteral "10px 20px 20px 20px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = map mkLiteral [ "message" "listview" ];
      };

      listview = {
        enabled = true;
        columns = 1;
        lines = 8;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;
        spacing = mkLiteral "5px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
        cursor = "default";
      };

      element = {
        enabled = true;
        spacing = mkLiteral "15px";
        padding = mkLiteral "10px 15px";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
        cursor = mkLiteral "pointer";
      };

      "element normal.normal" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "element normal.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@bg";
      };

      "element normal.active" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg";
      };

      "element selected.normal" = {
        background-color = mkLiteral "@bg-selected";
        text-color = mkLiteral "@accent";
      };

      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@bg";
      };

      "element selected.active" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg";
      };

      "element alternate.normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };

      "element alternate.urgent" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };

      "element alternate.active" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };

      element-icon = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "28px";
        cursor = mkLiteral "inherit";
      };

      element-text = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      message = {
        background-color = mkLiteral "transparent";
      };

      textbox = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@fg";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      error-message = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "@bg";
        text-color = mkLiteral "@urgent";
      };

      mode-switcher = {
        enabled = true;
        spacing = mkLiteral "10px";
        padding = mkLiteral "0px 20px 15px 20px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
      };

      button = {
        padding = mkLiteral "10px";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@fg";
        cursor = mkLiteral "pointer";
      };

      "button selected" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg";
      };
    };
  };
}
