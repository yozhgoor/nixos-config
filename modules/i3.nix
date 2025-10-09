{ config, lib, pkgs, shared, ... }:

{
  services.xserver = {
    enable = true;

    displayManager.startx.enable = true;
    windowManager.i3 = {
      enable = true;
    };
  };

  home-manager.users.${shared.username} = {
    home.packages = with pkgs; [
      xorg.xrdb
      feh
      brightnessctl
    ];

    xsession.windowManager.i3 =
      let mod = "Mod4";
    in {
      enable = true;

      config = {
        modifier = mod;

        fonts = {
          names = [ "JetBrains Mono Nerd Font" "OpenMoji Color" ];
          size = 8.0;
        };

        keybindings = {
          # Shortcuts
          "${mod}+t" = "exec ${pkgs.xterm}/bin/xterm";
          "${mod}+b" = "exec ${pkgs.firefox}/bin/firefox";
          "${mod}+d" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run";

          # Media keys
          "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86MonBrightnessUp" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
          "XF86MonBrightnessDown" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";

          # Focus
          ## Kill focused window
          "${mod}+Shift+q" = "kill";
          ## Fullscreen mode
          "${mod}+f" = "fullscreen toggle";
          ## Change focus
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";
          ## Move focused window
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          # Split
          "${mod}+h" = "split h";
          "${mod}+v" = "split v";

          # Workspaces
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 8";
          "${mod}+8" = "workspace number 9";
          "${mod}+9" = "workspace number 10";
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          "${mod}+r" = "mode resize";
        };

        modes = {
          resize = {
            Escape = "mode default";
            Left = "resize shrink width 10 px";
            Down = "resize shrink height 10 px";
            Up = "resize grow height 10 px";
            Right =  "resize grow width 10 px";
          };
        };

        window = {
          border = 0;
          titlebar = false;
          commands = [
            {
              command = "border normal";
              criteria = {
                class = "xfreerdp";
              };
            }
          ];
        };

        bars = [
          {
            position = "top";
            fonts = {
              names = [ "JetBrains Mono Nerd Font" "OpenMoji Color" ];
              size = 8.0;
            };
            statusCommand = "${pkgs.i3status}/bin/i3status";
          }
        ];

        startup = [
          {
            command = "feh --bg-fill ${./image/background-image.png}";
            always = true;
            notification = false;
          }
        ];
      };
    };

    home.file.".Xresources".text = ''
      *background: #101010
      *foreground: #ebdbb2

      ! Black
      *color0:  #282828
      ! Red
      *color1:  #cc241d
      ! Green
      *color2:  #98971a
      ! Yellow
      *color3:  #d79921
      ! Blue
      *color4:  #458588
      ! Magenta
      *color5:  #b16286
      ! Cyan
      *color6:  #689d6a
      ! Light Grey
      *color7:  #a89984
      ! Grey
      *color8:  #928374
      ! Light Red
      *color9:  #fb4934
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
      exec i3
    '';

    programs.bash = {
      profileExtra = ''
        if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
          startx
        fi
      '';
    };

    programs.i3status = {
      enable = true;
      enableDefault = false;

      general = {
        colors = true;
        color_good = "#00FF00";
        color_degraded = "#d79921";
        color_bad = "#cc241d";
        interval = 5;
      };

      modules = {
        "wireless _first_" = {
          position = 1;
          settings = {
            format_down = "W: down";
            format_up = "W: %quality at %essid";
          };
        };
        "ethernet _first_" = {
          position = 2;
          settings = {
            format_down = "E: down";
            format_up = "E: %ip";
          };
        };
        "disk /" = {
          position = 3;
          settings.format = "Disk %avail";
        };
        "cpu_usage" = {
          position = 4;
          settings.format = "CPU %usage";
        };
        "load" = {
          position = 5;
          settings.format = "Load %1min";
        };
        "memory" = {
          position = 6;
          settings = {
            format = "MEM %used | %available";
            format_degraded = "MEMORY < %available";
            threshold_degraded = "1G";
          };
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
