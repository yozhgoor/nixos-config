{ colors, userFonts, username, ... }:

{
  home-manager.users.${username} = {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        return {
          colors = {
            foreground = "#${colors.foreground}",
            background = "#${colors.background}",

            cursor_bg = "#${colors.foreground}",
            cursor_fg = "#${colors.background}",
            cursor_border = "#${colors.foreground}",

            selection_fg = "#${colors.background}",
            selection_bg = "#${colors.lightBlue}",

            split = "#${colors.lightBackground}",

            ansi = {
              "#${colors.black}",
              "#${colors.red}",
              "#${colors.green}",
              "#${colors.yellow}",
              "#${colors.blue}",
              "#${colors.magenta}",
              "#${colors.cyan}",
              "#${colors.white}",
            },
            brights = {
              "#${colors.lightBlack}",
              "#${colors.lightRed}",
              "#${colors.lightGreen}",
              "#${colors.lightYellow}",
              "#${colors.lightBlue}",
              "#${colors.lightMagenta}",
              "#${colors.lightCyan}",
              "#${colors.lightWhite}",
            },
          },

          font = wezterm.font("${userFonts.nerd.name}"),
          font_size = 10,

          enable_scroll_bar = false,
          alternate_buffer_wheel_scroll_speed = 1,

          use_fancy_tab_bar = false,
          hide_tab_bar_if_only_one_tab = true,

          window_close_confirmation = "NeverPrompt",
          audible_bell = "Disabled",
          hide_mouse_cursor_when_typing = true,
          cursor_blink_rate = 0,
          pane_focus_follows_mouse = true,

          check_for_updates = false,

          disable_default_key_bindings = true,
          disable_default_mouse_bindings = true,

          keys = {
            -- Clipboard
            {
              key = "C",
              mods = "CTRL|SHIFT",
              action = wezterm.action.CopyTo("Clipboard"),
            },
            {
            key = "V",
              mods = "CTRL|SHIFT",
              action = wezterm.action.PasteFrom("Clipboard"),
            },

            -- Panes
            {
              key = "?",
              mods = "CTRL|SHIFT",
              action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
            },

            {
              key = "\"",
              mods = "CTRL|SHIFT",
              action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
            },
            {
              key = "F",
              mods = "CTRL|SHIFT",
              action = wezterm.action.TogglePaneZoomState,
            },
            {
              key = "UpArrow",
              mods = "CTRL|SHIFT",
              action = wezterm.action.ActivatePaneDirection("Up"),
            },
            {
              key = "LeftArrow",
              mods = "CTRL|SHIFT",
              action = wezterm.action.ActivatePaneDirection("Left"),
            },
            {
              key = "RightArrow",
              mods = "CTRL|SHIFT",
              action = wezterm.action.ActivatePaneDirection("Right"),
            },
            {
              key = "DownArrow",
              mods = "CTRL|SHIFT",
              action = wezterm.action.ActivatePaneDirection("Down"),
            },
            {
              key = "UpArrow",
              mods = "CTRL|SHIFT|ALT",
              action = wezterm.action.AdjustPaneSize({ "Up", 1 }),
            },
            {
              key = "LeftArrow",
              mods = "CTRL|SHIFT|ALT",
              action = wezterm.action.AdjustPaneSize({ "Left", 1 }),
            },
            {
              key = "RightArrow",
              mods = "CTRL|SHIFT|ALT",
              action = wezterm.action.AdjustPaneSize({ "Right", 1 }),
            },
            {
              key = "DownArrow",
              mods = "CTRL|SHIFT|ALT",
              action = wezterm.action.AdjustPaneSize({ "Down", 1 }),
            },
            {
              key = "}",
              mods = "CTRL|SHIFT",
              action = wezterm.action.CloseCurrentPane { confirm = true },
            },
          },

          -- Disable built-in key tables
          key_tables = {
            search_mode = {},
            copy_mode = {},
          },

          mouse_bindings = {
            -- Clipboard
            {
              event = { Down = { streak = 1, button = "Middle" } },
              mods = "NONE",
              action = wezterm.action.PasteFrom("Clipboard"),
            },
            -- Scrolling
            {
              event = { Down = { streak = 1, button = { WheelUp = 1 } } },
              mods = "NONE",
              action = wezterm.action.ScrollByCurrentEventWheelDelta,
            },
            {
              event = { Down = { streak = 1, button = { WheelDown = 1 } } },
              mods = "NONE",
              action = wezterm.action.ScrollByCurrentEventWheelDelta,
            },
            -- Selection
            {
              event = { Down = { streak = 1, button = "Left" } },
              mods = "NONE",
              action = wezterm.action.SelectTextAtMouseCursor("Cell"),
            },
            {
              event = { Down = { streak = 2, button = "Left" } },
              mods = "NONE",
              action = wezterm.action.SelectTextAtMouseCursor("Word"),
            },
            {
              event = { Down = { streak = 3, button = "Left" } },
              mods = "NONE",
              action = wezterm.action.SelectTextAtMouseCursor("Line"),
            },
            {
              event = { Drag = { streak = 1, button = "Left" } },
              mods = "NONE",
              action = wezterm.action.ExtendSelectionToMouseCursor("Cell"),
            },
            {
              event = { Drag = { streak = 2, button = "Left" } },
              mods = "NONE",
              action = wezterm.action.ExtendSelectionToMouseCursor("Word"),
            },
            {
              event = { Drag = { streak = 3, button = "Left" } },
              mods = "NONE",
              action = wezterm.action.ExtendSelectionToMouseCursor("Line"),
            },
            {
              event = { Up = { streak = 1, button = "Left" } },
              mods = "NONE",
              action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("Clipboard"),
            },
            {
              event = { Up = { streak = 2, button = "Left" } },
              mods = "NONE",
              action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("Clipboard"),
            },
                        {
              event = { Up = { streak = 3, button = "Left" } },
              mods = "NONE",
              action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("Clipboard"),
            },
          },
        }
      '';
    };
  };
}
