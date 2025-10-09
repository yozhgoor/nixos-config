{ config, lib, pkgs, shared, ... }:

{
  imports = [
    ../modules/home-manager.nix

    ../modules/bash.nix
    ../modules/neovim
  ];

  users.users.${shared.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
  };

  networking.hostName = "${shared.hostname}";
  networking.firewall.enable = true;
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Brussels";

  fonts.packages = with pkgs; [
    liberation_ttf
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols
  ];

  services.openssh.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };
}
