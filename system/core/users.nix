{pkgs, ...}: {
  users.users.sezdocs = {
    isNormalUser = true;
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
