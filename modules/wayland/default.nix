{ colors, pkgs, term, userFonts, username, ... }:

{
  imports = [
    ./waybar.nix
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    config.common.default = "*";
  };

  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  home-manager.users.${username} = {
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
    };

    home.packages = with pkgs; [
      wmenu
      wl-clipboard

      swaybg
      swayidle
      swaylock

      brightnessctl

      grim
      slurp
    ];

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      xwayland = true;

      config = {
        modifier = "Mod4";
        terminal = "${term.package}/bin/${term.name}";
        menu = "${pkgs.wmenu}/bin/wmenu-run";
        bars = [];
        fonts = {
          names = [ userFonts.nerd.name userFonts.symbols.name ];
          size = 10.0;
        };
        output = {
          "eDP-1" = {
            position = "1920 0";
          };
          "DP-1" = {
            position = "0 0";
          };
        };
        keybindings = {
          "Mod4+t" = "exec ${term.package}/bin/${term.name}";
          "Mod4+b" = "exec ${pkgs.firefox}/bin/firefox";
          "Mod4+d" = "exec ${pkgs.wmenu}/bin/wmenu-run";
          "Mod4+Shift+l" = "exec ${pkgs.swaylock}/bin/swaylock -f -c ${colors.background}";
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
            command = "${pkgs.sway}/bin/swaymsg workspace number 1";
          }
          {
            command = "${pkgs.swaybg}/bin/swaybg -i ${../../images/background-image.png} -m fill";
          }
          {
            command = "${pkgs.waybar}/bin/waybar";
          }
          {
            command = ''
              ${pkgs.swayidle}/bin/swayidle -w \
                timeout 300 '${pkgs.swaylock}/bin/swaylock -f -c ${colors.background}' \
                timeout 600 '${pkgs.sway}/bin/swaymsg "output * dpms off"' \
                resume '${pkgs.sway}/bin/swaymsg "output * dpms on"' \
                before-sleep '${pkgs.swaylock}/bin/swaylock -f -c ${colors.background}'
            '';
          }
        ];

        window = {
          border = 0;
          titlebar = false;
        };
      };
    };

    home.file.".local/bin/screenshot" = {
      executable = true;
      text = ''
        #!/bin/sh

        if [ "$1" = "--save" ]; then
          mkdir -p "$HOME/screenshots"

          ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - \
            | tee "$HOME/screenshots/$(date -Iseconds).png" \
            | ${pkgs.wl-clipboard}/bin/wl-copy
        else
          ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy
        fi
      '';
    };

    programs.bash.profileExtra = ''
      if [[ -z "$DISPLAY" ]] && [[ -z "$WAYLAND_DISPLAY" ]] && [[ "$(tty)" = /dev/tty1 ]]; then
        exec sway
      fi
    '';
  };
}
