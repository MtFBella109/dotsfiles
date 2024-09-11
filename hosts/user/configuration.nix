# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


{
  imports =
[ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];



  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.blacklistedKernelModules = ["rtl8xxxu"];
  boot.extraModulePackages = with config.boot.kernelPackages; [pkgs.rtl8761b-firmware];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORMTHEME="qt6ct";
  };
  environment.etc = {
	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		}
	'';
};



  # Set your time zone.
  time.timeZone = "TIMEZONE";

 # Select internationalisation properties.
  i18n.defaultLocale = "LOCALE";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "LOCALE";
    LC_CTYPE = "LOCALE";
    LC_IDENTIFICATION = "LOCALE";
    LC_MEASUREMENT = "LOCALE";
    LC_MONETARY = "LOCALE";
    LC_NAME = "LOCALE";
    LC_NUMERIC = "LOCALE";
    LC_PAPER = "LOCALE";
    LC_TELEPHONE = "LOCALE";
    LC_TIME = "LOCALE";
  };



   

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["DRIVER"];
     displayManager.sddm = {
      enable = true;
      theme = "catppuccin-mocha";
      wayland.enable = true;
			extraConfig = ''
    [Session hyprland]
    Exec=/usr/bin/sddm-helper startX --session=hyprland
  '';
    };
   # displayManager.gdm = {
   #   enable = true;
   #   wayland = true;
   # };
    # Configre keymap in X11
    layout = "LAYOUT";
    xkbVariant = "";
  };

  
  # Configure console keymap
  console.keyMap = "LAYOUT";

  # Enable CUPS to print documents.
  services.printing.enable = false;
  services.flatpak.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    
  };



  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.USER = {
    isNormalUser = true;
    description = "USER";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
    xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };


  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    adwaita-qt
    alacritty
    cliphist
    catppuccin-sddm
    deluge-gtk
    dunst
    git
    grim
    kdePackages.kdeconnect-kde
    kdePackages.qt6ct
    kdePackages.qtwayland
    mc
    rofi-power-menu
    rofi-wayland
    slurp
    unzip
    waybar
    wget
    wmctrl
    wine
  ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.nvidia.modesetting.enable = true;


  programs.fish.enable = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
 

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
