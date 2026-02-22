{ config, lib, pkgs, username, ... }:

{
    home-manager.users.${username} = {
        programs.git = {
            enable = true;
            settings = {
                user = {
                    name = "${username}";
                    email = "${username}@outlook.com";
                };
                core = {
                    editor = "nvim";
                    excludesFiles = "~/.gitignore_global";
                };
                push.autoSetupRemote = true;
                pull = {
                    ff = "only";
                    rebase = false;
                };
                fetch.prune = true;
                init.defaultBranch = "main";
                url = {
                    "git@github.com:".insteadOf = "https://github.com/";
                };
            };
        };

        home.file.".gitignore_global".text = ''
            debug/
            target/
            **/*.rs.bk
        '';
    };
}
