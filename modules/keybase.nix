{ username, ... }:

{
  programs.fuse.enable = true;

  home-manager.users.${username} = {
    services.keybase.enable = true;
    services.kbfs.enable = true;
  };
}
