{ config, pkgs, specialArgs, lib, ... }:
let
  glwrapper = import ../../glwrapper.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };
in
  {
    home.packages = with pkgs; [
      (glwrapper.nixGLMesaWrap alacritty)
    ];
  }
