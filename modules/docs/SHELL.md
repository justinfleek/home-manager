# Shell (Bash + Starship + Atuin)

```
    ███████╗██╗  ██╗███████╗██╗     ██╗
    ██╔════╝██║  ██║██╔════╝██║     ██║
    ███████╗███████║█████╗  ██║     ██║
    ╚════██║██╔══██║██╔══╝  ██║     ██║
    ███████║██║  ██║███████╗███████╗███████╗
    ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
```

Powerful Bash setup with Starship prompt and Atuin shell history.

## Starship Prompt

Beautiful, informative prompt with Catppuccin colors:

```
┌─[  NixOS]─[  justin]─[  ~/projects]─[  main]─[  v18.0]─[  13:37]
└─❯
```

Shows:

- OS icon
- Username
- Directory (with icons for special dirs)
- Git branch + status
- Language version (Node, Rust, Python, Go)
- Docker context
- Time

## Vi Mode

The shell uses vi mode! The cursor changes based on mode:

| Mode   | Cursor       |
| ------ | ------------ |
| Insert | Thin bar `│` |
| Normal | Block `█`    |

### Vi Mode Keys

| Key      | Action                |
| -------- | --------------------- |
| `Escape` | Normal mode           |
| `i`      | Insert mode           |
| `a`      | Insert after cursor   |
| `A`      | Insert at end of line |
| `0`      | Beginning of line     |
| `$`      | End of line           |
| `w`      | Next word             |
| `b`      | Previous word         |
| `dd`     | Delete line           |
| `dw`     | Delete word           |
| `u`      | Undo                  |

### Insert Mode Shortcuts

| Key        | Action               |
| ---------- | -------------------- |
| `Ctrl + L` | Clear screen         |
| `Ctrl + A` | Beginning of line    |
| `Ctrl + E` | End of line          |
| `Ctrl + W` | Delete word backward |

## Atuin (Shell History)

Magical shell history with fuzzy search.

| Key          | Action                     |
| ------------ | -------------------------- |
| `Ctrl + R`   | Search history             |
| `Up Arrow`   | Previous command (session) |
| `Down Arrow` | Next command               |

### In History Search

| Key        | Action                     |
| ---------- | -------------------------- |
| `Enter`    | Execute command            |
| `Tab`      | Copy to input (edit first) |
| `Ctrl + C` | Cancel                     |
| `Ctrl + D` | Delete entry               |
| Up/Down    | Navigate results           |

### Features

- **Fuzzy search**: Type any part of command
- **Preview**: See full command before running
- **Session filter**: Up arrow shows current session only
- **50,000 lines**: Huge scrollback

## FZF Integration

| Key        | Action           |
| ---------- | ---------------- |
| `Ctrl + T` | Find files       |
| `Alt + C`  | Change directory |
| `Ctrl + R` | History (Atuin)  |
| `**<Tab>`  | Fuzzy completion |

### FZF Completion Examples

```bash
# Fuzzy cd
cd **<Tab>

# Fuzzy vim
vim **<Tab>

# Kill process
kill -9 **<Tab>

# SSH
ssh **<Tab>
```

## Aliases

### Navigation

| Alias  | Command       |
| ------ | ------------- |
| `..`   | `cd ..`       |
| `...`  | `cd ../..`    |
| `....` | `cd ../../..` |
| `~`    | `cd ~`        |

### Listing (eza)

| Alias | Command                |
| ----- | ---------------------- |
| `ls`  | `eza --icons`          |
| `ll`  | `eza -la --icons`      |
| `la`  | `eza -a --icons`       |
| `lt`  | `eza --tree --level=2` |
| `lta` | `eza --tree -a`        |

### Cat (bat)

| Alias  | Command                   |
| ------ | ------------------------- |
| `cat`  | `bat --style=plain`       |
| `catp` | `bat` (with line numbers) |

### Git

| Alias  | Command                   |
| ------ | ------------------------- |
| `g`    | `git`                     |
| `ga`   | `git add`                 |
| `gaa`  | `git add --all`           |
| `gc`   | `git commit`              |
| `gcm`  | `git commit -m`           |
| `gco`  | `git checkout`            |
| `gd`   | `git diff`                |
| `gds`  | `git diff --staged`       |
| `gl`   | `git log --oneline -10`   |
| `gla`  | `git log --oneline --all` |
| `gp`   | `git push`                |
| `gpl`  | `git pull`                |
| `gs`   | `git status -sb`          |
| `gst`  | `git stash`               |
| `gstp` | `git stash pop`           |
| `lg`   | `lazygit`                 |

