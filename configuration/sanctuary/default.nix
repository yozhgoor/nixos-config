{ lib, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../default.nix

    ../../modules/virtualisation.nix
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth";
      DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi";
      DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi";

      USB_AUTOSUSPEND = 0;
    };
  };

  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
    };
  };

  networking.networkmanager.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      alsa-lib
      alsa-plugins
      pipewire
      libx11
      libxcursor
      libxrandr
      libxi
      libxkbcommon
      wayland
      vulkan-loader
      mesa
      libGL
      openssl
    ];
  };

  home-manager.users.${username} = {
    imports = let
      path = /etc/nixos/secrets.nix;
    in lib.optional (builtins.pathExists path) path;

    home.packages = with pkgs; [
      android-tools
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine
  # and is used to maintain compatibility with application data (e.g. databases) created on older
  # NixOS version.
  system.stateVersion = "25.11"; # NEVER change this value after the initial install.
}
