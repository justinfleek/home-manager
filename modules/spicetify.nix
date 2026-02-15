{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  # ============================================================================
  # SPICETIFY - Spotify with Catppuccin theming
  # ============================================================================

  # Import spicetify module
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;

    # Default theme
    theme = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.default;
    colorScheme = "default";

    # Extensions
    enabledExtensions =
      with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
        adblock # Block ads
        hidePodcasts # Hide podcasts
        shuffle # Better shuffle
        fullAppDisplay # Full screen mode
        keyboardShortcut # Better keyboard shortcuts
        loopyLoop # Loop sections
        playlistIcons # Custom playlist icons
        popupLyrics # Lyrics popup
        seekSong # Seek with arrow keys
        trashbin # Trash bin for deleted songs
        history # History sidebar
        lastfm # Last.fm scrobbling
      ];

    # Custom apps
    enabledCustomApps =
      with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.apps; [
        lyricsPlus # Better lyrics
        marketplace # Extension marketplace
        reddit # Reddit integration
      ];
  };
}
