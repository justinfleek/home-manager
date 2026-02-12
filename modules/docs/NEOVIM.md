# Neovim (LazyVim)

```
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
```

Full IDE experience powered by LazyVim with LSP, completion, and more.

## Key Bindings

**Leader key: `Space`**

### Essential

| Key             | Action               |
| --------------- | -------------------- |
| `jk` or `kj`    | Escape (insert mode) |
| `Space`         | Leader key           |
| `Ctrl + S`      | Save file            |
| `Space + q + q` | Quit all             |

### File Navigation

| Key             | Action                      |
| --------------- | --------------------------- |
| `Space + e`     | File explorer (Neo-tree)    |
| `Space + f + f` | Find files                  |
| `Space + f + g` | Live grep (search in files) |
| `Space + f + r` | Recent files                |
| `Space + f + b` | Browse buffers              |
| `Space + Space` | Find files (root)           |
| `Space + /`     | Search in current buffer    |

### Buffers

| Key             | Action                |
| --------------- | --------------------- |
| `Shift + H`     | Previous buffer       |
| `Shift + L`     | Next buffer           |
| `Space + b + d` | Delete buffer         |
| `Space + b + D` | Delete buffer (force) |
| `Space + ,`     | Switch buffer         |

### Windows

| Key                 | Action                 |
| ------------------- | ---------------------- |
| `Space + w + w`     | Switch to other window |
| `Space + w + d`     | Delete window          |
| `Space + -`         | Split below            |
| `Space + \|`        | Split right            |
| `Ctrl + H/J/K/L`    | Navigate windows       |
| `Ctrl + Arrow Keys` | Resize windows         |

### Code Navigation

| Key        | Action                |
| ---------- | --------------------- |
| `g + d`    | Go to definition      |
| `g + D`    | Go to declaration     |
| `g + r`    | Go to references      |
| `g + I`    | Go to implementation  |
| `g + y`    | Go to type definition |
| `K`        | Hover documentation   |
| `Ctrl + K` | Signature help        |
| `] + d`    | Next diagnostic       |
| `[ + d`    | Previous diagnostic   |

### Code Actions

| Key             | Action           |
| --------------- | ---------------- |
| `Space + c + a` | Code action      |
| `Space + c + r` | Rename symbol    |
| `Space + c + f` | Format document  |
| `Space + c + d` | Line diagnostics |

### Search & Replace

| Key             | Action                       |
| --------------- | ---------------------------- |
| `Space + s + r` | Search & replace (Spectre)   |
| `Space + s + g` | Grep (search text)           |
| `Space + s + w` | Search word under cursor     |
| `n` / `N`       | Next/previous search result  |
| `*` / `#`       | Search word forward/backward |

### Git

| Key             | Action           |
| --------------- | ---------------- |
| `Space + g + g` | Lazygit          |
| `Space + g + b` | Git blame line   |
| `Space + g + B` | Git browse       |
| `Space + g + h` | Git hunk preview |
| `] + h`         | Next hunk        |
| `[ + h`         | Previous hunk    |
| `Space + g + s` | Stage hunk       |
| `Space + g + r` | Reset hunk       |

### Flash (Quick Navigation)

| Key       | Action           |
| --------- | ---------------- |
| `s`       | Flash jump       |
| `S`       | Flash treesitter |
| `f` / `F` | Flash find char  |
| `t` / `T` | Flash till char  |

### Folds

| Key     | Action          |
| ------- | --------------- |
| `z + c` | Close fold      |
| `z + o` | Open fold       |
| `z + a` | Toggle fold     |
| `z + M` | Close all folds |
| `z + R` | Open all folds  |

### Comments

| Key              | Action            |
| ---------------- | ----------------- |
| `g + c + c`      | Comment line      |
| `g + c` (visual) | Comment selection |
| `g + b + c`      | Block comment     |

### Surround (mini.surround)

| Key     | Action              |
| ------- | ------------------- |
| `s + a` | Add surrounding     |
| `s + d` | Delete surrounding  |
| `s + r` | Replace surrounding |

