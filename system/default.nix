let
  base = [
    ./core/boot.nix
    ./core/default.nix

    ./hardware/graphics.nix
    ./hardware/fwupd.nix

    ./network/default.nix

    ./stylix.nix

    ./programs

    ./services
    ./services/pipewire.nix
    ./services/gdm.nix
  ];

  desktop = base;

  laptop =
    base
    ++ [
      ./hardware/bluetooth.nix
      ./services/power.nix
    ];

  lenovo = laptop ++ [./services/ananicy.nix];

  macbook = laptop ++ [./services/tiny-dfr.nix];
in {
  inherit desktop laptop lenovo macbook;
}
