{ inputs, config, pkgs, username, ... }:

{
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    home-manager.users.${username} = {
        home.username = "${username}";
        home.homeDirectory = "/home/${username}";

        programs.home-manager.enable = true;

        home.stateVersion = "25.11"; # Never change this value after first installation.
    };
}
