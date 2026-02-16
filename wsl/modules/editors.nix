{
  config,
  pkgs,
  lib,
  ...
}:

{
  # ============================================================================
  # EDITORS (WSL) - CLI editors only, no GUI (neovide)
  # ============================================================================

  home.packages = with pkgs; [
    # No neovide - it's a GUI app
  ];

  # ============================================================================
  # HELIX - Terminal modal editor
  # ============================================================================

  programs.helix = {
    enable = true;
    defaultEditor = false;

    settings = {
      editor = {
        line-number = "relative";
        cursorline = true;
        cursorcolumn = false;
        gutters = [
          "diagnostics"
          "spacer"
          "line-numbers"
          "spacer"
          "diff"
        ];
        auto-pairs = true;
        auto-completion = true;
        auto-format = true;
        auto-save = true;
        idle-timeout = 50;
        completion-timeout = 5;
        preview-completion-insert = true;
        completion-trigger-len = 1;
        scroll-lines = 3;
        scrolloff = 8;
        shell = [
          "bash"
          "-c"
        ];
        mouse = true;
        middle-click-paste = true;
        bufferline = "multiple";
        color-modes = true;
        true-color = true;
        rulers = [
          80
          120
        ];

        whitespace = {
          render = {
            space = "none";
            tab = "all";
            nbsp = "all";
            newline = "none";
          };
          characters = {
            space = "·";
            nbsp = "⍽";
            tab = "→";
            newline = "⏎";
          };
        };

        indent-guides = {
          render = true;
          character = "▏";
          skip-levels = 1;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
          follow-symlinks = true;
          deduplicate-links = true;
          parents = true;
          ignore = true;
          git-ignore = true;
          git-global = true;
          git-exclude = true;
        };

        lsp = {
          enable = true;
          display-messages = true;
          auto-signature-help = true;
          display-inlay-hints = true;
          display-signature-help-docs = true;
          snippets = true;
          goto-reference-include-declaration = true;
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "file-modification-indicator"
          ];
          center = [ ];
          right = [
            "diagnostics"
            "selections"
            "register"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          separator = "│";
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "error";
        };

        soft-wrap = {
          enable = true;
          max-wrap = 25;
          max-indent-retain = 0;
          wrap-indicator = "↪ ";
        };
      };

      keys = {
        normal = {
          space = {
            f = {
              f = "file_picker";
              g = "global_search";
              b = "buffer_picker";
              s = "symbol_picker";
              S = "workspace_symbol_picker";
              d = "diagnostics_picker";
              D = "workspace_diagnostics_picker";
              r = "file_picker_in_current_directory";
            };
            w = {
              s = "hsplit";
              v = "vsplit";
              q = "wclose";
              w = "rotate_view";
              h = "jump_view_left";
              j = "jump_view_down";
              k = "jump_view_up";
              l = "jump_view_right";
            };
            b = {
              b = "buffer_picker";
              n = "goto_next_buffer";
              p = "goto_previous_buffer";
              d = "buffer_close";
              D = "buffer_close_others";
            };
            g = {
              d = "goto_definition";
              D = "goto_declaration";
              r = "goto_reference";
              i = "goto_implementation";
              t = "goto_type_definition";
            };
            c = {
              a = "code_action";
              r = "rename_symbol";
              f = "format_selections";
            };
            "/" = "global_search";
            "?" = "command_palette";
          };

          "C-h" = "jump_view_left";
          "C-j" = "jump_view_down";
          "C-k" = "jump_view_up";
          "C-l" = "jump_view_right";
          "C-d" = [
            "half_page_down"
            "align_view_center"
          ];
          "C-u" = [
            "half_page_up"
            "align_view_center"
          ];
          "n" = [
            "search_next"
            "align_view_center"
          ];
          "N" = [
            "search_prev"
            "align_view_center"
          ];
          "esc" = [
            "collapse_selection"
            "keep_primary_selection"
          ];
          "C-s" = ":w";
          "Z" = {
            "Z" = ":wq";
            "Q" = ":q!";
          };
        };

        insert = {
          "C-s" = ":w";
          "C-space" = "completion";
          "j" = {
            "k" = "normal_mode";
          };
        };

        select = {
          "C-h" = "jump_view_left";
          "C-j" = "jump_view_down";
          "C-k" = "jump_view_up";
          "C-l" = "jump_view_right";
        };
      };
    };

    languages = {
      language-server = {
        nil = {
          command = "nil";
        };
        rust-analyzer = {
          command = "rust-analyzer";
          config = {
            checkOnSave.command = "clippy";
            cargo.allFeatures = true;
            procMacro.enable = true;
          };
        };
        typescript-language-server = {
          command = "typescript-language-server";
          args = [ "--stdio" ];
        };
        pyright = {
          command = "pyright-langserver";
          args = [ "--stdio" ];
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "nixfmt";
        }
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "typescript";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "typescript"
            ];
          };
        }
        {
          name = "javascript";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "javascript"
            ];
          };
        }
        {
          name = "python";
          auto-format = true;
          formatter.command = "ruff";
          formatter.args = [
            "format"
            "-"
          ];
        }
        {
          name = "go";
          auto-format = true;
        }
        {
          name = "lua";
          auto-format = true;
          formatter.command = "stylua";
          formatter.args = [ "-" ];
        }
        {
          name = "markdown";
          auto-format = true;
          soft-wrap.enable = true;
        }
      ];
    };
  };

  programs.bash.shellAliases = {
    hx = "helix";
  };
}
