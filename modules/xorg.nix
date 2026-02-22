{ config, lib, pkgs, username, fonts, ... }:

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
            *background: #101010
            *foreground: #ebdbb2

            ! Black
            *color0: #282828
            ! Red
            *color1: #cc241d
            ! Green
            *color2: #98971a
            ! Yellow
            *color3: #d79921
            ! Blue
            *color4: #458588
            ! Magenta
            *color5: #b16286
            ! Cyan
            *color6: #689d6a
            ! Light Grey
            *color7: #a89984
            ! Grey
            *color8: #928374
            ! Light Red
            *color9: #fb4934
            ! Light Green
            *color10: #b8bb26
            ! Light Yellow
            *color11: #fabd2f
            ! Light Blue
            *color12: #83a598
            ! Light Magenta
            *color13: #d3869b
            ! Light Cyan
            *color14: #8ec07c
            ! White
            *color15: #ebdbb2

            xterm*faceName: JetBrains Mono Nerd Font
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
