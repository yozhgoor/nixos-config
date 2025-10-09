# Default configuration for Sway
{ inputs, config, pkgs, shared, ... }:

{
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  hardware.graphics.enable = true;

  home-manager.users.${shared.username} = {
    imports = [
      ./keybindings.nix
      ./waybar.nix
      ./wofi.nix
    ];

    home.packages = with pkgs; [
      swayidle
      swaylock

      grim
      slurp
      swappy

      brightnessctl
      wl-clipboard
    ];

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config = rec {
        modifier = "Mod4";
        fonts = {
          names = [ "Jetbrains Mono" ];
          size = 10.0;
        };
        window = {
          border = 0;
          titlebar = false;
        };
        bars = [{
          command = "${pkgs.waybar}/bin/waybar";
          fonts = {
            names = [ "Jetbrains Mono" ];
            size = 9.0;
          };
        }];
        output = {
          "eDP-1" = {
            mode = "1920x1080@60hz";
            position = "1920 0";
            bg = "path/to/background fill";
          };
          "DP-2" = {
            mode = "1920x1080@60hz";
            position = "0 0";
            bg = " path/to/background fill";
          };
        };
        defaultWorkspace = "workspace number 1";
      };
      extraConfig = ''
        # Clamshell mode
        bindswitch --reload --locked lid:on output eDP-1 disable
        bindswitch --reload --locked lid:off output eDP-1 enable
        exec_always --no-startup-id ~/.config/sway/clamshell.sh

        # Idle configuration
        exec --no-startup-id ~/.config/sway/idle.sh
      '';
    };

    home.file = {
      ".config/sway/clamshell.sh" = {
        executable = true;
        text = ''
          #!/bin/sh

          LAPTOP_OUTPUT="eDP-1"
          LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

          read -r LID_STATE < "$LID_STATE_FILE"

          case "$LID_STATE" in
              *open*)
                  swaymsg output "$LAPTOP_OUTPUT" enable
                  ;;
              *closed*)
                  swaymsg output "$LAPTOP_OUTPUT" disable
                  ;;
              *)
                  echo "Could not get lid state" >&2
                  exit 1
                  ;;
          esac
        '';
      };
      ".config/sway/idle.sh" = {
        executable = true;
        text = ''
          #!/bin/sh

          if [ "$(cat /sys/class/power_supply/AC/online)" == "0" ]; then
            swayidle -w \
                timeout 900 'swaylock -f -c 000000' \
                timeout 900 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
                before-sleep 'swaylock -f -c 000000'
          fi
        '';
      };
    };

    programs.bash = {
      profileExtra = ''
        if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
          exec sway
        fi
      '';
    };
  };
}
