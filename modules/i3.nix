{ config, lib, pkgs, username, ... }:

{
    imports = [
        ./xorg.nix
    ];

    services.xserver.windowManager.i3.enable = true;

    home-manager.users.${username} = {
        home.file.".xinitrc".text = ''
            exec i3
        '';

        home.packages = with pkgs; [
            feh
            brightnessctl
        ];

        xsession.windowManager.i3 = let
            mod = "Mod4";
        in {
            enable = true;

            config = {
                modifier = mod;

                fonts = {
                    names = [ "JetBrains Mono Nerd Font" "Symbols Nerd Font" ];
                    size = 8.0;
                };

                keybindings = {
                    "${mod}+t" = "exec ${pkgs.xterm}/bin/xterm";
                    "${mod}+b" = "exec ${pkgs.firefox}/bin/firefox";
                    "${mod}+d" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run";

                    "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
                    "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-";
                    "XF86AudioMute" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                    "XF86AudioMicMute" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
                    "XF86MonBrightnessUp" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
                    "XF86MonBrightnessDown" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";

                    "${mod}+Shift+q" = "kill";
                    "${mod}+f" = "fullscreen toggle";
                    "${mod}+Left" = "focus left";
                    "${mod}+Right" = "focus right";
                    "${mod}+Up" = "focus up";
                    "${mod}+Down" = "focus down";
                    "${mod}+Shift+Left" = "move left";
                    "${mod}+Shift+Right" = "move right";
                    "${mod}+Shift+Up" = "move up";
                    "${mod}+Shift+Down" = "move down";

                    "${mod}+h" = "split h";
                    "${mod}+v" = "split v";

                    "${mod}+1" = "workspace number 1";
                    "${mod}+2" = "workspace number 2";
                    "${mod}+3" = "workspace number 3";
                    "${mod}+4" = "workspace number 4";
                    "${mod}+5" = "workspace number 5";
                    "${mod}+6" = "workspace number 6";
                    "${mod}+7" = "worksapce number 7";
                    "${mod}+8" = "workspace number 8";
                    "${mod}+9" = "workspace number 9";
                    "${mod}+0" = "worksapce number 10";

                    "${mod}+Shift+1" = "move container to workspace number 1";
                    "${mod}+Shift+2" = "move container to workspace number 2";
                    "${mod}+Shift+3" = "move container to workspace number 3";
                    "${mod}+Shift+4" = "move container to workspace number 4";
                    "${mod}+Shift+5" = "move container to workspace number 5";
                    "${mod}+Shift+6" = "move container to workspace number 6";
                    "${mod}+Shift+7" = "move container to worksapce number 7";
                    "${mod}+Shift+8" = "move container to workspace number 8";
                    "${mod}+Shift+9" = "move container to workspace number 9";
                    "${mod}+Shift+0" = "move container to worksapce number 10";

                    "${mod}+r" = "mode resize";
                };
                modes = {
                    resize = {
                        Escape = "mode default";
                        Left = "resize shrink width 10 px";
                        Right = "resize grwo width 10 px";
                        Up = "resize grow height 10 px";
                        Down = "resize shrink height 10 px";
                    };
                };
                window = {
                    border = 0;
                    titlebar = false;
                };
                startup = [
                    {
                        command = "${pkgs.feh}/bin/feh --bg-fill ${./img/background-image.png}";
                        always = true;
                        notification = false;
                    }
                ];
                bars = [
                    {
                        position = "top";
                        fonts = {
                            names = [ "JetBrains Mono Nerd Font" "Symbols Nerd Font" ];
                            size = 8.0;
                        };
                        statusCommand = "${pkgs.i3status}/bin/i3status";
                    }
                ];
            };
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
