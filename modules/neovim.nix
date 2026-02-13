{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  # ============================================================================
  # NEOVIM - LazyVim-based IDE experience
  # Full LSP, completion, treesitter, and all the goodies
  # ============================================================================

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Extra packages available to neovim
    extraPackages = with pkgs; [
      # Core utils
      ripgrep
      fd
      fzf

      # Language servers
      nil # Nix
      nixfmt # Nix formatter (was nixfmt-rfc-style)
      lua-language-server # Lua
      stylua # Lua formatter
      nodePackages.typescript-language-server # TS/JS
      nodePackages.prettier # JS/TS formatter
      # nodePackages.eslint                  # Conflicts - use npx eslint or biome
      vscode-langservers-extracted # HTML/CSS/JSON
      marksman # Markdown
      taplo # TOML
      yaml-language-server # YAML
      bash-language-server # Bash
      pyright # Python
      ruff # Python linter/formatter
      gopls # Go
      rust-analyzer # Rust

      # Misc tools
      tree-sitter
      gcc # For treesitter compilation
      gnumake
    ];
  };

  # LazyVim configuration
  # We bootstrap lazy.nvim and LazyVim starter
  xdg.configFile = {
    # Main init.lua - bootstraps lazy.nvim
    "nvim/init.lua".text = ''
      -- ==========================================================================
      -- NEOVIM CONFIG - LazyVim Based
      -- Hypermodern IDE experience
      -- ==========================================================================

      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
          vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
          }, true, {})
          vim.fn.getchar()
          os.exit(1)
        end
      end
      vim.opt.rtp:prepend(lazypath)

      -- Make sure to setup `mapleader` and `maplocalleader` before
      -- loading lazy.nvim so that mappings are correct.
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"

      -- Setup lazy.nvim
      require("lazy").setup({
        spec = {
          -- Import LazyVim and its plugins
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },

          -- Import extras (language packs, tools, etc.)
          { import = "lazyvim.plugins.extras.lang.typescript" },
          { import = "lazyvim.plugins.extras.lang.json" },
          { import = "lazyvim.plugins.extras.lang.markdown" },
          { import = "lazyvim.plugins.extras.lang.python" },
          { import = "lazyvim.plugins.extras.lang.rust" },
          { import = "lazyvim.plugins.extras.lang.go" },
          { import = "lazyvim.plugins.extras.lang.nix" },
          { import = "lazyvim.plugins.extras.lang.toml" },
          { import = "lazyvim.plugins.extras.lang.yaml" },
          
          -- Coding extras
          { import = "lazyvim.plugins.extras.coding.copilot" },
          { import = "lazyvim.plugins.extras.coding.copilot-chat" },
          { import = "lazyvim.plugins.extras.coding.mini-surround" },
          
          -- Editor extras
          { import = "lazyvim.plugins.extras.editor.mini-files" },
          { import = "lazyvim.plugins.extras.editor.telescope" },
          
          -- UI extras
          { import = "lazyvim.plugins.extras.ui.mini-animate" },

          -- Your custom plugins
          { import = "plugins" },
        },
        defaults = {
          lazy = false,
          version = false,
        },
        install = { colorscheme = { "catppuccin", "habamax" } },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })
    '';

    # Custom options
    "nvim/lua/config/options.lua".text = ''
      -- ==========================================================================
      -- OPTIONS
      -- ==========================================================================
      local opt = vim.opt

      -- General
      opt.autowrite = true
      opt.clipboard = "unnamedplus"
      opt.completeopt = "menu,menuone,noselect"
      opt.conceallevel = 2
      opt.confirm = true
      opt.cursorline = true
      opt.expandtab = true
      opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
      opt.foldlevel = 99
      opt.formatoptions = "jcroqlnt"
      opt.grepformat = "%f:%l:%c:%m"
      opt.grepprg = "rg --vimgrep"
      opt.ignorecase = true
      opt.inccommand = "nosplit"
      opt.laststatus = 3
      opt.list = true
      opt.mouse = "a"
      opt.number = true
      opt.pumblend = 10
      opt.pumheight = 10
      opt.relativenumber = true
      opt.scrolloff = 8
      opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
      opt.shiftround = true
      opt.shiftwidth = 2
      opt.shortmess:append({ W = true, I = true, c = true, C = true })
      opt.showmode = false
      opt.sidescrolloff = 8
      opt.signcolumn = "yes"
      opt.smartcase = true
      opt.smartindent = true
      opt.spelllang = { "en" }
      opt.splitbelow = true
      opt.splitkeep = "screen"
      opt.splitright = true
      opt.tabstop = 2
      opt.termguicolors = true
      opt.timeoutlen = 300
      opt.undofile = true
      opt.undolevels = 10000
      opt.updatetime = 200
      opt.virtualedit = "block"
      opt.wildmode = "longest:full,full"
      opt.winminwidth = 5
      opt.wrap = false

      -- Fix markdown indentation settings
      vim.g.markdown_recommended_style = 0
    '';

    # Custom keymaps
    "nvim/lua/config/keymaps.lua".text = ''
      -- ==========================================================================
      -- KEYMAPS
      -- ==========================================================================
      local map = vim.keymap.set

      -- Better escape
      map("i", "jk", "<Esc>", { desc = "Escape" })
      map("i", "kj", "<Esc>", { desc = "Escape" })

      -- Better up/down
      map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
      map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

      -- Move lines
      map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
      map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
      map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
      map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
      map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
      map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

      -- Buffers
      map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
      map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
      map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
      map("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Delete buffer (force)" })

      -- Clear search
      map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

      -- Better indenting
      map("v", "<", "<gv")
      map("v", ">", ">gv")

      -- Save file
      map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

      -- Quit
      map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

      -- Windows
      map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
      map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
      map("n", "<leader>-", "<C-W>s", { desc = "Split below" })
      map("n", "<leader>|", "<C-W>v", { desc = "Split right" })

      -- Resize window using <ctrl> arrow keys
      map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
      map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
      map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
      map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

      -- Lazy
      map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

      -- Center after jumping
      map("n", "<C-d>", "<C-d>zz")
      map("n", "<C-u>", "<C-u>zz")
      map("n", "n", "nzzzv")
      map("n", "N", "Nzzzv")

      -- Don't yank on paste in visual mode
      map("x", "p", [["_dP]])

      -- Diagnostic
      map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
      map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
    '';

    # Autocommands
    "nvim/lua/config/autocmds.lua".text = ''
      -- ==========================================================================
      -- AUTOCOMMANDS
      -- ==========================================================================
      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

      -- Highlight on yank
      autocmd("TextYankPost", {
        group = augroup("highlight_yank", { clear = true }),
        callback = function()
          vim.highlight.on_yank({ timeout = 200 })
        end,
      })

      -- Resize splits on window resize
      autocmd("VimResized", {
        group = augroup("resize_splits", { clear = true }),
        callback = function()
          local current_tab = vim.fn.tabpagenr()
          vim.cmd("tabdo wincmd =")
          vim.cmd("tabnext " .. current_tab)
        end,
      })

      -- Go to last location when opening a buffer
      autocmd("BufReadPost", {
        group = augroup("last_loc", { clear = true }),
        callback = function(event)
          local exclude = { "gitcommit" }
          local buf = event.buf
          if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
          end
          vim.b[buf].lazyvim_last_loc = true
          local mark = vim.api.nvim_buf_get_mark(buf, '"')
          local lcount = vim.api.nvim_buf_line_count(buf)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end,
      })

      -- Close some filetypes with <q>
      autocmd("FileType", {
        group = augroup("close_with_q", { clear = true }),
        pattern = {
          "PlenaryTestPopup",
          "help",
          "lspinfo",
          "notify",
          "qf",
          "spectre_panel",
          "startuptime",
          "tsplayground",
          "neotest-output",
          "checkhealth",
          "neotest-summary",
          "neotest-output-panel",
        },
        callback = function(event)
          vim.bo[event.buf].buflisted = false
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end,
      })

      -- Auto create dir when saving a file
      autocmd("BufWritePre", {
        group = augroup("auto_create_dir", { clear = true }),
        callback = function(event)
          if event.match:match("^%w%w+://") then
            return
          end
          local file = vim.uv.fs_realpath(event.match) or event.match
          vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end,
      })

      -- Wrap and check for spell in text filetypes
      autocmd("FileType", {
        group = augroup("wrap_spell", { clear = true }),
        pattern = { "gitcommit", "markdown" },
        callback = function()
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end,
      })
    '';

    # Custom plugins
    "nvim/lua/plugins/colorscheme.lua".text = ''
      return {
        -- Catppuccin colorscheme
        {
          "catppuccin/nvim",
          name = "catppuccin",
          lazy = false,
          priority = 1000,
          opts = {
            flavour = "mocha",
            background = {
              light = "latte",
              dark = "mocha",
            },
            transparent_background = true,
            show_end_of_buffer = false,
            term_colors = true,
            dim_inactive = {
              enabled = false,
            },
            styles = {
              comments = { "italic" },
              conditionals = { "italic" },
              loops = {},
              functions = { "bold" },
              keywords = { "italic" },
              strings = {},
              variables = {},
              numbers = {},
              booleans = { "bold" },
              properties = {},
              types = { "bold" },
              operators = {},
            },
            integrations = {
              alpha = true,
              cmp = true,
              flash = true,
              gitsigns = true,
              illuminate = true,
              indent_blankline = { enabled = true },
              lsp_trouble = true,
              mason = true,
              mini = true,
              native_lsp = {
                enabled = true,
                underlines = {
                  errors = { "undercurl" },
                  hints = { "undercurl" },
                  warnings = { "undercurl" },
                  information = { "undercurl" },
                },
              },
              navic = { enabled = true, custom_bg = "lualine" },
              neotest = true,
              noice = true,
              notify = true,
              nvimtree = true,
              semantic_tokens = true,
              telescope = true,
              treesitter = true,
              which_key = true,
            },
          },
        },

        -- Set colorscheme
        {
          "LazyVim/LazyVim",
          opts = {
            colorscheme = "catppuccin",
          },
        },
      }
    '';

    "nvim/lua/plugins/ui.lua".text = ''
        return {
          -- Dashboard
          {
            "nvimdev/dashboard-nvim",
            opts = function(_, opts)
              local logo = [[
       ██████╗ ██████╗ ███████╗███╗   ██╗ ██████╗ ██████╗ ██████╗ ███████╗
      ██╔═══██╗██╔══██╗██╔════╝████╗  ██║██╔════╝██╔═══██╗██╔══██╗██╔════╝
      ██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║     ██║   ██║██║  ██║█████╗  
      ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██║     ██║   ██║██║  ██║██╔══╝  
      ╚██████╔╝██║     ███████╗██║ ╚████║╚██████╗╚██████╔╝██████╔╝███████╗
       ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
              ]]
              logo = string.rep("\n", 4) .. logo .. "\n\n"
              opts.config.header = vim.split(logo, "\n")
            end,
          },

          -- Noice (cmdline, notifications, etc)
          {
            "folke/noice.nvim",
            opts = {
              presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
              },
            },
          },

          -- Bufferline
          {
            "akinsho/bufferline.nvim",
            opts = {
              options = {
                mode = "buffers",
                separator_style = "thin",
                show_buffer_close_icons = true,
                show_close_icon = false,
                diagnostics = "nvim_lsp",
                always_show_bufferline = true,
                indicator = {
                  style = "underline",
                },
              },
            },
          },

          -- Lualine
          {
            "nvim-lualine/lualine.nvim",
            opts = function(_, opts)
              opts.options = {
                theme = "catppuccin",
                globalstatus = true,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
              }
            end,
          },

          -- Indent guides
          {
            "lukas-reineke/indent-blankline.nvim",
            opts = {
              indent = {
                char = "│",
                tab_char = "│",
              },
              scope = { enabled = true },
              exclude = {
                filetypes = {
                  "help",
                  "alpha",
                  "dashboard",
                  "neo-tree",
                  "Trouble",
                  "lazy",
                  "mason",
                  "notify",
                  "toggleterm",
                  "lazyterm",
                },
              },
            },
          },
        }
    '';

    "nvim/lua/plugins/coding.lua".text = ''
      return {
        -- Better comments
        {
          "folke/todo-comments.nvim",
          opts = {
            signs = true,
            keywords = {
              FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
              TODO = { icon = " ", color = "info" },
              HACK = { icon = " ", color = "warning" },
              WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
              PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
              NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            },
          },
        },

        -- Better diagnostics
        {
          "folke/trouble.nvim",
          opts = {
            use_diagnostic_signs = true,
          },
        },

        -- Git signs
        {
          "lewis6991/gitsigns.nvim",
          opts = {
            signs = {
              add = { text = "▎" },
              change = { text = "▎" },
              delete = { text = "" },
              topdelete = { text = "" },
              changedelete = { text = "▎" },
              untracked = { text = "▎" },
            },
            current_line_blame = true,
            current_line_blame_opts = {
              virt_text = true,
              virt_text_pos = "eol",
              delay = 200,
            },
          },
        },

        -- Autopairs
        {
          "windwp/nvim-autopairs",
          event = "InsertEnter",
          opts = {
            check_ts = true,
            fast_wrap = {
              map = "<M-e>",
              chars = { "{", "[", "(", '"', "'" },
              pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
              offset = 0,
              end_key = "$",
              keys = "qwertyuiopzxcvbnmasdfghjkl",
              check_comma = true,
              highlight = "PmenuSel",
              highlight_grey = "LineNr",
            },
          },
        },
      }
    '';

    "nvim/lua/plugins/editor.lua".text = ''
      return {
        -- File explorer
        {
          "nvim-neo-tree/neo-tree.nvim",
          opts = {
            filesystem = {
              filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
              },
              follow_current_file = {
                enabled = true,
              },
            },
            window = {
              width = 35,
              mappings = {
                ["<space>"] = "none",
              },
            },
            default_component_configs = {
              indent = {
                with_expanders = true,
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
              },
            },
          },
        },

        -- Telescope
        {
          "nvim-telescope/telescope.nvim",
          opts = {
            defaults = {
              prompt_prefix = "   ",
              selection_caret = "  ",
              entry_prefix = "  ",
              layout_strategy = "horizontal",
              layout_config = {
                horizontal = {
                  prompt_position = "top",
                  preview_width = 0.55,
                },
                width = 0.87,
                height = 0.80,
              },
              sorting_strategy = "ascending",
              winblend = 0,
            },
          },
        },

        -- Flash (better motions)
        {
          "folke/flash.nvim",
          opts = {
            labels = "asdfghjklqwertyuiopzxcvbnm",
            modes = {
              char = {
                jump_labels = true,
              },
            },
          },
        },

        -- Which-key
        {
          "folke/which-key.nvim",
          opts = {
            preset = "modern",
            delay = 300,
          },
        },
      }
    '';

    "nvim/lua/plugins/lsp.lua".text = ''
      return {
        -- Mason
        {
          "williamboman/mason.nvim",
          opts = {
            ui = {
              border = "rounded",
              icons = {
                package_installed = "",
                package_pending = "",
                package_uninstalled = "",
              },
            },
          },
        },

        -- LSP Config
        {
          "neovim/nvim-lspconfig",
          opts = {
            inlay_hints = {
              enabled = true,
            },
            codelens = {
              enabled = true,
            },
            diagnostics = {
              underline = true,
              update_in_insert = false,
              virtual_text = {
                spacing = 4,
                source = "if_many",
                prefix = "●",
              },
              severity_sort = true,
            },
          },
        },

        -- Better completion
        {
          "hrsh7th/nvim-cmp",
          opts = function(_, opts)
            local cmp = require("cmp")
            opts.window = {
              completion = cmp.config.window.bordered({
                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
              }),
              documentation = cmp.config.window.bordered({
                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
              }),
            }
            opts.experimental = {
              ghost_text = true,
            }
          end,
        },
      }
    '';
  };
}
