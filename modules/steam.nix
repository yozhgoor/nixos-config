{ pkgs, username, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      steam
      mangohud
    ];

    home.file.".local/bin/120hz" = {
      executable = true;
      text = ''
        #!/bin/sh
        # Set display to 120Hz, run a command, then restore 60Hz.
        # Usage: 120hz [output] command...
        #   output   Optional display name (e.g. DP-2). Defaults to focused output.

        if echo "$1" | grep -qE '^(DP|HDMI|eDP|VGA|LVDS)-'; then
            output="$1"
            shift
        else
            output=$(${pkgs.sway}/bin/swaymsg -t get_outputs \
                | grep -B1 '"focused": true' \
                | head -1 \
                | sed 's/.*"name": "\([^"]*\)".*/\1/')
        fi

        ${pkgs.sway}/bin/swaymsg output "$output" mode 1920x1080@120Hz

        "$@"

        ${pkgs.sway}/bin/swaymsg output "$output" mode 1920x1080@60Hz
      '';
    };

    home.file.".config/MangoHud/MangoHud.conf".text = ''
      legacy_layout=0
      horizontal
      hud_compact
      font_size=16
      background_alpha=0.0

      fps
      cpu_stats
      gpu_stats
      ram
      vram

      frametime=0
    '';

    home.file.".config/MangoHud/presets.conf".text = ''
      [preset 1]
      fps_only
      font_size=16
    '';
  };
}
