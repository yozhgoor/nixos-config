{ colors, hostname, username, ... }:

{
  home-manager.users.${username} = {
    programs.i3status = {
      enable = true;
      enableDefault = false;

      general = {
        colors = true;
        color_good = "#${colors.green}";
        color_degraded = "#${colors.orange}";
        color_bad = "#${colors.red}";
        interval = 5;
      };

      modules = let
        isAtlantis = hostname == "atlantis";

        sharedModules = {
          "ethernet _first_" = {
            position = if isAtlantis then 1 else 2;
            settings = {
              format_up = "󰈀 %ip";
              format_down = "󰈀 down";
            };
          };
          "cpu_usage" = {
            position = if isAtlantis then 2 else 3;
            settings.format = "  %usage";
          };
          "load" = {
            position = if isAtlantis then 3 else 4;
            settings.format = "  %1min/%5min";
          };
          "memory" = {
            position = if isAtlantis then 4 else 5;
            settings = {
              format = "  %used/%available";
              format_degraded = "  < %available";
              threshold_degraded = "4G";
            };
          };
          "disk /" = {
            position = if isAtlantis then 5 else 6;
            settings.format = "  %avail";
          };
          "time" = {
            position = if isAtlantis then 6 else 8;
            settings.format = "󰥔 %d-%m-%Y %H:%M";
          };
        };
      in if isAtlantis then sharedModules else sharedModules // {
        "wireless _first_" = {
          position = 1;
          settings = {
            format_up = "󰤨 %quality at %essid";
            format_down = "󰤨 down";
          };
        };
        "battery all" = {
          position = 7;
          settings = {
            format = "󰁹 %status %percentage";
            low_threshold = 30;
            threshold_type = "percentage";
          };
        };
      };
    };
  };
}
