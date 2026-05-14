{ colors, pkgs, username, ... }:

{
  home-manager.users.${username} = {
    programs.spotify-player = {
      enable = true;
      themes = [
        {
          name = "gruvbox";
          palette = {
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
            bright_black = "#${colors.lightBlack}";
            bright_red = "#${colors.lightRed}";
            bright_green = "#${colors.lightGreen}";
            bright_yellow = "#${colors.lightYellow}";
            bright_blue = "#${colors.lightBlue}";
            bright_magenta = "#${colors.lightMagenta}";
            bright_cyan = "#${colors.lightCyan}";
            bright_white = "#${colors.lightWhite}";
          };
          component_style = {
            block_title = { fg = "#${colors.foreground}"; };
          };
        }
      ];
      settings = {
        theme = "gruvbox";
        playback_format = "{status} {track} - {artists}\n{metadata}";
        playback_metadata_fields = ["shuffle" "volume"];
        device = {
          volume = 100;
        };
        layout = {
          library.album_percent = 0;
          library.playlist_percent = 80;
          playback_window_position = "Bottom";
        };
      };
    };
  };
}
