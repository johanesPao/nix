{ config, pkgs, specialArgs, lib, ... }:
let
  glwrapper = import ../glwrapper.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };
in
  {
    home.packages = with pkgs; [
      # # PACKAGE SYSTEM-WIDE
      # Tools
      curl # Command line tools and lib for transferring data with URL
      wget # Web getter
      git # Version control
      gh # Github CLI
      fh # Flakehub CLI
      btop # System monitoring
      glxinfo # OpenGL tools
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; }) # Font ligature
      (glwrapper.nixGLMesaWrap alacritty) # Terminal emulator
      # Hiburan
      spotify
      # Reader
      evince
    ];
  }
