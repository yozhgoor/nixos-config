{ ... }:

{
  home-manager.users.${username} = {
    programs.i3status = {
      enable = true;
      enableDefault = false;

      general = {
        colors = true;
        color_good = "#${colors.brightGreen}";
        color_degraded = "#${colors.brightOrange}";
        color_bad = "#${colors.brightRed}";
        interval = 5;
      };

      modules = {
        "wireless _first_" = {
          position = 1;
          settings = {
            format_up = "W: %quality at %essid";
            format_down = "W: down";
          };
        };
        "ethernet _first_" = {
          position = 2;
          settings = {
            format_up = "E: %ip";
            format_down = "E: down";
          };
        };
        "cpu_usage" = {
          position = 3;
          settings.format = "CPU %usage";
        };
        "load" = {
          position = 4;
          settings.format = "Load %1min/%5min";
        };
        "memory" = {
          position = 5;
          settings = {
            format = "MEM %used/%available";
            format_degraded = "MEM < %available";
            threshold_degraded = "4G";
          };
        };
        "disk /" = {
          position = 6;
          settings.format = "Disk %avail";
        };
        "battery all" = {
          position = 7;
          settings = {
            format = "%status %percentage";
            low_threshold = 30;
            threshold_type = "percentage";
          };
        };
        "time" = {
          position = 8;
          settings.format = "%d-%m-%Y %H:%M";
        };
      };
    };
  };
}
