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
  };
}
