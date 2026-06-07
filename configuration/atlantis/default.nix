{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../default.nix

    ../../modules/steam.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.libinput.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine
  # and is used to maintain compatibility with application data (e.g. databases) created on older
  # NixOS version.
  system.stateVersion = "25.11"; # NEVER change this value after the initial install.
}
