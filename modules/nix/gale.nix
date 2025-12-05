{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gale
  ];
}
