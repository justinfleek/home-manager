{
  config,
  pkgs,
  lib,
  ...
}:

{
  # ============================================================================
  # WEB DEVELOPMENT - Full stack for building websites
  # PostgreSQL, DuckDB, WASM, WebGL, icons, and all the modern tooling
  # ============================================================================

  home.packages = with pkgs; [
    # ==========================================================================
    # DATABASES
    # ==========================================================================

    # PostgreSQL
    postgresql_16 # PostgreSQL 16
    pgcli # PostgreSQL CLI with autocomplete
    pgformatter # PostgreSQL SQL formatter
    pg_activity # top-like for PostgreSQL

    # DuckDB - Modern OLAP
    duckdb # Embeddable analytical database

    # SQLite
    sqlite # Embedded SQL database
    litecli # SQLite CLI with autocomplete

    # Redis
    redis # In-memory data store

    # Database tools
    usql # Universal SQL CLI
    dbmate # Database migrations
    sqlfluff # SQL linter

    # ==========================================================================
    # WEBASSEMBLY & WEBGL
    # ==========================================================================

    # WASM toolchain
    wasmtime # WASM runtime
    # wasmer                 # Temporarily disabled - linker build issue
    wasm-pack # Rust to WASM bundler
    wasm-bindgen-cli # Rust/WASM bindings
    binaryen # WASM optimizer (wasm-opt)
    wabt # WASM binary toolkit
    emscripten # C/C++ to WASM compiler

    # Rust WASM
    cargo-wasi # Build WASM with Cargo
    trunk # WASM web app bundler

    # WebGL/Graphics
    glslang # GLSL compiler
    shaderc # Shader compiler
    spirv-tools # SPIR-V tools

    # ==========================================================================
    # JAVASCRIPT/TYPESCRIPT ECOSYSTEM
    # ==========================================================================

    # Runtimes
    nodejs_22 # Node.js LTS
    bun # Fast JS runtime/bundler
    deno # Secure JS/TS runtime

    # Package managers
    nodePackages.pnpm # Fast, disk-efficient
    yarn # Yarn classic
    # corepack # Included with nodejs_22

    # Build tools
    # turbo/nx - install via npm/pnpm as needed for monorepos

    # Frontend frameworks CLI - use npx for scaffolding:
    # npx create-react-app, npx create-next-app, etc.

    # ==========================================================================
    # CSS & STYLING
    # ==========================================================================

    # Tailwind
    nodePackages.tailwindcss

    # PostCSS - use via bundlers or npx
    nodePackages.autoprefixer

    # SASS/SCSS
    sass # Dart Sass

    # CSS tools
    lightningcss # Fast CSS parser/transformer

    # ==========================================================================
    # BUNDLERS & BUILD TOOLS
    # ==========================================================================

    # Core bundlers/transpilers available in nixpkgs
    esbuild # Fast bundler/minifier
    # vite, rollup, webpack - install via pnpm/npm per-project

    # ==========================================================================
    # LINTING & FORMATTING
    # ==========================================================================

    # JavaScript/TypeScript
    # nodePackages.eslint  # Conflicts with wrangler's bundled eslint - use npx eslint
    nodePackages.prettier
    biome # Fast formatter/linter

    # TypeScript
    nodePackages.typescript
    nodePackages.typescript-language-server

    # ==========================================================================
    # API & BACKEND
    # ==========================================================================

    # API frameworks support
    nodePackages.nodemon # Auto-restart on changes
    nodePackages.pm2 # Process manager

    # GraphQL
    graphqurl # GraphQL CLI

    # OpenAPI
    redocly # OpenAPI documentation

    # ==========================================================================
    # TESTING
    # ==========================================================================

    # Browser testing
    playwright-driver.browsers
    # vitest, jest - install via pnpm/npm per-project

    # ==========================================================================
    # STATIC SITE GENERATORS
    # ==========================================================================

    hugo # Fast static site generator
    zola # Rust static site generator
    # nodePackages.gatsby-cli  # Conflicts with eslint - use npx gatsby instead

    # ==========================================================================
    # DEPLOYMENT & HOSTING
    # ==========================================================================

    nodePackages.vercel
    netlify-cli # Netlify CLI
    # nodePackages.wrangler  # Use standalone wrangler or npx - conflicts with prettier
    flyctl # Fly.io CLI

    # ==========================================================================
    # ICONS & DESIGN ASSETS
    # ==========================================================================

    # Icon fonts
    font-awesome # Font Awesome icons
    material-design-icons # Material Design icons
    nerd-fonts.fira-code # Nerd Font with icons
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.iosevka
    nerd-fonts.symbols-only # Just the icons

    # Icon themes (GTK/system)
    # papirus-icon-theme  # Already in home.nix
    # tela-icon-theme     # Conflicts with papirus
    qogir-icon-theme # Qogir icons
    whitesur-icon-theme # WhiteSur (macOS-like)
    colloid-icon-theme # Colloid icons

    # Emoji
    noto-fonts-color-emoji # Google Noto emoji
    twitter-color-emoji # Twitter emoji

    # ==========================================================================
    # IMAGE & ASSET OPTIMIZATION
    # ==========================================================================

    # Image optimization
    imagemagick # Image manipulation
    optipng # PNG optimizer
    pngquant # PNG lossy compression
    jpegoptim # JPEG optimizer
    oxipng # Rust PNG optimizer
    svgo # SVG optimizer
    gifsicle # GIF optimizer

    # Image formats
    libwebp # WebP tools
    libavif # AVIF tools
    libjxl # JPEG XL tools

    # ==========================================================================
    # WEB SERVERS & PROXIES
    # ==========================================================================

    # Development servers
    caddy # Modern web server
    miniserve # Simple file server
    nodePackages.serve # Static file serving
    nodePackages.http-server # Simple HTTP server

    # Tunneling
    ngrok # Secure tunnels
    cloudflared # Cloudflare tunnel

    # ==========================================================================
    # SSL & SECURITY
    # ==========================================================================

    mkcert # Local HTTPS certs
    step-cli # Certificate management

    # ==========================================================================
    # BROWSER DEVELOPMENT
    # ==========================================================================

    # Browsers for testing
    chromium

    # Browser automation
    chromedriver
    geckodriver # Firefox WebDriver

    # ==========================================================================
    # DOCUMENTATION
    # ==========================================================================

    mdbook # Rust/Markdown documentation
    # typedoc, jsdoc - install via npm per-project

    # ==========================================================================
    # PERFORMANCE & MONITORING
    # ==========================================================================

    # Profiling
    hyperfine # Benchmarking
    # clinic, source-map-explorer - install via npm
  ];

  # ==========================================================================
  # POSTGRESQL SERVICE (user-level)
  # ==========================================================================

  # Note: For a full PostgreSQL server, use NixOS service
  # This provides client tools and dev setup

  home.file.".psqlrc".text = ''
    -- Catppuccin-inspired psql prompt
    \set PROMPT1 '%[%033[1;35m%]%n%[%033[0m%]@%[%033[1;34m%]%M%[%033[0m%]:%[%033[1;32m%]%/%[%033[0m%]%R%# '
    \set PROMPT2 '%R%# '

    -- Better output
    \x auto
    \pset null '(null)'
    \pset linestyle unicode
    \pset border 2

    -- History
    \set HISTFILE ~/.local/share/psql_history
    \set HISTSIZE 10000
    \set HISTCONTROL ignoredups

    -- Useful shortcuts
    \set activity 'SELECT pid, usename, state, query FROM pg_stat_activity;'
    \set sizes 'SELECT table_name, pg_size_pretty(pg_total_relation_size(table_name)) FROM information_schema.tables WHERE table_schema = \'public\' ORDER BY pg_total_relation_size(table_name) DESC;'
    \set connections 'SELECT usename, count(*) FROM pg_stat_activity GROUP BY usename;'
  '';

  # ==========================================================================
  # DUCKDB CONFIG
  # ==========================================================================

  home.file.".duckdbrc".text = ''
    -- DuckDB startup config
    .mode box
    .nullvalue NULL
    .timer on
  '';

  # ==========================================================================
  # NPM CONFIG
  # ==========================================================================

  home.file.".npmrc".text = ''
    # Global packages in home directory
    prefix=~/.npm-global

    # Security
    audit=true
    fund=false

    # Performance
    progress=false

    # Registry
    registry=https://registry.npmjs.org/

    # Git
    git-tag-version=true

    # Init defaults
    init-license=MIT
    init-version=0.0.1
  '';

  # ==========================================================================
  # BUN CONFIG
  # ==========================================================================

  xdg.configFile."bun/bunfig.toml".text = ''
    # Bun configuration

    [install]
    # Install packages to node_modules
    auto = "auto"

    [install.lockfile]
    # Save lockfile
    save = true

    [test]
    coverage = true
  '';

  # ==========================================================================
  # USEFUL ALIASES
  # ==========================================================================

  programs.bash.shellAliases = {
    # Database
    pg = "pgcli";
    duck = "duckdb";
    usql = "usql";

    # Node/JS
    pn = "pnpm";
    ya = "yarn";
    bu = "bun";
    dn = "deno";

    # Development servers
    serve = "miniserve --index index.html";
    dev = "pnpm dev";
    build = "pnpm build";

    # Vite shortcuts
    vdev = "npx vite";
    vbuild = "npx vite build";
    vpreview = "npx vite preview";

    # Database shortcuts
    pgstart = "pg_ctl -D ~/.local/share/postgresql start";
    pgstop = "pg_ctl -D ~/.local/share/postgresql stop";

    # WASM
    wasm-opt-all = "find . -name '*.wasm' -exec wasm-opt -O3 {} -o {} \\;";

    # Image optimization
    optimg = "find . -name '*.png' -exec optipng -o7 {} \\;";

    # SSL
    localcert = "mkcert -install && mkcert localhost 127.0.0.1 ::1";

    # Lighthouse
    # lh = "npx lighthouse";

    # Bundle size
    bundlesize = "npx source-map-explorer";
  };

  # ==========================================================================
  # ENVIRONMENT VARIABLES
  # ==========================================================================

  home.sessionVariables = {
    # Node.js
    NODE_OPTIONS = "--max-old-space-size=8192";

    # npm global path
    NPM_CONFIG_PREFIX = "$HOME/.npm-global";

    # Bun
    BUN_INSTALL = "$HOME/.bun";

    # WASM
    WASM_BINDGEN_WEAKREF = "1";
  };

  home.sessionPath = [
    "$HOME/.npm-global/bin"
    "$HOME/.bun/bin"
    "$HOME/.deno/bin"
  ];
}
