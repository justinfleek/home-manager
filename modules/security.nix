{ config, pkgs, lib, ... }:

{
  # ============================================================================
  # SECURITY HARDENING - White hat mode engaged
  # Battle-hardened security stack for the paranoid
  # ============================================================================

  home.packages = with pkgs; [
    # ==========================================================================
    # ENCRYPTION & SECRETS
    # ==========================================================================
    
    # GPG
    gnupg                    # GNU Privacy Guard
    pinentry-gnome3          # GPG PIN entry
    
    # Age encryption (modern alternative to GPG)
    age                      # Simple, modern encryption
    rage                     # Rust implementation of age
    
    # Secret management
    sops                     # Secrets management
    pass                     # Password store
    gopass                   # Go password store
    rbw                      # Bitwarden CLI (Rust)
    
    # Key management
    yubikey-manager          # YubiKey management
    yubikey-personalization  # YubiKey config
    yubico-piv-tool          # PIV operations
    
    # SSH
    openssh                  # SSH client/server
    ssh-audit                # SSH server auditing
    sshuttle                 # VPN over SSH
    autossh                  # Auto-reconnecting SSH
    mosh                     # Mobile shell (better SSH)
    
    # ==========================================================================
    # NETWORK SECURITY
    # ==========================================================================
    
    # Firewall tools
    iptables                 # Firewall (legacy)
    nftables                 # Modern firewall
    
    # VPN
    wireguard-tools          # Modern VPN
    openvpn                  # OpenVPN client
    tailscale                # Zero-config VPN
    
    # DNS security
    dnscrypt-proxy          # Encrypted DNS
    stubby                   # DNS over TLS
    
    # Network analysis
    wireshark                # Packet analyzer
    tcpdump                  # CLI packet capture
    nmap                     # Network scanner
    masscan                  # Fast port scanner
    rustscan                 # Fast Rust port scanner
    
    # Network monitoring
    bandwhich                # Bandwidth per process
    nethogs                  # Per-process bandwidth
    iftop                    # Interface bandwidth
    bmon                     # Bandwidth monitor
    
    # TLS/SSL tools
    openssl                  # SSL/TLS toolkit
    certbot                  # Let's Encrypt client
    step-cli                 # Certificate management
    cfssl                    # Cloudflare PKI toolkit
    
    # ==========================================================================
    # INTRUSION DETECTION & MONITORING
    # ==========================================================================
    
    # File integrity
    aide                     # File integrity checker
    # tripwire not in nixpkgs - use aide instead
    
    # System auditing
    lynis                    # Security auditing
    # chkrootkit and rkhunter not available - use lynis for auditing
    
    # Log analysis
    lnav                     # Log navigator
    goaccess                 # Real-time log analyzer
    
    # Process monitoring
    sysstat                  # System statistics
    acct                     # Process accounting
    
    # ==========================================================================
    # VULNERABILITY SCANNING
    # ==========================================================================
    
    # Container scanning
    trivy                    # Container vulnerability scanner
    grype                    # Container vulnerability scanner
    syft                     # SBOM generator
    
    # Code scanning
    semgrep                  # Static analysis
    gitleaks                 # Git secrets scanner
    trufflehog               # Credential scanner
    detect-secrets           # Secrets detection
    
    # Dependency scanning
    osv-scanner              # OSV vulnerability scanner
    
    # ==========================================================================
    # FORENSICS & ANALYSIS
    # ==========================================================================
    
    # Memory forensics
    volatility3              # Memory forensics
    
    # Disk forensics
    testdisk                 # Data recovery (includes photorec)
    foremost                 # File carving
    sleuthkit                # Disk forensics
    
    # Binary analysis
    binwalk                  # Firmware analysis
    radare2                  # Reverse engineering
    ghidra                   # NSA reverse engineering
    
    # Malware analysis
    yara                     # Malware identification
    clamav                   # Antivirus
    
    # ==========================================================================
    # PENETRATION TESTING
    # ==========================================================================
    
    # Web testing
    nikto                    # Web server scanner
    gobuster                 # Directory brute-forcer
    feroxbuster              # Fast content discovery
    sqlmap                   # SQL injection
    
    # Password cracking
    john                     # John the Ripper
    hashcat                  # GPU password cracking
    
    # Wireless
    aircrack-ng              # WiFi security
    
    # Exploitation frameworks
    metasploit               # Exploitation framework
    
    # Fuzzing
    aflplusplus              # AFL++ (enhanced American Fuzzy Lop)
    honggfuzz                # Fuzzer
    
    # ==========================================================================
    # PRIVACY TOOLS
    # ==========================================================================
    
    # Tor
    tor                      # Anonymity network
    torsocks                 # Tor wrapper
    
    # Metadata removal
    mat2                     # Metadata removal
    exiftool                 # EXIF manipulation
    
    # Secure deletion
    srm                      # Secure remove
    wipe                     # Secure file wiping
    
    # ==========================================================================
    # SANDBOXING & ISOLATION
    # ==========================================================================
    
    # Sandboxing
    firejail                 # SUID sandbox
    bubblewrap               # Unprivileged sandboxing
    
    # Containers
    podman                   # Rootless containers
    
    # ==========================================================================
    # AUTHENTICATION
    # ==========================================================================
    
    # 2FA/MFA
    oath-toolkit              # TOTP/HOTP tools
    
    # PAM
    pam_u2f                  # U2F PAM module
    
    # ==========================================================================
    # MISC SECURITY TOOLS
    # ==========================================================================
    
    # Password generation
    pwgen                    # Password generator
    diceware                 # Passphrase generator
    xkcdpass                 # XKCD-style passphrases
    
    # Checksums
    rhash                    # Hash calculator
    
    # Entropy
    haveged                  # Entropy daemon
    
    # Security Swiss Army knife
    openssl                  # SSL/TLS toolkit
    
    # Documentation
    cheat                    # Cheat sheets
  ];

  # ==========================================================================
  # GPG CONFIGURATION
  # ==========================================================================
  
  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
    
    settings = {
      # Use strong defaults
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      
      # Strong key preferences
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      
      # Display preferences
      charset = "utf-8";
      keyid-format = "0xlong";
      with-fingerprint = true;
      
      # Security
      require-cross-certification = true;
      no-symkey-cache = true;
      use-agent = true;
      
      # Keyserver
      keyserver = "hkps://keys.openpgp.org";
      keyserver-options = "no-honor-keyserver-url include-revoked";
    };
  };

  # ==========================================================================
  # GPG AGENT
  # ==========================================================================
  
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableBashIntegration = true;
    
    # Cache timeouts
    defaultCacheTtl = 3600;        # 1 hour
    maxCacheTtl = 14400;           # 4 hours
    defaultCacheTtlSsh = 3600;
    maxCacheTtlSsh = 14400;
    
    # PIN entry
    pinentry.package = pkgs.pinentry-gnome3;
    
    # Extra config
    extraConfig = ''
      allow-loopback-pinentry
    '';
  };

  # ==========================================================================
  # SSH HARDENING
  # ==========================================================================
  
  programs.ssh = {
    enable = true;
    
    # Global settings
    hashKnownHosts = true;
    compression = true;
    
    # Security settings
    extraConfig = ''
      # Strong crypto only
      KexAlgorithms curve25519-sha256@libssh.org,curve25519-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512
      Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
      MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
      HostKeyAlgorithms ssh-ed25519,rsa-sha2-512,rsa-sha2-256
      
      # Security
      PasswordAuthentication no
      ChallengeResponseAuthentication no
      PubkeyAuthentication yes
      
      # Timeouts
      ServerAliveInterval 60
      ServerAliveCountMax 3
      
      # Connection sharing
      ControlMaster auto
      ControlPath ~/.ssh/sockets/%r@%h-%p
      ControlPersist 600
      
      # Identity
      AddKeysToAgent yes
      IdentitiesOnly yes
      
      # Verification
      VisualHostKey yes
      StrictHostKeyChecking ask
      UpdateHostKeys yes
    '';
  };

  # Create SSH socket directory
  home.file.".ssh/sockets/.keep".text = "";

  # ==========================================================================
  # FIREJAIL PROFILES
  # ==========================================================================
  
  xdg.configFile."firejail/firefox.local".text = ''
    # Extra Firefox hardening
    private-dev
    noroot
    caps.drop all
    seccomp
    protocol unix,inet,inet6
  '';
  
  xdg.configFile."firejail/chromium.local".text = ''
    # Extra Chromium hardening
    private-dev
    noroot
    caps.drop all
    seccomp
  '';

  # ==========================================================================
  # SECURITY AUDIT SCRIPTS
  # ==========================================================================
  
  home.file.".local/bin/security-audit" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Security audit script
      
      set -euo pipefail
      
      echo "========================================"
      echo "  SECURITY AUDIT - $(date)"
      echo "========================================"
      echo ""
      
      # Check for world-writable files in home
      echo "[*] Checking for world-writable files..."
      find "$HOME" -type f -perm -002 2>/dev/null | head -20 || echo "    None found (good!)"
      echo ""
      
      # Check SSH key permissions
      echo "[*] Checking SSH key permissions..."
      if [ -d "$HOME/.ssh" ]; then
        ls -la "$HOME/.ssh" | grep -E "^-" | awk '{print $1, $9}'
      fi
      echo ""
      
      # Check for SUID binaries in home
      echo "[*] Checking for SUID binaries in home..."
      find "$HOME" -type f -perm -4000 2>/dev/null | head -10 || echo "    None found (good!)"
      echo ""
      
      # Check listening ports
      echo "[*] Checking listening ports..."
      ss -tuln 2>/dev/null | grep LISTEN || netstat -tuln 2>/dev/null | grep LISTEN || echo "    Could not check ports"
      echo ""
      
      # Check failed SSH attempts
      echo "[*] Recent failed SSH attempts..."
      journalctl -u sshd --since "24 hours ago" 2>/dev/null | grep -i "failed\|invalid" | tail -10 || echo "    No SSH service or no failures"
      echo ""
      
      # Check for secrets in common locations
      echo "[*] Scanning for potential secrets..."
      for f in "$HOME/.bash_history" "$HOME/.zsh_history"; do
        if [ -f "$f" ]; then
          grep -iE "(password|secret|api_key|token|bearer)" "$f" 2>/dev/null | wc -l | xargs -I{} echo "    Found {} potential secrets in $f"
        fi
      done
      echo ""
      
      # GPG key status
      echo "[*] GPG keys..."
      gpg --list-keys 2>/dev/null | grep -E "^pub|^uid" | head -10 || echo "    No GPG keys found"
      echo ""
      
      echo "========================================"
      echo "  AUDIT COMPLETE"
      echo "========================================"
    '';
  };

  home.file.".local/bin/git-secrets-scan" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Scan a git repo for secrets
      
      set -euo pipefail
      
      REPO="''${1:-.}"
      
      echo "Scanning $REPO for secrets..."
      echo ""
      
      echo "[1/3] Running gitleaks..."
      gitleaks detect --source "$REPO" --verbose 2>&1 | head -50 || true
      echo ""
      
      echo "[2/3] Running trufflehog..."
      trufflehog filesystem "$REPO" --only-verified 2>&1 | head -50 || true
      echo ""
      
      echo "[3/3] Running detect-secrets..."
      cd "$REPO" && detect-secrets scan 2>&1 | head -50 || true
      echo ""
      
      echo "Scan complete!"
    '';
  };

  home.file.".local/bin/harden-file" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Make a file immutable (requires sudo)
      
      if [ -z "$1" ]; then
        echo "Usage: harden-file <file>"
        exit 1
      fi
      
      sudo chattr +i "$1"
      echo "File $1 is now immutable"
      echo "To undo: sudo chattr -i $1"
    '';
  };

  home.file.".local/bin/secure-delete" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Securely delete files
      
      if [ -z "$1" ]; then
        echo "Usage: secure-delete <file|directory>"
        exit 1
      fi
      
      if [ -d "$1" ]; then
        find "$1" -type f -exec shred -vfzu -n 5 {} \;
        rm -rf "$1"
      else
        shred -vfzu -n 5 "$1"
      fi
      
      echo "Securely deleted: $1"
    '';
  };

  # ==========================================================================
  # SECURITY ALIASES
  # ==========================================================================
  
  programs.bash.shellAliases = {
    # GPG
    gpg-list = "gpg --list-keys --keyid-format=long";
    gpg-export = "gpg --armor --export";
    gpg-gen = "gpg --full-generate-key";
    
    # Password generation
    genpass = "pwgen -s 32 1";
    genphrase = "xkcdpass -n 6";
    
    # Hash a file
    sha = "sha256sum";
    sha512 = "sha512sum";
    
    # Check for rootkits
    rootkit-check = "sudo rkhunter --check --skip-keypress";
    
    # Network
    ports = "ss -tuln";
    listening = "ss -tuln | grep LISTEN";
    connections = "ss -tun";
    
    # Security audit
    audit = "security-audit";
    secrets-scan = "git-secrets-scan";
    
    # Wireshark (as non-root)
    wshark = "wireshark";
    
    # Firewall
    fw-status = "sudo nft list ruleset";
    
    # Secure shell
    sshh = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
    
    # VPN
    vpn-status = "tailscale status";
    wg-status = "sudo wg show";
    
    # File integrity
    checksum-dir = "find . -type f -exec sha256sum {} \\; > checksums.sha256";
    verify-checksums = "sha256sum -c checksums.sha256";
    
    # Metadata
    strip-meta = "mat2 --inplace";
    show-meta = "exiftool";
    
    # Sandboxing
    jail = "firejail --private";
  };

  # ==========================================================================
  # ENVIRONMENT HARDENING
  # ==========================================================================
  
  home.sessionVariables = {
    # GPG TTY
    GPG_TTY = "$(tty)";
    
    # Secure umask
    # (Note: this should be in shell rc for proper execution)
    
    # History security
    HISTCONTROL = "ignoreboth:erasedups";
    HISTIGNORE = "*password*:*secret*:*token*:*api_key*";
  };

  # ==========================================================================
  # SHELL HARDENING
  # ==========================================================================
  
  programs.bash.initExtra = lib.mkAfter ''
    # Secure umask
    umask 077
    
    # Disable core dumps
    ulimit -c 0
    
    # Lock down history
    HISTFILESIZE=10000
    HISTSIZE=10000
    
    # Warn about overwriting files
    set -o noclobber
    
    # Exit on error in scripts
    # set -e
  '';
}
