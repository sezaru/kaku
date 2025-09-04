{pkgs, ...}: {
  users.users.sezdocs = {
    isNormalUser = true;
    initialPassword = "nixos";

    shell = pkgs.fish;

    extraGroups = [
      "adbusers"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "transmission"
      "video"
      "wheel"
      "kvm"
      "docker"
    ];
  };
}
