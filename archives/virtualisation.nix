{ pkgs, username, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
    qemu.vhostUserPackages = [ pkgs.virtiofsd ];
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    swtpm
  ];

  users.users.${username}.extraGroups = [ "libvirtd" ];

  home-manager.users.${username} = {
    home.sessionVariables = {
      LIBVIRT_DEFAULT_URI = "qemu:///session";
    };

    home.file.".local/bin/vm" = {
      executable = true;
      text = ''
        #!/bin/sh
        ${pkgs.libvirt}/bin/virsh start win11 2>/dev/null || true

        ${pkgs.virt-viewer}/bin/virt-viewer --wait win11

        ${pkgs.libvirt}/bin/virsh shutdown win11
      '';
    };
  };
}
