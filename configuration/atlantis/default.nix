{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common.nix

    ../../home-manager/atlantis.nix
    ../../modules/wayland
    ../../modules/steam.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics.enable = true;

  system.stateVersion = "26.05";
}
