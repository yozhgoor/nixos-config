{ username, ... }:

{
  home-manager.users.${username} = {
    home.file.".local/bin/monitors" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        INTERNAL_DISPLAY="eDP-1"
        EXTERNAL_DISPLAY_CANDIDATES=("DP-1" "DP-2" "HDMI-1")

        INTERNAL_AUDIO_NAME="Ryzen HD Audio Controller"
        EXTERNAL_AUDIO_NAME="Renoir/Cezanne HDMI/DP Audio Controller"

        find_external_display() {
            for output in "''${EXTERNAL_DISPLAY_CANDIDATES[@]}"; do
                # Check if the output is connected (not just present)
                if xrandr | grep -q "^''${output} connected"; then
                    echo "$output"
                    return 0
                fi
            done
            echo ""
        }

        find_audio_sink() {
            local name="$1"
            wpctl status | grep -A 30 "Audio" | grep "Sinks" -A 20 | \
                grep "$name" | grep -oP '^\s+\K\d+' | head -1
        }

        set_display() {
            local mode="$1"
            local ext="''${2:-}"

            case "$mode" in
                laptop)
                    echo "→ Display: laptop only"
                    xrandr --output "$INTERNAL_DISPLAY" --auto --primary \
                           ''${ext:+--output "$ext" --off}
                    ;;
                both)
                    echo "→ Display: laptop + external ($ext)"
                    xrandr --output "$INTERNAL_DISPLAY" --auto --primary \
                           --output "$ext" --auto --right-of "$INTERNAL_DISPLAY"
                    ;;
                external)
                    echo "→ Display: external only ($ext)"
                    xrandr --output "$INTERNAL_DISPLAY" --off \
                           --output "$ext" --auto
                    ;;
            esac
        }

        set_audio() {
            local sink_name="$1"
            local label="$2"
            local sink_id
            sink_id=$(find_audio_sink "$sink_name")

            if [[ -z "$sink_id" ]]; then
                echo "✗ Audio sink not found: $sink_name" >&2
                return 1
            fi

            echo "→ Audio: $label (sink $sink_id)"
            wpctl set-default "$sink_id"
        }

        usage() {
            cat <<EOF
        Usage: $(basename "$0") <mode>

        Modes:
          (none)        Laptop + external   + external audio
          laptop      Laptop screen only  + internal audio
          external    External screen only + external audio

        EOF
            exit 1
        }

        [[ $# -gt 1 ]] && usage

        MODE="''${1:-both}"

        EXT_DISPLAY=""
        if [[ "$MODE" != "laptop" ]]; then
            EXT_DISPLAY=$(find_external_display)
            if [[ -z "$EXT_DISPLAY" ]]; then
                echo "✗ No external display detected (tried: ''${EXTERNAL_DISPLAY_CANDIDATES[*]})" >&2
                exit 1
            fi
        fi

        case "$MODE" in
            laptop)
                for output in "''${EXTERNAL_DISPLAY_CANDIDATES[@]}"; do
                    if xrandr | grep -q "^''${output} connected"; then
                        xrandr --output "$output" --off
                    fi
                done
                xrandr --output "$INTERNAL_DISPLAY" --auto --primary
                set_audio "$INTERNAL_AUDIO_NAME" "internal"
                ;;
            both)
                set_display both "$EXT_DISPLAY"
                set_audio "$EXTERNAL_AUDIO_NAME" "external"
                ;;
            external)
                set_display external "$EXT_DISPLAY"
                set_audio "$EXTERNAL_AUDIO_NAME" "external"
                ;;
            *)
                usage
                ;;
        esac

        echo "✓ Done."
      '';
    };
  };
}
