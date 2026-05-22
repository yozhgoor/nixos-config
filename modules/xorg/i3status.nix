{ colors, username, ... }:

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

      modules = {
        "ethernet _first_" = {
          position = 1;
          settings = {
            format_up = "E: %ip";
            format_down = "E: down";
          };
        };
        "cpu_usage" = {
          position = 2;
          settings.format = "CPU %usage";
        };
        "load" = {
          position = 3;
          settings.format = "Load %1min/%5min";
        };
        "memory" = {
          position = 4;
          settings = {
            format = "MEM %used/%available";
            format_degraded = "MEM < %available";
            threshold_degraded = "4G";
          };
        };
        "disk /" = {
          position = 5;
          settings.format = "Disk %avail";
        };
        "time" = {
          position = 6;
          settings.format = "%d-%m-%Y %H:%M";
        };
      };
    };
  };
}
