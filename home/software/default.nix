{
  pkgs,
  ...
}: {
  imports = [
    ./browsers/chromium.nix
    ./browsers/zen.nix
    ./gtk.nix
    ./media
  ];

  # TODO Review these packages
  home.packages = with pkgs; [
    # messaging
    telegram-desktop
    # vesktop

    # misc
    ps_mem
    pciutils
    nixos-icons
    colord
    cliphist
    ffmpegthumbnailer
    imagemagick

    # gnome
    (celluloid.override {youtubeSupport = true;})
    file-roller
    loupe
    nautilus
    (papers.override {supportNautilus = true;})
    resources

    inkscape
    gimp

    ghostty
  ];
}
