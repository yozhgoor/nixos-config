{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-tools
  ];

  home.file.".local/bin/android-setup" = {
    executable = true;
    text = ''
      #!/bin/sh

      usage() {
        echo "Usage: $0 <package-list-file> [device-serial]"
        echo
        echo "  package-list-file   Path to a file with one package name per line"
        echo "                      (# comments and blank lines are ignored)."
        echo "  device-serial       Optional. Required if more than one device is"
        echo "                      connected. Run 'adb devices' to find it."
        exit 1
      }

      [ -n "$1" ] || usage
      list_file="$1"
      target_serial="$2"

      [ -f "$list_file" ] || { echo "Package list file not found: $list_file"; exit 1; }

      clean_packages() {
        sed -e 's/#.*$//' -e '/^[[:space:]]*$/d' -e 's/^[[:space:]]*//' "$list_file"
      }

      if ! command -v adb >/dev/null 2>&1; then
        echo "adb not found. Install Android platform-tools and ensure adb is on PATH."
        exit 1
      fi

      devices=$(adb devices | awk 'NR>1 && $2=="device" {print $1}')
      if [ -z "$devices" ]; then
        echo "No authorized device found. Connect device and enable USB debugging."
        exit 1
      fi

      device_count=$(echo "$devices" | wc -l)

      if [ -n "$target_serial" ]; then
        if ! echo "$devices" | grep -qx "$target_serial"; then
          echo "Device '$target_serial' not found among connected devices:"
          echo "$devices"
          exit 1
        fi
        devices="$target_serial"
      elif [ "$device_count" -gt 1 ]; then
        echo "Multiple devices connected — a serial is required to avoid running"
        echo "the wrong package list against the wrong phone:"
        echo "$devices"
        exit 1
      fi

      echo "Target device(s):"
      echo "$devices"
      echo "Package list: $list_file"
      echo

      printf "This will attempt to uninstall (for user 0) then disable listed packages on the device above.\n"
      printf "Review the package list below and press Enter to continue, Ctrl+C to cancel.\n\n"
      clean_packages | sed -n '1,200p'
      printf "Press ENTER to confirm"
      read _confirm

      try_cmd() {
        dev="$1"
        cmd="$2"
        adb -s "$dev" shell "$cmd" >/dev/null 2>&1
      }

      for dev in $devices; do
        echo "Processing device: $dev"

        has_root=0
        try_cmd "$dev" "su -c id" && has_root=1
        echo "Has root: $has_root"

        for pkg in $(clean_packages); do
          echo "-> $pkg"

          if [ "$has_root" -eq 1 ] && try_cmd "$dev" "su -c 'pm uninstall $pkg'"; then
            echo "   Uninstalled with root."
            continue
          fi

          if try_cmd "$dev" "pm uninstall --user 0 $pkg"; then
            echo "   Uninstalled for user 0."
            continue
          fi

          if try_cmd "$dev" "pm disable-user --user 0 $pkg"; then
            echo "   Disabled."
            continue
          fi

          if try_cmd "$dev" "pm hide $pkg"; then
            echo "   Hidden."
            continue
          fi

          echo "   All attempts failed for $pkg."
        done

        echo "Done with $dev"
      done

      echo "Finished. Reboot device(s) if you experience issues."
    '';
  };
}
