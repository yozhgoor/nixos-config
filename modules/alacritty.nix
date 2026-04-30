{ colors, userFonts, username, ... }:

{
  home-manager.users.${username} = {
    programs.alacritty = {
      enable = true;
      settings = {
        window.decorations = "None";
        font = {
          normal = {
            family = "${userFonts.nerd.name}";
            style = "Regular";
          };
          size = 10.0;
        };
        colors = {
          primary = {
            foreground = "#${colors.foreground}";
            background = "#${colors.background}";
          };
          normal = {
            black = "#${colors.black}";
            red = "#${colors.red}";
            green = "#${colors.green}";
            yellow = "#${colors.yellow}";
            blue = "#${colors.blue}";
            magenta = "#${colors.magenta}";
            cyan = "#${colors.cyan}";
            white = "#${colors.white}";
          };
          bright = {
            black = "#${colors.brightBlack}";
            red = "#${colors.brightRed}";
            green = "#${colors.brightGreen}";
            yellow = "#${colors.brightYellow}";
            blue = "#${colors.brightBlue}";
            magenta = "#${colors.brightMagenta}";
            cyan = "#${colors.brightCyan}";
            white = "#${colors.brightWhite}";
          };
        };
        selection.save_to_clipboard = true;
      };
    };
  };
}
