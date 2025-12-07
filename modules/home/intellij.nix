{ config, pkgs, ... }:

{
  # Install IntelliJ IDEA Community edition
  home.packages = [
    pkgs.jetbrains.idea-community
  ];
}
