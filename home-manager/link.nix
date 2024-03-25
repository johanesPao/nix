{ config, pkgs, specialArgs, lib, ... }:
let
  glwrapper = import ./glwrapper.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };
in
  {
    home.activation = {
      linkAlacritty = glwrapper.linkAppConfig "alacritty";
    };

    home.file.".alacritty.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink
      "${specialArgs.direktori_dotfiles}/alacritty/alacritty.toml";
    };
  }
