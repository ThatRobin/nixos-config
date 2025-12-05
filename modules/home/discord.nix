{ config, pkgs, ... }:

{
  programs.nixcord = {
    enable = true;
    discord = {
      vencord.enable = true;  # Use Vencord (default)
    };
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