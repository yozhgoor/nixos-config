{ colors, pkgs, term, userFonts, username, ... }:

{
  services.xserver.windowManager.i3.enable = true;

  home-manager.users.${username} = {
    home.file.".xinitrc".text = ''
      exec i3
    '';

    home.packages = with pkgs; [
      feh
      brightnessctl
      i3lock
      xss-lock
    ];

    xsession.windowManager.i3 = let
      mod = "Mod4";
    in {
      enable = true;

      config = {
        modifier = mod;

        fonts = {
          names = [
            userFonts.nerd.name
            userFonts.symbols.name
          ];
          size = 8.0;
        };

        keybindings = {
          "${mod}+t" = "exec ${term.package}/bin/${term.name}";
          "${mod}+b" = "exec ${pkgs.firefox}/bin/firefox";
          "${mod}+d" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run";
          "${mod}+Shift+l" = "exec ${pkgs.i3lock}/bin/i3lock --color ${colors.background}";
          "${mod}+Shift+q" = "kill";

          "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86MonBrightnessUp" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
          "XF86MonBrightnessDown" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";

          "${mod}+Left" = "focus left";
          "${mod}+Right" = "focus right";
          "${mod}+Up" = "focus up";
          "${mod}+Down" = "focus down";
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Right" = "move right";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Down" = "move down";

          "${mod}+f" = "fullscreen toggle";
          "${mod}+h" = "split h";
          "${mod}+v" = "split v";
          "${mod}+r" = "mode resize";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

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
        };
        modes = {
          resize = {
            Escape = "mode default";
            Left = "resize shrink width 10 px";
            Right = "resize grow width 10 px";
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
            command = "i3-msg workspace number 1";
            notification = false;
          }
          {
            command = "${pkgs.feh}/bin/feh --bg-fill ${../../img/background-image.png}";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.xss-lock}/bin/xss-lock -- ${pkgs.i3lock}/bin/i3lock --nofork --color ${colors.background}";
            notification = false;
          }
        ];
        bars = [
          {
            position = "top";
            fonts = {
              names = [ userFonts.nerd.name userFonts.symbols.name ];
              size = 8.0;
            };
            statusCommand = "${pkgs.i3status}/bin/i3status";
          }
        ];
      };
    };
  };
}
