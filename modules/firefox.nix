{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  # ============================================================================
  # FIREFOX - Riced browser with catppuccin theming
  # ============================================================================

  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      # Required for catppuccin extensions
      extensions.force = true;

      # Search engines (use lowercase IDs: ddg, google, bing, youtube)
      search = {
        force = true;
        default = "ddg";
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "NixOS Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };
          "Home Manager Options" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@hm" ];
          };
          "GitHub" = {
            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@gh" ];
          };
          "youtube" = {
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@yt" ];
          };
          "bing".metaData.hidden = true;
          "google".metaData.alias = "@g";
          "ddg".metaData.alias = "@ddg";
        };
      };

      # User settings
      settings = {
        # === APPEARANCE ===
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;
        "svg.context-properties.content.enabled" = true;
        "layout.css.has-selector.enabled" = true;

        # === PRIVACY ===
        "browser.contentblocking.category" = "strict";
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.partition.network_state.ocsp_cache" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.query_stripping.enabled" = true;

        # Disable telemetry
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.coverage.opt-out" = true;
        "browser.ping-centre.telemetry" = false;

        # === SECURITY ===
        "dom.security.https_only_mode" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;

        # === BEHAVIOR ===
        "browser.startup.homepage" = "about:home";
        "browser.newtabpage.enabled" = true;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";

        # Disable pocket
        "extensions.pocket.enabled" = false;

        # Smooth scrolling
        "general.smoothScroll" = true;
        "general.smoothScroll.msdPhysics.enabled" = true;

        # Hardware acceleration
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;

        # === UI ===
        "browser.tabs.inTitlebar" = 0;
        "browser.tabs.tabmanager.enabled" = false;
        "findbar.highlightAll" = true;
        "browser.urlbar.suggest.searches" = true;
        "browser.urlbar.showSearchSuggestionsFirst" = false;

        # Disable annoyances
        "browser.aboutConfig.showWarning" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.translations.automaticallyPopup" = false;
        "browser.urlbar.quicksuggest.enabled" = false;

        # DevTools
        "devtools.theme" = "dark";
        "devtools.debugger.ui.editor-wrapping" = true;
      };

      # UserChrome CSS for ricing
      userChrome = ''
        /* ==========================================================================
           FIREFOX USERCHROME - Catppuccin Mocha
           Clean, minimal, beautiful
           ========================================================================== */

        :root {
          /* Catppuccin Mocha */
          --ctp-rosewater: #f5e0dc;
          --ctp-flamingo: #f2cdcd;
          --ctp-pink: #f5c2e7;
          --ctp-mauve: #cba6f7;
          --ctp-red: #f38ba8;
          --ctp-maroon: #eba0ac;
          --ctp-peach: #fab387;
          --ctp-yellow: #f9e2af;
          --ctp-green: #a6e3a1;
          --ctp-teal: #94e2d5;
          --ctp-sky: #89dceb;
          --ctp-sapphire: #74c7ec;
          --ctp-blue: #89b4fa;
          --ctp-lavender: #b4befe;
          --ctp-text: #cdd6f4;
          --ctp-subtext1: #bac2de;
          --ctp-subtext0: #a6adc8;
          --ctp-overlay2: #9399b2;
          --ctp-overlay1: #7f849c;
          --ctp-overlay0: #6c7086;
          --ctp-surface2: #585b70;
          --ctp-surface1: #45475a;
          --ctp-surface0: #313244;
          --ctp-base: #1e1e2e;
          --ctp-mantle: #181825;
          --ctp-crust: #11111b;
          
          /* Apply to Firefox */
          --toolbar-bgcolor: var(--ctp-base) !important;
          --toolbar-color: var(--ctp-text) !important;
          --lwt-toolbar-field-background-color: var(--ctp-surface0) !important;
          --lwt-toolbar-field-color: var(--ctp-text) !important;
          --lwt-toolbar-field-focus: var(--ctp-surface1) !important;
          --urlbar-box-bgcolor: var(--ctp-surface0) !important;
          --urlbar-box-hover-bgcolor: var(--ctp-surface1) !important;
          --tab-border-radius: 8px;
        }

        /* === TABS === */
        .tabbrowser-tab {
          border-radius: var(--tab-border-radius) var(--tab-border-radius) 0 0 !important;
          margin-inline: 2px !important;
        }

        .tabbrowser-tab[selected="true"] {
          background-color: var(--ctp-surface0) !important;
        }

        .tabbrowser-tab:hover:not([selected="true"]) {
          background-color: var(--ctp-surface1) !important;
        }

        /* Tab close button */
        .tab-close-button {
          border-radius: 50% !important;
        }

        .tab-close-button:hover {
          background-color: var(--ctp-red) !important;
        }

        /* === TOOLBAR === */
        #nav-bar {
          background: var(--ctp-base) !important;
          border-bottom: 1px solid var(--ctp-surface0) !important;
        }

        #urlbar-background {
          border-radius: 8px !important;
          border: 1px solid var(--ctp-surface1) !important;
        }

        #urlbar:hover #urlbar-background,
        #urlbar[focused="true"] #urlbar-background {
          border-color: var(--ctp-mauve) !important;
        }

        /* === SIDEBAR === */
        #sidebar-box {
          background-color: var(--ctp-mantle) !important;
        }

        /* === FINDBAR === */
        findbar {
          background-color: var(--ctp-surface0) !important;
          border-radius: 8px 8px 0 0 !important;
        }

        /* === CONTEXT MENUS === */
        menupopup {
          --panel-background: var(--ctp-surface0) !important;
          --panel-color: var(--ctp-text) !important;
          --panel-border-color: var(--ctp-surface1) !important;
          border-radius: 8px !important;
        }

        menuitem:hover,
        menu:hover {
          background-color: var(--ctp-surface1) !important;
        }

        /* === SCROLLBAR === */
        * {
          scrollbar-color: var(--ctp-surface2) var(--ctp-base) !important;
          scrollbar-width: thin !important;
        }

        /* === HIDE ELEMENTS (optional - uncomment to enable) === */
        /* 
        #alltabs-button { display: none !important; }
        .titlebar-spacer { display: none !important; }
        */
      '';

      userContent = ''
        /* ==========================================================================
           FIREFOX USERCONTENT - Style internal pages
           ========================================================================== */

        @-moz-document url("about:home"), url("about:newtab") {
          body {
            background-color: #1e1e2e !important;
          }
          
          .search-wrapper .search-inner-wrapper {
            background-color: #313244 !important;
            border-radius: 12px !important;
          }
          
          .search-wrapper .search-inner-wrapper:hover,
          .search-wrapper .search-inner-wrapper:focus-within {
            border-color: #cba6f7 !important;
          }
        }

        @-moz-document url-prefix("about:") {
          :root {
            --in-content-page-background: #1e1e2e !important;
            --in-content-page-color: #cdd6f4 !important;
            --in-content-box-background: #313244 !important;
            --in-content-box-border-color: #45475a !important;
            --in-content-primary-button-background: #cba6f7 !important;
            --in-content-primary-button-background-hover: #b4befe !important;
            --in-content-focus-outline-color: #cba6f7 !important;
          }
        }
      '';

      # Extensions (if using firefox-addons input)
      # extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
      #   ublock-origin
      #   bitwarden
      #   darkreader
      #   vimium
      #   privacy-badger
      #   sponsorblock
      #   return-youtube-dislikes
      # ];
    };
  };
}
