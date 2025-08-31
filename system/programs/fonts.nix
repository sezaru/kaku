{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.symbols-only
    ];

    # Causes more issues than it solves
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;
      antialias = true;

      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };

      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };
}
