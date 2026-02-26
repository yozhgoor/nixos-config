{ config, lib, pkgs, username, userFonts, colors, ... }:

{
    services.xserver = {
        enable = true;
        displayManager.startx.enable = true;
    };

    home-manager.users.${username} = {
        home.packages = with pkgs; [
            xrdb
            xsel
        ];

        home.file.".Xresources".text = ''
            *background: #${colors.background}
            *foreground: #${colors.foreground}

            *color0: #${colors.black}
            *color1: #${colors.red}
            *color2: #${colors.green}
            *color3: #${colors.yellow}
            *color4: #${colors.blue}
            *color5: #${colors.magenta}
            *color6: #${colors.cyan}
            *color7: #${colors.white}
            *color8: #${colors.brightBlack}
            *color9: #${colors.brightRed}
            *color10: #${colors.brightGreen}
            *color11: #${colors.brightYellow}
            *color12: #${colors.brightBlue}
            *color13: #${colors.brightMagenta}
            *color14: #${colors.brightCyan}
            *color15: #${colors.brightWhite}

            xterm*faceName: ${userFonts.nerd.name}
            xterm*faceSize: 10

            xterm*internalBorder: 0
            xterm*termName: xterm-256color
            xterm*selectToClipboard: true
        '';

        home.file.".xinitrc".text = ''
            [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
        '';

        programs.bash = {
            profileExtra = ''
                if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
                    startx
                fi
            '';
        };
    };
}
