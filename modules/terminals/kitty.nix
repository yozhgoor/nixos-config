{ colors, pkgs, userFonts, username, ... }:

{
  home-manager.users.${username} = {
    programs.kitty = {
      enable = true;
      font = {
        name = "${userFonts.nerd.name}";
        size = 10.0;
      };
      settings = {
        scrollbar = "never";

        url_color = "#${colors.lightOrange}";
        url_style = "straight";
        open_url_with = "${pkgs.firefox}/bin/firefox";

        copy_on_select = "clipboard";

        enable_audio_bell = "no";

        hide_window_decorations = "yes";

        confirm_os_window_close = 0;

        foreground = "#${colors.foreground}";
        background = "#${colors.background}";

        cursor = "#${colors.foreground}";

        selection_foreground = "#${colors.background}";
        selection_background = "#${colors.lightBlue}";

        color0 = "#${colors.black}";
        color1 = "#${colors.red}";
        color2 = "#${colors.green}";
        color3 = "#${colors.yellow}";
        color4 = "#${colors.blue}";
        color5 = "#${colors.magenta}";
        color6 = "#${colors.cyan}";
        color7 = "#${colors.white}";

        color8 = "#${colors.lightBlack}";
        color9 = "#${colors.lightRed}";
        color10 = "#${colors.lightGreen}";
        color11 = "#${colors.lightYellow}";
        color12 = "#${colors.lightBlue}";
        color13 = "#${colors.lightMagenta}";
        color14 = "#${colors.lightCyan}";
        color15 = "#${colors.lightWhite}";
      };
    };
  };
}
