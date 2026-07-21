{ username, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    home.stateVersion = "25.11"; # Never change this value after first installation.
  };
}
