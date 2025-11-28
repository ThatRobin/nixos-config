# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/nix/steam.nix
      ./modules/nix/obs.nix
      ./modules/nix/unity.nix
      ./modules/nix/r2modman.nix
      ./modules/nix/prismlauncher.nix
      ./modules/nix/audacity.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.keyd.enable = true;

  services.xserver.xkb.extraLayouts.capsfix = {
    description = "Fix Caps Lock toggling only on key press";
    languages = [ "eng" ];
    symbolsFile = ./config/xkb/symbols/capsfix.xkb;
    typesFile = ./config/xkb/types/capsfix.xkb;
  };
  services.xserver.xkb.layout = "capsfix";
  services.xserver.xkb.variant = "capsfix";


  # Enable drive auto-mount
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  
  fileSystems."/mnt/PrimaryDrive" = {
    device = "/dev/disk/by-uuid/c2aa97b1-bbc9-452a-8da4-64b4bf1b5fe7";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  fileSystems."/mnt/MainDrive" = {
    device = "/dev/disk/by-uuid/A85E54F85E54C0AC";
    fsType = "ntfs-3g";
    options = [ "uid=1000" "gid=1000" "umask=022" "nofail" ];
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;        # Enable OpenGL
    enable32Bit = true;
    extraPackages = [
      pkgs.mesa
      pkgs.vulkan-loader  # Vulkan loader
      pkgs.vulkan-tools   # Vulkan utilities, e.g., vulkaninfo
    ];
  };
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.robin = {
    isNormalUser = true;
    description = "Robin Denholm";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      "robin" = import ./home.nix;
    };
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "robin";

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    vscode
    gh
    fastfetch
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.xorg.xkbcomp
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
