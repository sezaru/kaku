{
  config,
  pkgs,
  inputs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";

    opacity = {
      popups = 1.0;
      terminal = 1.0;
    };

    fonts = {
      serif = config.stylix.fonts.sansSerif;
      sansSerif = {
        package = pkgs.adwaita-fonts;
        name = "Adwaita Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.zed-mono;
        name = "ZedMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    base16Scheme = "${inputs.self}/home/shared/colors/charm.yaml";

    # TODO Check how stylix screenshot works

    targets = {
      console.enable = true;
      grub.enable = true;
      chromium.enable = true;
      fish.enable = true;
      qt.enable = true;
      # gtk.enable = true;
    };
  };
}
