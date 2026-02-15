{ config, pkgs, lib, ... }:

{
  # ============================================================================
  # TMUX - Terminal multiplexer with minimal styling
  # ============================================================================

  programs.tmux = {
    enable = true;
    
    # Core settings
    shell = "${pkgs.bash}/bin/bash";
    terminal = "tmux-256color";
    historyLimit = 100000;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    
    # Plugins
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
      continuum
      vim-tmux-navigator
    ];
    
    extraConfig = ''
      # ==========================================================================
      # TMUX CONFIG - Riced to perfection
      # ==========================================================================

      # === TRUE COLORS ===
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
      set-environment -g COLORTERM "truecolor"

      # === PREFIX ===
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      # === RELOAD CONFIG ===
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # === PANE MANAGEMENT ===
      # Split panes using | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind \\ split-window -h -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Vim-like pane switching
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Resize panes with vim keys
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Quick pane cycling
      bind -r Tab select-pane -t :.+

      # === WINDOW MANAGEMENT ===
      # New window in current path
      bind c new-window -c "#{pane_current_path}"

      # Window navigation
      bind -r C-h previous-window
      bind -r C-l next-window

      # Swap windows
      bind -r "<" swap-window -d -t -1
      bind -r ">" swap-window -d -t +1

      # Rename window
      bind , command-prompt -I "#W" "rename-window '%%'"

      # === COPY MODE ===
      bind Enter copy-mode
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send-keys -X cancel

      # === SESSION MANAGEMENT ===
      bind S command-prompt -p "New session:" "new-session -A -s '%%'"
      bind K confirm-before -p "Kill session #S? (y/n)" kill-session

      # Session switcher
      bind s choose-tree -sZ

      # === MISC ===
      # Renumber windows when one is closed
      set -g renumber-windows on

      # Activity monitoring
      setw -g monitor-activity on
      set -g visual-activity off

      # Focus events
      set -g focus-events on

      # Don't detach on session destroy
      set -g detach-on-destroy off

      # Status bar position
      set -g status-position top

      # Pane borders
      set -g pane-border-style "fg=#45475a"
      set -g pane-active-border-style "fg=#cba6f7"

      # Message styling
      set -g message-style "fg=#cdd6f4,bg=#313244"
      set -g message-command-style "fg=#cdd6f4,bg=#313244"

      # Mode styling
      set -g mode-style "fg=#1e1e2e,bg=#cba6f7"

      # Clock
      set -g clock-mode-colour "#cba6f7"
      set -g clock-mode-style 24

      # === CONTINUUM & RESURRECT ===
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15'
      set -g @resurrect-capture-pane-contents 'on'
      set -g @resurrect-strategy-nvim 'session'

      # === POPUP TERMINALS ===
      bind -n M-g display-popup -d "#{pane_current_path}" -w 80% -h 80% -E "lazygit"
      bind -n M-t display-popup -d "#{pane_current_path}" -w 80% -h 80% -E "btop"
    '';
  };
}
