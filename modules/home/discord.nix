{ config, pkgs, ... }:

{
  programs.nixcord = {
    enable = true;
    vesktop.enable = true;
    config = {
      plugins = {
        experiments = {
          enable = true;
        };
        messageLogger = {
          enable = true;
        };
      };
    };
  };
}