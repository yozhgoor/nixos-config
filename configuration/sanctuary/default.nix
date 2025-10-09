{ inputs, config, pkgs, shared, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../default.nix

    ../../modules/git.nix
    ../../modules/i3.nix
    ../../modules/markdown.nix
    ../../modules/firefox.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    grub.enable = false;
    efi.canTouchEfiVariables = true;
  };

  networking.networkmanager.enable = true;
  users.users.${shared.username}.extraGroups = [ "networkmanager" ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      START_CHARGE_THRESH_BAT0 = 50;
      STOP_CHARGE_THRESH_BAT0 = 80;

      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth wifi";
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

  home-manager.users.${shared.username} = {
    home.packages = with pkgs; [
      spotify
      telegram-desktop
      flameshot
      discord
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "24.11"; # NEVER change this value after the initial install.
}
