{pkgs, inputs, ...}: let
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default";
  };
in {
  environment.systemPackages = [sddm-theme];

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;

      package = pkgs.kdePackages.sddm;

      theme = sddm-theme.pname;

      extraPackages = sddm-theme.propagatedBuildInputs;

      settings = {
       # Required for styling the virtual keyboard
       General = {
         GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/theme/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
         InputMethod = "qtvirtualkeyboard";
       };
      };
    };

    sessionPackages = [pkgs.niri];
  };

  system.activationScripts.copyFiles = {
    text = ''
    cp -r ${./sddm/faces}/* /var/lib/AccountsService/icons/
    '';
  };
}
