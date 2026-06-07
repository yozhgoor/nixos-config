{ colors, lib, pkgs, userFonts, username, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      xrdb
    ];

    home.file = {
      ".Xresources".text = ''
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
        *color8: #${colors.lightBlack}
        *color9: #${colors.lightRed}
        *color10: #${colors.lightGreen}
        *color11: #${colors.lightYellow}
        *color12: #${colors.lightBlue}
        *color13: #${colors.lightMagenta}
        *color14: #${colors.lightCyan}
        *color15: #${colors.lightWhite}

        xterm*faceName: ${userFonts.nerd.name}
        xterm*faceSize: 10

        xterm*internalBorder: 0
        xterm*termName: xterm-256color
        xterm*selectToClipboard: true
      '';

      ".xinitrc".text = lib.mkBefore ''
        [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
      '';
    };
  };
}
