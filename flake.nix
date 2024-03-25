{
  description = "Home Manager configuration of jpao";

  inputs = {
    # # Source home-manager dan nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { nixpkgs, home-manager, nixgl, ... }@inputs:
  let
      versi = "23.11";
      pengguna = "jpao";
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      direktori_pengguna_linux = "/home/${pengguna}";
      direktori_dotfiles = "/.config";
      # pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.linux_x86_64 = home-manager.lib.homeManagerConfiguration {
        # inherit pkgs;
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = allowUnfree;
          config.allowUnfreePredicate = allowUnfreePredicate;
          # nixGL wrapper untuk issue dengan openGL
          overlays = [ nixgl.overlay ];
        };

        extraSpecialArgs = {
          inherit inputs;
          pengguna = pengguna;
          direktori_pengguna = direktori_pengguna_linux;
          allowUnfree = allowUnfree;
          allowUnfreePredicate = allowUnfreePredicate;
          versi = versi;
          direktori_dotfiles = "${direktori_pengguna_linux}${direktori_dotfiles}";
        };

        # path home.nix.
        modules = [ ./home-manager/home.nix ];
      };
    };
}
