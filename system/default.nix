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
    ./services/sddm.nix
  ];

  desktop = base;

  laptop =
    base
    ++ [
      ./hardware/bluetooth.nix
      ./services/power.nix
    ];

  lenovo = laptop ++ [./services/ananicy.nix];

  # TODO I don't think we need this service
  # macbook = laptop ++ [./services/tiny-dfr.nix];
  macbook = laptop;
in {
  inherit desktop laptop lenovo macbook;
}
