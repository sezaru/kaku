{
  inputs,
  pkgs,
  ...
}:
inputs.devenv.lib.mkShell {
  inherit inputs pkgs;

  modules = [
    ({config, pkgs, ...}: let
      state_dir = config.env.DEVENV_STATE;

      mix_dir = "${state_dir}/mix";
      hex_dir = "${state_dir}/hex";

      erlang_libraries = "${hex_dir}/lib/erlang/lib";
      erlang_history = "${state_dir}/erlang-history";
      in {
      env = {
        MIX_HOME = mix_dir;
        HEX_HOME = hex_dir;
        ERL_LIBS = erlang_libraries;
        ERL_AFLAGS = "-kernel shell_history enabled -kernel shell_history_path '\"${erlang_history}\"'";
      };

      languages.elixir.enable = true;

      enterShell = ''
        elixir --version
      '';
    })
  ];
}
