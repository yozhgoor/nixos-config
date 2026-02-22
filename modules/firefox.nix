{ inputs, config, pkgs, username, ... }:

{
    home-manager.users.${username} = {
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
                    default = "ddg";
                    privateDefault = "ddg";

                    engines = {
                        google.metaData.hidden = true;
                        bing.metaData.hidden = true;
                        "ebay-be".metaData.hidden = true;
                        ecosia.metaData.hidden = true;
                        perplexity.metaData.hidden = true;
                        qwant.metaData.hidden = true;
                        wikipedia.metaData.hidden = true;
                    };
                };

                settings = {
                    # disable first launch phase
                    "browser.disableResetPrompt" = true;
                    "browser.download.panel.shown" = true;
                    "browser.messaging-system.whatsNewPanel.enabled" = false;
                    "browser.shell.checkDefaultBrowser" = false;
                    "browser.startup.homepage_override.mstone" = "ignore";
                    "browser.uitour.enabled" = false;
                    "trailhead.firstrun.didSeeAboutWelcome" = true;
                    "browser.bookmarks.addedImportButton" = true;
                    "app.normandy.first_run" = false;

                    # Clean new tab page
                    "browser.newtabpage.activity-stream.feeds.topsites" = false;
                    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                    "browser.newtabpage.activity-stream.feeds.sections" = false;
                    "browser.newtabpage.activity-stream.feeds.shortcuts" = false;
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                    "browser.newtabpage.activity-stream.showSponsored" = false;
                    "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
                    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
                    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

                    # Disable telemetry
                    "app.shield,optoutstudies.enabled" = false;
                    "browser.discovery,enabled" = false;
                    "browser.ping-centre.telemetry" = false;
                    "datareporting.healthreport.uploadEnabled" = false;
                    "datareporting.policy.dataSubmissionEnabled" = false;
                    "datareporting.usage.uploadEnabled" = false;
                    "toolkit.telemetry.enabled" = false;
                    "toolkit.telemetry.archive.enabled" = false;
                    "toolkit.telemetry.bhrPing.enabled" = false;
                    "toolkit.telemetry.firstShutdownPing.enabled" = false;
                    "toolkit.telemetry.prompted" = 2;
                    "toolkit.telemetry.rejected" = true;
                    "toolkit.telemetry.reportingpolicy.firstRun" = false;
                    "toolkit.telemetry.server" = "";
                    "toolkit.telemetry.shutdownPingSender.enabled" = false;
                    "toolkit.telemetry.unified" = false;
                    "toolkit.telemetry.unifiedIsOptIn" = false;
                    "toolkit.telemetry.updatePing.enabled" = false;

                    # Enforce privacy
                    "browser.contentblocking.category" = "strict";
                    "privacy.trackingprotection.enabled" = true;
                    "privacy.trackingprotection.emailtracking.enabled" = true;
                    "privacy.trackingprotection.socialtracking.enabled" = true;
                    "privacy.globalprivacycontrol.enabled" = true;
                    "privacy.fingerprintingProtection" = true;
                    "dom.security.https_only_mode" = true;
                    "network.http.referer.XOriginPolicy" = 2;
                    "network.http.referer.XOriginTrimmingPolicy" = 2;
                    "network.http.referer.trimmingPolicy" = 1;

                    # Disable WebRTC IP Leak
                    # Note: This will break in-browser video calls (Meet, jitsi, etc.).
                    "media.peerconnection.enabled" = false;

                    # Disable auto-play
                    "media.autoplay.default" = 5;

                    # Disable middle-click paste
                    "middlemouse.paste" = false;

                    # Disable DNS prefetching
                    "network.prefetch-next" = false;
                    "network.dns.disablePrefetch" = false;

                    # Clear on shutdown
                    "privacy.sanitizeOnShutdown" = true;
                    "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
                    "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
                    "privacy.clearOnShutdown_v2.formdata" = true;

                    # Disable Normandy app
                    "app.normandy.enabled" = false;

                    # Disable firefox accounts
                    "identity.fxaccounts.enabled" = false;

                    # Disable "save password" prompts
                    "signon.rememberSignons" = false;
                    "signon.autofillForms" = false;
                    "signon.firefoxRelay.feature" = false;
                    "signon.generation.enabled" = false;

                    # Set dark theme
                    "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
                    "browser.theme.content-theme" = 0;
                    "browser.theme.toolbar-theme" = 0;
                    "layout.css.prefers-color-scheme.content-override" = 0;

                    # Disable translation panel
                    "browser.translations.panelShow" = false;

                    # Remove unwanted suggestions and shortcuts from URL bar
                    "browser.urlbar.suggest.recentsearches" = false;
                    "browser.urlbar.suggest.topsites" = false;
                    "browser.urlbar.shortcuts.history" = false;
                    "browser.urlbar.shortcuts.actions" = false;

                    # Hide sidebar
                    "sidebar.visibility" = "hide-sidebar";

                    # Fonts
                    "font.name.monospace.x-western" = "JetBrains Mono Nerd Font";
                    "font.name.serif.x-western" = "JetBrains Mono Nerd Font";
                    "font.size.variable.x-western" = 14;

                    # Set default download directory
                    "browser.download.dir" = "/home/${username}/downloads";
                    "browser.download.folderlist" = 2;
                    "browser.download.autoOpenPreference" = false;
                    "browser.download.alwaysOpenPanel" = false;

                    # Disable auto-fill on forms
                    "dom.forms.autocomplete.formautofill" = false;
                    "extensions.formautofill.addresses.enabled" = false;
                    "extensions.formautofill.creditCards.enabled" = false;
                    "browser.formfill.enable" = false;

                    # Disable pocket
                    "extensions.pocket.enabled" = false;

                    # Performance
                    "browser.tabs.maxOpenBeforeWarn" = 25;
                    "full-screen-api.transition-duration.enter" = 0;
                    "full-screen-api.transition-duration.leave" = 0;

                    # Authorize use of userChrome.css
                    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                };

                userChrome = ''
                    #firefox-view-button { display: none; }
                    #nav-bar toolbarspring { display: none; }
                    #alltabs-button { display: none; }
                '';
            };
        };
    };
}
