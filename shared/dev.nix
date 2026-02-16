{
  config,
  pkgs,
  lib,
  ...
}:

{
  # ============================================================================
  # DEVELOPMENT (WSL) - CLI tools only, no GUI apps
  # ============================================================================

  home.packages = with pkgs; [
    # === LANGUAGES ===
    # Rust
    rustup
    cargo-watch
    cargo-edit
    cargo-audit
    cargo-outdated

    # Go
    go
    gopls
    golangci-lint
    delve

    # Python
    poetry
    pyright

    # Node.js
    nodejs_22
    bun
    deno
    pnpm
    yarn

    # C/C++
    gcc
    cmake
    gnumake

    # Zig
    zig

    # Haskell
    ghc
    cabal-install
    stack
    haskell-language-server

    # === NATIVE BUILD DEPENDENCIES ===
    pkg-config
    zlib
    zlib.dev
    postgresql_16
    postgresql_16.dev
    openssl
    openssl.dev
    libffi
    libffi.dev

    # Elixir
    elixir

    # Java/Kotlin
    jdk21
    gradle
    kotlin
    kotlin-language-server

    # === DATABASES (CLI only) ===
    sqlite
    redis
    mariadb
    # dbeaver-bin  # GUI - not for WSL

    # Database CLIs
    pgcli
    litecli
    mycli

    # === API TOOLS (CLI only) ===
    httpie
    xh
    curlie
    grpcurl
    # postman     # GUI - not for WSL
    # insomnia    # GUI - not for WSL

    # === JSON/YAML ===
    jq
    yq
    fx
    jless

    # === DEBUGGING ===
    lldb
    valgrind
    strace
    ltrace

    # === PROFILING ===
    heaptrack
    perf-tools
    hyperfine

    # === BUILD TOOLS ===
    just
    go-task
    meson

    # === VERSION CONTROL ===
    git-lfs
    git-crypt
    pre-commit
    commitizen

    # === SECURITY ===
    trivy
    semgrep
    gitleaks

    # === DOCUMENTATION ===
    mdbook

    # === CLOUD CLIs ===
    awscli2
    google-cloud-sdk
    azure-cli
    doctl
    flyctl
    netlify-cli
    nodePackages.vercel

    # === MISC ===
    watchexec
    entr
    tokei
    cloc
    grex
    sd
    choose
    tealdeer
    navi
  ];

  # ============================================================================
  # NATIVE BUILD ENVIRONMENT
  # ============================================================================

  home.sessionVariables = {
    PKG_CONFIG_PATH = "$HOME/.nix-profile/lib/pkgconfig:$HOME/.nix-profile/share/pkgconfig";
    LIBRARY_PATH = "$HOME/.nix-profile/lib";
    C_INCLUDE_PATH = "$HOME/.nix-profile/include";
    CPLUS_INCLUDE_PATH = "$HOME/.nix-profile/include";
  };

  # ============================================================================
  # SHELL ALIASES
  # ============================================================================

  programs.bash.shellAliases = {
    j = "just";
    jl = "just --list";
    py = "python3";
    pip = "pip3";
    venv = "python3 -m venv";
    activate = "source .venv/bin/activate";
    pn = "pnpm";
    ni = "npm install";
    nr = "npm run";
    cb = "cargo build";
    cr = "cargo run";
    ct = "cargo test";
    cw = "cargo watch -x run";
    gr = "go run .";
    gb = "go build";
    gt = "go test ./...";
    pg = "pgcli";
    sql = "litecli";
    http = "xh";
    jqp = "jless";
    bench = "hyperfine";
    stats = "tokei";
    watch = "watchexec";
  };
}
