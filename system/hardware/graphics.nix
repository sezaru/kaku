{
  pkgs,
  vars,
  ...
}: let
  amd = {
    enable = true;

    extraPackages = with pkgs; [
      libva
      vaapiVdpau
      libvdpau-va-gl
      amdvlk
      mesa
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      libvdpau-va-gl
      amdvlk
    ];
  };

  mac = {
    enable = true;
  };
in {
  hardware.graphics =
    if vars.gpu == "amd"
    then amd
    else if vars.gpu == "mac"
    then mac
    else abort "Unknown gpu";
}
