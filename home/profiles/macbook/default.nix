{
  imports = [
    # services
    ../../services/quickshell
    ../../services/hypridle.nix

    # software
    ../../software
    ../../software/wayland

    # system services
    ../../services/system/gpg-agent.nix
    ../../services/system/polkit-agent.nix
  ];
}
