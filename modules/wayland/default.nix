{ colors, lib, pkgs, term, userFonts, username, ... }:

let
  lock = "${pkgs.swaylock}/bin/swaylock -f -c ${colors.background}";
in {
  imports = [
    ./waybar.nix
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
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
        terminal = term.bin;
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
          "Mod4+t" = "exec ${term.bin}";
          "Mod4+b" = "exec ${pkgs.firefox}/bin/firefox";
          "Mod4+d" = "exec ${pkgs.wmenu}/bin/wmenu-run";
          "Mod4+Shift+l" = "exec ${lock}";
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

        } // builtins.listToAttrs (lib.concatMap (i: let
          ws = toString i;
          key = toString (lib.mod i 10);
        in [
          { name = "Mod4+${key}"; value = "workspace number ${ws}"; }
          { name = "Mod4+Shift+${key}"; value = "move container to workspace number ${ws}"; }
        ]) (lib.range 1 10));

        startup = [
          {
            command = "${pkgs.sway}/bin/swaymsg workspace number 1";
          }
          {
            command = "${pkgs.swaybg}/bin/swaybg -i ${../../images/background-image.png} -m fill";
          }
          {
            command = ''
              ${pkgs.swayidle}/bin/swayidle -w \
                timeout 600 '${lock}' \
                timeout 660 '${pkgs.sway}/bin/swaymsg "output * dpms off"' \
                resume '${pkgs.sway}/bin/swaymsg "output * dpms on"' \
                before-sleep '${lock}'
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
          mkdir -p "$HOME/pictures/screenshots"

          ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - \
            | tee "$HOME/pictures/screenshots/$(date -Iseconds).png" \
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