### Nix

| Alias | Command                                |
| ----- | -------------------------------------- |
| `nrs` | `sudo nixos-rebuild switch --flake .#` |
| `nrb` | `sudo nixos-rebuild boot --flake .#`   |
| `hms` | `home-manager switch --flake .#`       |
| `nfu` | `nix flake update`                     |
| `nfc` | `nix flake check`                      |
| `nsp` | `nix-shell -p`                         |
| `nrp` | `nix run nixpkgs#`                     |
| `ngc` | `nix-collect-garbage -d`               |
| `nso` | `nix store optimise`                   |

### System

| Alias  | Command          |
| ------ | ---------------- |
| `df`   | `df -h`          |
| `du`   | `du -h`          |
| `free` | `free -h`        |
| `psg`  | `ps aux \| grep` |

### Editors

| Alias | Command |
| ----- | ------- |
| `v`   | `nvim`  |
| `vi`  | `nvim`  |
| `vim` | `nvim`  |

### Utilities

| Alias     | Command            |
| --------- | ------------------ |
| `c`       | `clear`            |
| `q`       | `exit`             |
| `ff`      | `fastfetch`        |
| `fetch`   | `fastfetch`        |
| `weather` | `curl wttr.in`     |
| `pubip`   | `curl ifconfig.me` |
| `please`  | `sudo`             |
| `fuck`    | `sudo !!`          |
| `oc`      | `opencode`         |

### Tmux

| Alias | Command                |
| ----- | ---------------------- |
| `t`   | `tmux`                 |
| `ta`  | `tmux attach -t`       |
| `tl`  | `tmux list-sessions`   |
| `tn`  | `tmux new -s`          |
| `tk`  | `tmux kill-session -t` |

## Functions

### mkcd - Create and enter directory

```bash
mkcd my-new-project
# Creates directory and cd into it
```

### extract - Universal archive extraction

```bash
extract archive.tar.gz
extract file.zip
extract package.7z
# Handles: tar, gz, bz2, xz, zip, rar, 7z
```

### fcd - Fuzzy cd

```bash
fcd
# Opens fzf to select directory
```

### fe - Fuzzy edit

```bash
fe
# Opens fzf to select file, opens in $EDITOR
```

### fkill - Fuzzy kill

```bash
fkill
# Opens fzf to select process to kill
```

### fbr - Fuzzy git branch

```bash
fbr
# Opens fzf to select and checkout branch
```

### serve - Quick HTTP server

```bash
serve        # Port 8000
serve 3000   # Custom port
```

### note - Quick notes

```bash
note           # Opens today's note
note meeting   # Opens meeting.md
```

### countdown - Timer

```bash
countdown 60   # 60 second timer
countdown 300  # 5 minute timer
# Sends notification when done
```

### calc - Quick calculator

```bash
calc 2 + 2
calc "100 / 4"
calc "sqrt(144)"
```

### ndev - Nix develop with direnv

```bash
cd my-project
ndev
# Creates .envrc and enables direnv
```

## Zoxide (Smart cd)

| Command  | Action                   |
| -------- | ------------------------ |
| `cd foo` | Normal cd OR zoxide jump |
| `cd -`   | Previous directory       |
| `z foo`  | Jump to best match       |
| `zi foo` | Interactive selection    |

### How it works

Zoxide learns your directories. The more you visit a path, the higher it ranks:

```bash
z proj    # Jumps to ~/projects if you go there often
z dow     # Jumps to ~/Downloads
z conf    # Jumps to ~/.config
```

## Tips

1. **Check last command**: `echo $?` shows exit code
2. **Repeat last arg**: `$_` or `!$`
3. **Run previous command**: `!!`
4. **Run with sudo**: `sudo !!`
5. **Edit in editor**: `Ctrl+X Ctrl+E`
6. **Quick substitution**: `^old^new` runs last command replacing old with new

## Environment Variables

```bash
EDITOR=nvim
VISUAL=nvim
TERMINAL=ghostty
BROWSER=firefox
```

## Customization

### Add Aliases

Edit `modules/shell.nix`:

```nix
shellAliases = {
  myalias = "my command";
};
```

### Add Functions

```nix
initExtra = ''
  myfunction() {
    echo "Hello $1"
  }
'';
```

### Change Prompt

Edit Starship settings in `modules/shell.nix` → `programs.starship.settings`.
