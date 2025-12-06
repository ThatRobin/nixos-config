{ config, pkgs, inputs, ... }:

{
  home.username = "robin";
  home.homeDirectory = "/home/robin";

  imports = [
    # Discord
    inputs.nixcord.homeModules.nixcord
    ./modules/home/discord.nix

    # Spotify
    inputs.spicetify-nix.homeManagerModules.default
    ./modules/home/spotify.nix

  ];
  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    #"test_dir/test_file.py" = ''print("hello world!")'';
    ".config/fastfetch/config.jsonc" = {
      source = ./config/fastfetch/config.jsonc;
      force = true;
    };
  };

  systemd.user.services.input-remapper-autoload = {
    Unit = {
      Description = "Autoload Input Remapper profiles on login";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.input-remapper}/bin/input-remapper-control --command autoload";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/robin/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixos-config#robin";
    npurge = "sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system +2";
    nupdate = "nix flake update --flake ~/nixos-config";
  };
  programs.bash.bashrcExtra = ''
    fastfetch
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.keyboard = null;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
