{ pkgs, lib, config, specialArgs, ... }:
let
  nixGLMesaWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
        wrapped_bin=$out/bin/$(basename $bin)
        echo "exec ${lib.getExe pkgs.nixgl.nixGLIntel} $bin \$@" > $wrapped_bin
        chmod +x $wrapped_bin
      done
    '';

  #nixGLAutoDefaultWrap = pkg:
  #  pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
  #    mkdir $out
  #    ln -s ${pkg}/* $out
  #    rm $out/bin
  #    mkdir $out/bin
  #    for bin in ${pkg}/bin/*; do
  #      wrapped_bin=$out/bin/$(basename $bin)
  #      echo "exec ${lib.getExe pkgs.nixgl.auto.nixGLDefault} $bin \$@" > $wrapped_bin
  #      chmod +x $wrapped_bin
  #    done
  #  '';

  nixGLVulkanWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
        wrapped_bin=$out/bin/$(basename $bin)
        echo "exec ${
          lib.getExe pkgs.nixgl.nixVulkanIntel
        } $bin \$@" > $wrapped_bin
        chmod +x $wrapped_bin
      done
    '';

    nixGLVulkanMesaWrap = pkg:
      pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
        mkdir $out
        ln -s ${pkg}/* $out
        rm $out/bin
        mkdir $out/bin
        for bin in ${pkg}/bin/*; do
          wrapped_bin=$out/bin/$(basename $bin)
          echo "${lib.getExe pkgs.nixgl.nixGLIntel} ${
            lib.getExe pkgs.nixgl.nixVulkanIntel
          } $bin \$@" > $wrapped_bin
          chmod +x $wrapped_bin
        done
      '';

    #linkAppConfig = appName: directory: lib.hm.dag.entryAfter ["writeBoundary"]''
    #  rm -rf "${specialArgs.direktori_pengguna}/${directory}/${appName}"
    #  ln -s "${specialArgs.direktori_dotfiles}/${directory}/${appName}" "${specialArgs.direktori_pengguna}/${directory}/${appName}"
    #'';

    #defaultLinkAppConfig = appName: linkAppConfig appName ".config";
in {
  nixGLMesaWrap = nixGLMesaWrap;
  nixGLVulkanWrap = nixGLVulkanWrap;
  nixGLVulkanMesaWrap = nixGLVulkanMesaWrap;
  #nixGLAutoDefaultWrap = nixGLAutoDefaultWrap;
  #linkAppConfig = defaultLinkAppConfig;
}
