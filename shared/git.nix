{
  config,
  pkgs,
  lib,
  username,
  ...
}:

{
  # ============================================================================
  # GIT - Version control with delta diff viewer
  # ============================================================================

  programs.git = {
    enable = true;

    # All settings now go under 'settings' (replaces extraConfig, userName, userEmail)
    settings = {
      user = {
        name = "justinfleek";
        email = "justinfleek@users.noreply.github.com";
      };

      init.defaultBranch = "main";

      core = {
        editor = "nvim";
        autocrlf = "input";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        pager = "delta";
      };

      interactive.diffFilter = "delta --color-only --features=interactive";

      delta = {
        navigate = true;
        dark = true;
        line-numbers = true;
        side-by-side = false;
      };

      merge = {
        conflictstyle = "diff3";
        tool = "nvim";
      };

      diff.colorMoved = "default";

      pull = {
        rebase = true;
        ff = "only";
      };

      push = {
        default = "current";
        autoSetupRemote = true;
        followTags = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
      };

      rebase = {
        autoStash = true;
        autoSquash = true;
      };

      rerere.enabled = true;

      # Aliases
      alias = {
        # Status
        s = "status -sb";
        st = "status";

        # Logging
        lg = "log --oneline --graph --decorate -10";
        lga = "log --oneline --graph --decorate --all";
        ll = "log --pretty=format:'%C(magenta)%h%C(reset) - %C(cyan)%an%C(reset) %C(green)(%ar)%C(reset)%C(auto)%d%C(reset)%n  %s' --graph";

        # Branching
        br = "branch";
        bra = "branch -a";
        brd = "branch -d";
        brD = "branch -D";
        co = "checkout";
        cob = "checkout -b";

        # Committing
        ci = "commit";
        cm = "commit -m";
        ca = "commit --amend";
        can = "commit --amend --no-edit";

        # Adding
        a = "add";
        aa = "add --all";
        ap = "add --patch";

        # Diffing
        d = "diff";
        ds = "diff --staged";
        dw = "diff --word-diff";

        # Stashing
        stl = "stash list";
        stp = "stash pop";
        sts = "stash show -p";
        std = "stash drop";

        # Reset
        unstage = "reset HEAD --";
        undo = "reset --soft HEAD~1";
        nuke = "reset --hard HEAD";

        # Remote
        rv = "remote -v";

        # Utils
        aliases = "config --get-regexp ^alias\\.";
        root = "rev-parse --show-toplevel";
        whoami = "config user.email";
        contributors = "shortlog --summary --numbered";

        # Interactive
        ri = "rebase -i";
        rc = "rebase --continue";
        ra = "rebase --abort";

        # Work in progress
        wip = "!git add -A && git commit -m 'WIP'";
        unwip = "reset HEAD~1";

        # Sync
        sync = "!git pull --rebase && git push";

        # Clean merged branches
        cleanup = "!git branch --merged | grep -v '\\*\\|main\\|master\\|dev' | xargs -n 1 git branch -d";
      };

      # URL rewrites
      url = {
        "git@github.com:" = {
          insteadOf = "gh:";
          pushInsteadOf = "https://github.com/";
        };
        "git@gitlab.com:" = {
          insteadOf = "gl:";
          pushInsteadOf = "https://gitlab.com/";
        };
      };

      # Colors
      color = {
        ui = true;
        branch = {
          current = "magenta bold";
          local = "blue";
          remote = "green";
        };
        status = {
          added = "green";
          changed = "yellow";
          untracked = "red";
        };
      };

      # Credential
      credential.helper = "store";
    }; # end settings

    # Global gitignore
    ignores = [
      # OS
      ".DS_Store"
      "Thumbs.db"
      "*~"
      "*.swp"
      "*.swo"

      # IDEs
      ".idea/"
      ".vscode/"
      "*.sublime-*"
      ".project"
      ".classpath"
      ".settings/"

      # Build
      "node_modules/"
      "target/"
      "dist/"
      "build/"
      "*.pyc"
      "__pycache__/"
      ".cache/"

      # Environment
      ".env"
      ".env.local"
      ".env.*.local"
      "*.env"

      # Nix
      "result"
      "result-*"
      ".direnv/"

      # Logs
      "*.log"
      "logs/"

      # Misc
      ".todo"
      "*.bak"
      "*.tmp"
    ];
  };

  # GitHub CLI
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      editor = "nvim";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
        pc = "pr create";
        pl = "pr list";
        rv = "repo view";
        rc = "repo clone";
      };
    };
  };
}
