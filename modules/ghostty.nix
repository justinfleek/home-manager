{ config, pkgs, lib, ... }:

{
  # ============================================================================
  # GHOSTTY - The terminal that goes hard
  # GPU-accelerated, feature-rich, beautifully configured
  # ============================================================================

  # Ghostty config (home-manager doesn't have native support yet)
  xdg.configFile."ghostty/config".text = ''
    # ==========================================================================
    # GHOSTTY CONFIG - Hypermodern Terminal
    # Catppuccin Mocha with sick customizations
    # ==========================================================================

    # === FONT ===
    font-family = JetBrainsMono Nerd Font
    font-family-bold = JetBrainsMono Nerd Font Bold
    font-family-italic = JetBrainsMono Nerd Font Italic
    font-family-bold-italic = JetBrainsMono Nerd Font Bold Italic
    font-size = 13
    font-feature = calt
    font-feature = liga
    font-feature = dlig
    adjust-cell-height = 10%

    # === CATPPUCCIN MOCHA THEME ===
    # Background and foreground
    background = 1e1e2e
    foreground = cdd6f4
    selection-background = 45475a
    selection-foreground = cdd6f4
    cursor-color = f5e0dc
    cursor-text = 1e1e2e

    # Normal colors
    palette = 0=#45475a
    palette = 1=#f38ba8
    palette = 2=#a6e3a1
    palette = 3=#f9e2af
    palette = 4=#89b4fa
    palette = 5=#f5c2e7
    palette = 6=#94e2d5
    palette = 7=#bac2de

    # Bright colors
    palette = 8=#585b70
    palette = 9=#f38ba8
    palette = 10=#a6e3a1
    palette = 11=#f9e2af
    palette = 12=#89b4fa
    palette = 13=#f5c2e7
    palette = 14=#94e2d5
    palette = 15=#a6adc8

    # === WINDOW ===
    window-padding-x = 16
    window-padding-y = 12
    window-decoration = false
    gtk-titlebar = false
    background-opacity = 0.92
    background-blur-radius = 20
    unfocused-split-opacity = 0.9

    # === CURSOR ===
    cursor-style = block
    cursor-style-blink = true
    cursor-opacity = 0.9
    mouse-hide-while-typing = true

    # === SCROLLBACK ===
    scrollback-limit = 50000

    # === MISC ===
    confirm-close-surface = false
    copy-on-select = clipboard
    shell-integration = detect
    shell-integration-features = cursor,sudo,title
    bold-is-bright = false
    minimum-contrast = 1.0

    # === KEYBINDINGS ===
    # Splits
    keybind = ctrl+shift+enter=new_split:right
    keybind = ctrl+shift+backslash=new_split:down
    keybind = ctrl+shift+h=goto_split:left
    keybind = ctrl+shift+l=goto_split:right
    keybind = ctrl+shift+k=goto_split:top
    keybind = ctrl+shift+j=goto_split:bottom
    keybind = ctrl+shift+w=close_surface

    # Tabs
    keybind = ctrl+shift+t=new_tab
    keybind = ctrl+shift+page_up=previous_tab
    keybind = ctrl+shift+page_down=next_tab
    keybind = ctrl+shift+1=goto_tab:1
    keybind = ctrl+shift+2=goto_tab:2
    keybind = ctrl+shift+3=goto_tab:3
    keybind = ctrl+shift+4=goto_tab:4
    keybind = ctrl+shift+5=goto_tab:5

    # Font size
    keybind = ctrl+plus=increase_font_size:1
    keybind = ctrl+minus=decrease_font_size:1
    keybind = ctrl+0=reset_font_size

    # Misc
    keybind = ctrl+shift+c=copy_to_clipboard
    keybind = ctrl+shift+v=paste_from_clipboard
    keybind = ctrl+shift+f=toggle_fullscreen
    keybind = ctrl+shift+r=reload_config
    keybind = ctrl+shift+comma=open_config
    keybind = ctrl+shift+i=inspector:toggle

    # Scrolling
    keybind = ctrl+shift+up=scroll_page_up
    keybind = ctrl+shift+down=scroll_page_down
    keybind = ctrl+shift+home=scroll_to_top
    keybind = ctrl+shift+end=scroll_to_bottom

    # === QUICK TERMINAL (dropdown) ===
    # Use with hyprland special workspace for dropdown terminal
    quick-terminal-position = top
    quick-terminal-screen = main
    quick-terminal-animation-duration = 0.15
  '';
}
