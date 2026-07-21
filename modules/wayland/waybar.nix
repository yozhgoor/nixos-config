{ colors, userFonts, username, ... }:

{
  home-manager.users.${username} = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 16;
          spacing = 0;
          modules-left = ["sway/workspaces"];
          modules-right = [
            "wireplumber"
            "backlight"
            "cpu"
            "load"
            "memory"
            "disk"
            "temperature"
            "network"
            "battery"
            "clock"
            "tray"
          ];

          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = false;
          };

          wireplumber = {
            format = "{icon} {volume}% |";
            format-muted = " ";
            format-source = "󰍬 {volume}%";
            format-source-muted = "󰍭";
            format-icons = {
              default = [ " " " " " " ];
              headphone = "󰋋 ";
              headset = "󰋎 ";
            };
          };
          backlight = {
            format = "{icon}{percent}% |";
            format-icons = [ "󰃞 " "󰃟 " "󰃠 "];
            on-scroll-up = "";
            on-scroll-down = "";
            tooltip = false;
          };
          cpu = {
            format = "  {usage}% |";
            tooltip = false;
          };
          load = {
            format = "  {load1}/{load5} |";
            tooltip = false;
          };
          memory = {
            format = "  {}% |";
            tooltip = false;
          };
          disk = {
            format = " {specific_free:0.0f}GB |";
            unit = "GB";
            tooltip = false;
          };
          temperature = {
            format = "{icon} {temperatureC}°C |";
            format-icons = [ "" "" "" "" ];
            tooltip = false;
          };
          network = {
            format-wifi = "{icon}{essid} ({signalStrength}%) |";
            format-ethernet = "󰈀 {ipaddr}";
            format-disconnected = "󰤭  down";
            format-icons = [ "󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
            tooltip = false;
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}% |";
            format-plugged = " |";
            format-charging = "󰂄 {capacity}% |";
            format-critical = "󰂎 {capacity}% |";
            format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            tooltip = false;
          };
          clock = {
            format = "󰥔 {:%d-%m-%Y %H:%M}";
            tooltip = false;
          };
          tray = {
            spacing = 1;
            tooltip = false;
          };
        };
      };

      style = ''
        * {
          font-family: "${userFonts.nerd.name}", "${userFonts.symbols.name}";
          font-size: 12px;
          min-height: 0;
        }

        window#waybar {
          background: #${colors.background};
          color: #${colors.foreground};
        }

        #workspaces button {
          padding: 0 0px;
          color: #${colors.foreground};
          background: transparent;
          border: none;
        }

        #workspaces button.focused {
          color: #${colors.background};
          background: #${colors.green};
        }

        #workspaces button.urgent {
          color: #${colors.background};
          background: #${colors.orange};
        }

        #wireplumber, #backlight, #cpu, #load, #memory, #disk, #temperature, #network, #battery, #clock, #tray {
          margin: 0 0px;
          padding: 0 4px;
        }

        #battery.warning { color: #${colors.orange}; }
        #battery.critical { color: #${colors.red}; }
      '';
    };
  };
}
