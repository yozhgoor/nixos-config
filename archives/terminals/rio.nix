{ colors, pkgs, userFonts, username, ... }:

{
  home-manager.users.${username} = {
    programs.rio = {
      enable = true;
      settings = {
        force-theme = "dark";
        colors = {
          background = "#${colors.background}";
          foreground = "#${colors.foreground}";

          black = "#${colors.black}";
          red = "#${colors.red}";
          green = "#${colors.green}";
          yellow = "#${colors.yellow}";
          blue = "#${colors.blue}";
          magenta = "#${colors.magenta}";
          cyan = "#${colors.cyan}";
          white = "#${colors.white}";

          cursor = "#${colors.foreground}";

          tabs = "#${colors.foreground}";
          tabs-active = "#${colors.lightForeground}";
          bar = "#${colors.background}";
          split = "#${colors.lightBackground}";

          hint-foreground = "#${colors.background}";
          hint-background = "#${colors.lightYellow}";

          selection-foreground = "#${colors.background}";
          selection-background = "#${colors.lightBlue}";

          light-foreground = "#${colors.lightForeground}";
          light-black = "#${colors.lightBlack}";
          light-red = "#${colors.lightRed}";
          light-green = "#${colors.lightGreen}";
          light-yellow = "#${colors.lightYellow}";
          light-blue = "#${colors.lightBlue}";
          light-magenta = "#${colors.lightMagenta}";
          light-cyan = "#${colors.lightCyan}";
          light-white = "#${colors.lightWhite}";
        };
        confirm-before-quit = false;
        copy-on-select = true;
        editor.program = "${pkgs.neovim}/bin/nvim";
        fonts.family = "${userFonts.nerd.name}";
        navigation = {
          mode = "Plain";
          use-split = false;
        };
        enable-scroll-bar = false;
        window.decorations = "Disabled";
      };
    };
  };
}
