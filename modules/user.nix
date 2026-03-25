{ username, ... }:

{
    users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" ];
    };

    home-manager.users.${username} = {
        xdg.userDirs = let
            base = "/home/${username}";
        in {
            enable = true;
            createDirectories = true;
            download = "${base}/downloads";
            desktop = base;
            documents = base;
            music = base;
            pictures = base;
            publicShare = base;
            templates = base;
            videos = base;
        };
    };
}
