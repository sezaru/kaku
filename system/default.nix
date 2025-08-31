let
  desktop = [
    ./core/boot.nix
    ./core/default.nix

    ./hardware/graphics.nix
    ./hardware/fwupd.nix

    ./network/default.nix

    ./stylix.nix

    ./programs

    ./services
    ./services/ananicy.nix
    ./services/pipewire.nix
    ./services/gdm.nix
  ];

  laptop =
    desktop
    ++ [
      ./hardware/bluetooth.nix

      ./services/power.nix
    ];
in {
  inherit desktop laptop;
}
