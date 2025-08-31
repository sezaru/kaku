{pkgs, ...}: {
  imports = [
    ./browsers/chromium.nix
    ./browsers/zen.nix
    ./editors/emacs
    ./gtk.nix
    ./media
  ];

  home.packages = with pkgs; [
    # Messaging
    telegram-desktop
    # discord
    # signal-desktop

    # Media
    feishin
    (celluloid.override {youtubeSupport = true;})
    loupe
    inkscape
    gimp

    # Misc
    ps_mem
    pciutils
    nixos-icons
    # colord
    # cliphist
    # ffmpegthumbnailer
    # imagemagick

    # Basics
    file-roller
    nautilus
    (papers.override {supportNautilus = true;})
    resources

    # Terminal
    ghostty
  ];
}