Examples:

- `sa"` on word → `"word"`
- `sd"` on `"word"` → `word`
- `sr"'` on `"word"` → `'word'`

### Completion

| Key                     | Action                     |
| ----------------------- | -------------------------- |
| `Ctrl + Space`          | Trigger completion         |
| `Ctrl + N` / `Ctrl + P` | Next/previous item         |
| `Ctrl + Y`              | Confirm selection          |
| `Ctrl + E`              | Abort completion           |
| `Tab`                   | Next item / expand snippet |
| `Shift + Tab`           | Previous item              |

### Miscellaneous

| Key             | Action                     |
| --------------- | -------------------------- |
| `Space + l`     | Lazy (plugin manager)      |
| `Space + x + x` | Trouble (diagnostics list) |
| `Space + u + c` | Toggle colorizer           |
| `Space + u + f` | Toggle format on save      |
| `Space + u + l` | Toggle line numbers        |
| `Space + u + w` | Toggle word wrap           |

## Features

### Language Support (LSP)

Pre-configured LSPs:

| Language              | Server                     |
| --------------------- | -------------------------- |
| Nix                   | nil                        |
| TypeScript/JavaScript | typescript-language-server |
| Lua                   | lua-language-server        |
| Python                | pyright                    |
| Rust                  | rust-analyzer              |
| Go                    | gopls                      |
| HTML/CSS/JSON         | vscode-langservers         |
| YAML                  | yaml-language-server       |
| TOML                  | taplo                      |
| Markdown              | marksman                   |
| Bash                  | bash-language-server       |

### Extras Enabled

- **Copilot**: AI completion (`Space + c + c` for chat)
- **Mini Surround**: Quick surround operations
- **Mini Files**: File explorer alternative
- **Telescope**: Fuzzy finder
- **Flash**: Quick navigation
- **Which Key**: Key binding hints

### UI Features

- **Dashboard**: Custom OpenCode ASCII art
- **Bufferline**: Tab-like buffer display
- **Lualine**: Status line with git info
- **Indent guides**: Visual indentation
- **Noice**: Better command line UI
- **Notify**: Beautiful notifications

## File Explorer (Neo-tree)

| Key     | Action              |
| ------- | ------------------- |
| `Enter` | Open file           |
| `a`     | Add file/directory  |
| `d`     | Delete              |
| `r`     | Rename              |
| `y`     | Copy to clipboard   |
| `x`     | Cut to clipboard    |
| `p`     | Paste               |
| `R`     | Refresh             |
| `H`     | Toggle hidden files |
| `?`     | Show help           |

## Tips

1. **Which Key**: Press `Space` and wait - see all available bindings
2. **Telescope live grep**: `Space + f + g` then type to search all files
3. **Flash jump**: Press `s`, type 2 chars, jump to label
4. **Lazygit integration**: `Space + g + g` for full git UI
5. **Format on save**: Enabled by default, toggle with `Space + u + f`

## Customization

### Add Plugins

Create `~/.config/nvim/lua/plugins/custom.lua`:

```lua
return {
  {
    "username/plugin-name",
    opts = {
      -- your config
    },
  },
}
```

### Change Colorscheme

Edit `modules/neovim.nix` → `plugins/colorscheme.lua`:

```lua
opts = {
  colorscheme = "catppuccin",  -- or "tokyonight", "gruvbox", etc.
},
```

### Add LSP

Edit the `extraPackages` in `modules/neovim.nix`:

```nix
extraPackages = with pkgs; [
  # Add your LSP here
  elixir-ls
  terraform-ls
];
```

## Troubleshooting

### Plugins not loading

```vim
:Lazy sync
:Lazy health
```

### LSP not working

```vim
:LspInfo
:LspLog
:checkhealth lsp
```

### Treesitter issues

```vim
:TSUpdate
:TSInstallInfo
```

### Mason packages

```vim
:Mason
```

### General health check

```vim
:checkhealth
```
