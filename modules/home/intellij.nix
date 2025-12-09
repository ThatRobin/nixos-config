{ config, pkgs, ... }:

let
  runtimeLibs = pkgs.lib.makeLibraryPath [
    pkgs.glfw
    pkgs.libGL
    pkgs.openal
    pkgs.xorg.libX11
    pkgs.xorg.libXcursor
    pkgs.xorg.libXext
    pkgs.xorg.libXrandr
    pkgs.xorg.libXxf86vm
    pkgs.flite
  ];

  ideaWrapped = pkgs.writeShellScriptBin "idea-wrapped" ''
    export LD_LIBRARY_PATH=${runtimeLibs}:$LD_LIBRARY_PATH
    exec ${pkgs.jetbrains.idea-community}/bin/idea-community "$@"
  '';
in {
  home.packages = [
    ideaWrapped
  ];
}
