{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };

  # Host and networking
  networking.hostName = "gg@nix";
  networking.networkmanager.enable = true;

  # Locale & timezone
  time.timeZone = "Europe/Oslo";
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
  console.keyMap = "no";

  # X11 and i3
  services.xserver = {
    enable = true;
    layout = "no";  
    displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        enable = true;
        user = "gg";
      };
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [ dmenu i3status i3lock i3blocks ];
    };
  };

  # Enable theming, thumbnails, and mounting
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Optional compositor
  services.picom = {
    enable = true;
    fade = true;
    shadow = true;
    fadeDelta = 4;
    inactiveOpacity = 0.8;
    activeOpacity = 1.0;
    settings = {
      blur.strength = 5;
    };
  };

  # Audio
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # SSH
  services.openssh.enable = true;

  # User
  users.users.gg = {
    isNormalUser = true;
    description = "gg";
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$EPJfgbs1f1$OCWvyexDJMXOE5L3Zyl41Imu8ixVoMx.8H0RDRDFZyXXsvssrAJoAPG6qO8kmryBeGK0/U37c3SnM6T2nUsDZ.";
  };

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # NVIDIA & MESA
    nvidia nvidia-utils mesa

    # NETWORKING
    blueman bluez bluez-utils

    # BACKLIGHT & POWER
    acpilight upower

    # SHELLS
    zsh bash

    # TERMINALS
    xfce4-terminal xterm

    # AUDIO
    pavucontrol

    # FONTS
    ttf-font-awesome ttf-dejavu noto-fonts noto-fonts-emoji

    # FILESYSTEM TOOLS
    dosfstools exfat-utils ntfs-3g

    # UTILITIES
    xdg-utils xclip unzip moreutils udisks2

    # I3 ECOSYSTEM
    i3-wm i3status dmenu

    # BROWSERS
    firefox chromium torbrowser-launcher

    # PROGRAMS
    mpv htop gnupg openssh neofetch man-db flameshot spotify

    # RICE
    picom xwallpaper unclutter

    # EXTRAS
    wget vim curl cmatrix rofi xfce.thunar xfce.ristretto git zip
  ];

  programs.dconf.enable = true;

  system.stateVersion = "23.05";
}
