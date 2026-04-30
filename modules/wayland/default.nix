{ pkgs, colors, userFonts, username, ... }:

{
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      bemenu
      wl-clipboard
      grim
      slurp
      swaybg
      swayidle
      swaylock
      brightnessctl
    ];

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      xwayland = false;

      config = {
        modifier = "Mod4";
        terminal = "${pkgs.alacritty}/bin/alacritty";
        menu = "${pkgs.bemenu}/bin/bemenu-run";
        bars = [];
        fonts = {
          names = [ userFonts.nerd.name userFonts.symbols.name ];
          size = 10.0;
        };
        keybindings = {
          "Mod4+t" = "exec ${pkgs.alacritty}/bin/alacritty";
          "Mod4+b" = "exec ${pkgs.firefox}/bin/firefox";
          "Mod4+d" = "exec ${pkgs.bemenu}/bin/bemenu-run";
          "Mod4+Shift+l" = "exec ${pkgs.swaylock}/bin/swaylock -c ${colors.background}";
          "Mod4+Shift+q" = "kill";

          "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute" = "exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86MonBrightnessUp" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
          "XF86MonBrightnessDown" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";

          "Mod4+Left" = "focus left";
          "Mod4+Right" = "focus right";
          "Mod4+Up" = "focus up";
          "Mod4+Down" = "focus down";
          "Mod4+Shift+Left" = "move left";
          "Mod4+Shift+Right" = "move right";
          "Mod4+Shift+Up" = "move up";
          "Mod4+Shift+Down" = "move down";

          "Mod4+f" = "fullscreen toggle";
          "Mod4+h" = "split h";
          "Mod4+v" = "split v";

          "Mod4+1" = "workspace number 1";
          "Mod4+2" = "workspace number 2";
          "Mod4+3" = "workspace number 3";
          "Mod4+4" = "workspace number 4";
          "Mod4+5" = "workspace number 5";
          "Mod4+6" = "workspace number 6";
          "Mod4+7" = "workspace number 7";
          "Mod4+8" = "workspace number 8";
          "Mod4+9" = "workspace number 9";
          "Mod4+0" = "workspace number 10";

          "Mod4+Shift+1" = "move container to workspace number 1";
          "Mod4+Shift+2" = "move container to workspace number 2";
          "Mod4+Shift+3" = "move container to workspace number 3";
          "Mod4+Shift+4" = "move container to workspace number 4";
          "Mod4+Shift+5" = "move container to workspace number 5";
          "Mod4+Shift+6" = "move container to workspace number 6";
          "Mod4+Shift+7" = "move container to workspace number 7";
          "Mod4+Shift+8" = "move container to workspace number 8";
          "Mod4+Shift+9" = "move container to workspace number 9";
          "Mod4+Shift+0" = "move container to workspace number 10";
        };

        startup = [
          {
            command = "${pkgs.swaybg}/bin/swaybg -i ${../../img/background-image.png} -m fill";
            always = true;
          }
          {
            command = "${pkgs.swayidle}/bin/swayidle -w timeout 300 '${pkgs.swaylock}/bin/swaylock -c ${colors.background}' timeout 600 '${pkgs.sway}/bin/swaymsg \"output * dpms off\"' resume '${pkgs.sway}/bin/swaymsg \"output * dpms on\"' before-sleep '${pkgs.swaylock}/bin/swaylock -c ${colors.background}'";
            always = true;
          }
          {
            command = "${pkgs.waybar}/bin/waybar";
            always = true;
          }
        ];

        window = {
          border = 0;
          titlebar = false;
        };
      };
    };

    programs.bash.profileExtra = ''
      if [[ -z "$DISPLAY" ]] && [[ -z "$WAYLAND_DISPLAY" ]] && [[ "$(tty)" = /dev/tty1 ]]; then
        exec sway
      fi
    '';
  };
}
