{
  config,
  pkgs,
  lib,
  ...
}:

{
  # ============================================================================
  # WEB DEVELOPMENT (WSL) - CLI tools only, no browsers/GUI
  # ============================================================================

  home.packages = with pkgs; [
    # ==========================================================================
    # DATABASES
    # ==========================================================================

    postgresql_16
    pgcli
    pgformatter
    pg_activity
    duckdb
    sqlite
    litecli
    redis
    usql
    dbmate
    sqlfluff

    # ==========================================================================
    # WEBASSEMBLY & WEBGL
    # ==========================================================================

    wasmtime
    wasm-pack
    wasm-bindgen-cli
    binaryen
    wabt
    emscripten
    cargo-wasi
    trunk
    glslang
    shaderc
    spirv-tools

    # ==========================================================================
    # JAVASCRIPT/TYPESCRIPT
    # ==========================================================================

    nodejs_22
    bun
    deno
    nodePackages.pnpm
    yarn

    # ==========================================================================
    # CSS & STYLING
    # ==========================================================================

    nodePackages.tailwindcss
    nodePackages.autoprefixer
    sass
    lightningcss

    # ==========================================================================
    # BUNDLERS & BUILD TOOLS
    # ==========================================================================

    esbuild

    # ==========================================================================
    # LINTING & FORMATTING
    # ==========================================================================

    nodePackages.prettier
    biome
    nodePackages.typescript
    nodePackages.typescript-language-server

    # ==========================================================================
    # API & BACKEND
    # ==========================================================================

    nodePackages.nodemon
    nodePackages.pm2
    graphqurl
    redocly

    # ==========================================================================
    # STATIC SITE GENERATORS
    # ==========================================================================

    hugo
    zola

    # ==========================================================================
    # DEPLOYMENT & HOSTING
    # ==========================================================================

    nodePackages.vercel
    netlify-cli
    flyctl

    # ==========================================================================
    # NO GUI/BROWSER APPS FOR WSL
    # chromium, geckodriver, chromedriver - use Windows browsers
    # Icon themes - not needed in WSL
    # ==========================================================================

    # ==========================================================================
    # IMAGE & ASSET OPTIMIZATION
    # ==========================================================================

    imagemagick
    optipng
    pngquant
    jpegoptim
    oxipng
    svgo
    gifsicle
    libwebp
    libavif
    libjxl

    # ==========================================================================
    # WEB SERVERS & PROXIES (CLI)
    # ==========================================================================

    caddy
    miniserve
    nodePackages.serve
    nodePackages.http-server

    # Tunneling
    ngrok
    cloudflared

    # ==========================================================================
    # SSL & SECURITY
    # ==========================================================================

    mkcert
    step-cli

    # ==========================================================================
    # DOCUMENTATION
    # ==========================================================================

    mdbook
  ];

  # ==========================================================================
  # CONFIG FILES
  # ==========================================================================

  home.file.".psqlrc".text = ''
    \set PROMPT1 '%[%033[1;35m%]%n%[%033[0m%]@%[%033[1;34m%]%M%[%033[0m%]:%[%033[1;32m%]%/%[%033[0m%]%R%# '
    \set PROMPT2 '%R%# '
    \x auto
    \pset null '(null)'
    \pset linestyle unicode
    \pset border 2
    \set HISTFILE ~/.local/share/psql_history
    \set HISTSIZE 10000
    \set HISTCONTROL ignoredups
  '';

  home.file.".duckdbrc".text = ''
    .mode box
    .nullvalue NULL
    .timer on
  '';

  home.file.".npmrc".text = ''
    prefix=~/.npm-global
    audit=true
    fund=false
    progress=false
    registry=https://registry.npmjs.org/
  '';

  xdg.configFile."bun/bunfig.toml".text = ''
    [install]
    auto = "auto"
    [install.lockfile]
    save = true
    [test]
    coverage = true
  '';

  # ==========================================================================
  # ALIASES
  # ==========================================================================

  programs.bash.shellAliases = {
    pg = "pgcli";
    duck = "duckdb";
    pn = "pnpm";
    ya = "yarn";
    bu = "bun";
    dn = "deno";
    serve = "miniserve --index index.html";
    dev = "pnpm dev";
    build = "pnpm build";
  };

  # ==========================================================================
  # ENVIRONMENT
  # ==========================================================================

  home.sessionVariables = {
    NODE_OPTIONS = "--max-old-space-size=8192";
    NPM_CONFIG_PREFIX = "$HOME/.npm-global";
    BUN_INSTALL = "$HOME/.bun";
    WASM_BINDGEN_WEAKREF = "1";
  };

  home.sessionPath = [
    "$HOME/.npm-global/bin"
    "$HOME/.bun/bin"
    "$HOME/.deno/bin"
  ];
}
