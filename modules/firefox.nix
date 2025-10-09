{ inputs, config, pkgs, shared, ...}:

{
  home-manager.users.${shared.username} = {
    programs.firefox = {
      enable = true;

      profiles.default = {
        isDefault = true;

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          proton-pass
        ];

        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          engines = {
            "Google".metaData.hidden = true;
            "Bing".metaData.hidden = true;
          };
        };

        userChrome = ''
          #firefox-view-button {
            display: none !important;
          }

          #alltabs-button {
            display: none !important;
          }

          #nav-bar toolbarspring {
            display: none !important;
          }
        '';

        settings = {
          # Clean-up on shutdown
          "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
          "privacy.clearOnShutdown_v2.formdata" = true;

          # Disable "save password" prompt
          "signon.rememberSignons" = false;
          "signon.autofillForms" = false;
          "signon.firefoxRelay.feature" = "disabled";
          "signon.generation.enabled" = false;

          # Remove unwanted suggestions and shortcuts from URL bar
          "browser.urlbar.suggest.recentsearches" = false;
          "browser.urlbar.shortcuts.history" = false;
          "browser.urlbar.suggest.topsites" = false;

          # Always show bookmarks toolbar
          "browser.toolbars.bookmarks.visibility" = "always";

          # Hide sidebar
          "sidebar.visibility" = "hide-sidebar";

          # Hide preview on hover
          "browser.tabs.hoverPreview.showThumbnails" = false;

          # Font
          "font.name.serif.x-western" = "JetbrainsMono Nerd Font";
          "font.size.variable.x-western" = 12;

          # Set default download directory
          "browser.download.dir" = "/home/${shared.username}/downloads";
          "browser.download.folderList" = 2;
          "browser.download.autoOpenPreference" = false;
          "browser.download.alwaysOpenPanel" = false;

          # Enable UI customizations with `userChrome.css`
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Show toolbar on full-screen
          "browser.fullscreen.autohide" = false;
        };

        bookmarks = [
          {
            name = "Bookmarks";
            toolbar = true;
            bookmarks = [
              {
                name = "Tricks";
                bookmarks = [
                  {
                    name = "PDF dark mode";
                    url = "javascript:(function(){var el = typeof viewer !== 'undefined' ? viewer : document.body; el.style.filter = 'grayscale(1) invert(1) sepia(1) contrast(75%)';})()";
                  }
                  {
                    name = "Generating a new SSH key";
                    url =
                    "https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent";
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
