{ config, pkgs, lib, ... }:

{
  # ============================================================================
  # EMAIL - Terminal email clients
  # ============================================================================

  home.packages = with pkgs; [
    aerc                     # TUI email client
    himalaya                 # CLI email client
    neomutt                  # Classic TUI email
    w3m                      # For HTML emails
    urlscan                  # URL extraction
  ];

  # ============================================================================
  # AERC CONFIG
  # ============================================================================

  xdg.configFile."aerc/aerc.conf".text = ''
    # Aerc config

    [general]
    pgp-provider=gpg
    unsafe-accounts-conf=true
    default-save-path=~/downloads

    [ui]
    index-columns=date<20,name<20,flags>4,subject<*
    column-date={{.DateAutoFormat .Date.Local}}
    column-name={{index (.From | names) 0}}
    column-flags={{.Flags | join ""}}
    column-subject={{.Subject}}
    timestamp-format=2006-01-02 15:04
    this-day-time-format=15:04
    this-week-time-format=Mon 15:04
    this-year-time-format=Jan 02
    sidebar-width=20
    empty-message=(no messages)
    empty-dirlist=(no folders)
    mouse-enabled=true
    new-message-bell=true
    pinned-tab-marker='`'
    dirlist-left={{.Folder}}
    dirlist-right={{if .Unread}}{{humanReadable .Unread}}/{{end}}{{humanReadable .Exists}}
    sort=-r date
    next-message-on-delete=true
    auto-mark-read=true
    completion-delay=250ms
    completion-min-chars=1
    border-char-vertical=│
    border-char-horizontal=─
    styleset-name=default

    [statusline]
    render-format = [%a] %S %>%T
    separator = " | "
    display-mode = text

    [viewer]
    pager=less -R
    alternatives=text/plain,text/html
    show-headers=false
    header-layout=From|To,Cc|Bcc,Date,Subject
    always-show-mime=false
    parse-http-links=true

    [compose]
    editor=nvim
    header-layout=To|From,Subject
    address-book-cmd=
    reply-to-self=false
    no-attachment-warning=^[^>]*attach

    [filters]
    text/plain=colorize
    text/html=w3m -T text/html -cols $(tput cols) -dump -o display_image=false -o display_link_number=true
    message/delivery-status=colorize
    message/rfc822=colorize
    application/pdf=zathura -
    image/*=imv -
  '';

  # ============================================================================
  # HIMALAYA CONFIG
  # ============================================================================

  xdg.configFile."himalaya/config.toml".text = ''
    # Himalaya config
    # Configure your accounts here
    
    # Example Gmail account:
    # [accounts.gmail]
    # default = true
    # email = "you@gmail.com"
    # display-name = "Your Name"
    # 
    # backend = "imap"
    # imap-host = "imap.gmail.com"
    # imap-port = 993
    # imap-ssl = true
    # imap-login = "you@gmail.com"
    # imap-passwd-cmd = "pass email/gmail"
    # 
    # sender = "smtp"
    # smtp-host = "smtp.gmail.com"
    # smtp-port = 587
    # smtp-starttls = true
    # smtp-login = "you@gmail.com"
    # smtp-passwd-cmd = "pass email/gmail"
  '';

  # ============================================================================
  # SHELL ALIASES
  # ============================================================================

  programs.bash.shellAliases = {
    mail = "aerc";
    email = "aerc";
    hm = "himalaya";
  };
}
