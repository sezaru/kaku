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
    amberol
    (celluloid.override {youtubeSupport = true;})
    dconf-editor
    eyedropper
    file-roller
    gnome-control-center
    gnome-text-editor
    keypunch
    loupe
    nautilus
    (papers.override {supportNautilus = true;})
    # pwvucontrol
    resources

    inkscape
    gimp
    # krita
    scrcpy

    # swww
    ghostty
    mods
  ];
}
