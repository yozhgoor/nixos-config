{ config, lib, pkgs, username, ... }:

{
    home-manager.users.${username} = {
        home.packages = with pkgs; [
            bat
            ripgrep
        ];

        programs.bash = {
            enable = true;
            shellAliases = {
                ls = "ls --color=auto";
                grep = "rg";
                cat = "bat --decorations never --theme gruvbox-dark";
                term = "$(ps -o comm= -p $PPID) & disown";
            };
        };

        programs.starship = {
            enable = true;
            settings = {
                add_newline = false;
                character = {
                    format = "[](bold #00FF00) ";
                    success_symbol = "[](bold green) ";
                    error_symbol = "[](bold red) ";
                };
                package.disabled = true;
            };
        };
    };
}
