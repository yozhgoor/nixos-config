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
                    "app.normandy.first_run" = false;

                    # Clean new tab page
                    "browser.newtabpage.activity-stream.feeds.topsites" = false;
                    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                    "browser.newtabpage.activity-stream.feeds.sections" = false;
                    "browser.newtabpage.activity-stream.feeds.shortcuts" = false;
                    "browser.newtabpage.activity-stream.showSponsored" = false;
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                    "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
                    "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
                    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
                    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

                    # Disable telemetry
                    "app.shield.optoutstudies.enabled" = false;
                    "browser.discovery.enabled" = false;
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

                    # Privacy
                    "privacy.globalprivacycontrol.enabled" = true;
                    "dom.security.https_only_mode" = true;
                    "places.history.enabled" = false;

                    # Disable auto-play
                    "media.autoplay.default" = 5;

                    # Disable middle-click paste
                    "middlemouse.paste" = false;

                    # Disable link preview
                    "browser.ml.linkPreview.enabled" = false;

                    # Disable prefetching over network
                    "network.prefetch-next" = false;
                    "network.dns.disablePrefetch" = true;
                    "network.predictor.enabled" = false;
                    "network.predictor.enable-prefetch" = false;

                    # Clear on shutdown
                    "privacy.sanitize.sanitizeOnShutdown" = true;
                    "privacy.clearOnShutdown_v2.formdata" = true;
                    "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;

                    # Keep cookies
                    "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;

                    # Disable Normandy app
                    "app.normandy.enabled" = false;

                    # Disable firefox accounts
                    "identity.fxaccounts.enabled" = false;

                    # Disable "save password" prompts
                    "signon.rememberSignons" = false;
                    "signon.autofillForms" = false;
                    "signon.generation.enabled" = false;

                    # Set dark theme
                    "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
                    "layout.css.prefers-color-scheme.content-override" = 0;

                    # Disable translation panel
                    "browser.translations.panelShow" = false;

                    # Remove unwanted suggestions and shortcuts from URL bar
                    "browser.urlbar.suggest.recentsearches" = false;
                    "browser.urlbar.suggest.topsites" = false;
                    "browser.urlbar.suggest.engines" = false;
                    "browser.urlbar.suggest.quickactions" = false;
                    "browser.urlbar.shortcuts.history" = false;
                    "browser.urlbar.shortcuts.actions" = false;

                    # Always show bookmarks in toolbar
                    "browser.toolbars.bookmarks.visibility" = "always";

                    # Hide sidebar
                    "sidebar.visibility" = "hide-sidebar";

                    # Fonts
                    "font.name.serif.x-western" = "Liberation Serif";
                    "font.name.sans-serif.x-western" = "Liberation Sans";
                    "font.name.monospace.x-western" = "JetBrainsMono Nerd Font";

                    # Set default download directory
                    "browser.download.dir" = "/home/${username}/downloads";
                    "browser.download.folderList" = 2;
                    "browser.download.autoOpenPreference" = false;
                    "browser.download.alwaysOpenPanel" = false;

                    # Disable auto-fill on forms
                    "dom.forms.autocomplete.formautofill" = false;
                    "extensions.formautofill.addresses.enabled" = false;
                    "extensions.formautofill.creditCards.enabled" = false;
                    "browser.formfill.enable" = false;

                    # Disable pocket
                    "extensions.pocket.enabled" = false;

                    # Don't show preview when hovering over a tab
                    "browser.tabs.hoverPreview.showThumbnails" = false;

                    # Don't use AI to suggest tabs and name for tab groups
                    "browser.tabs.groups.smart.userEnabled" = false;

                    # Play DRM-controlled content
                    "media.eme.enabled" = true;

                    # Performance
                    "browser.tabs.maxOpenBeforeWarn" = 25;

                    # Authorize use of userChrome.css
                    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                };

                userChrome = ''
                    #firefox-view-button { display: none; }
                    #nav-bar toolbarspring { display: none; }
                    #alltabs-button { display: none; }
                '';

                bookmarks = {
                    force = true;
                    settings = [
                        {
                            name = "toolbar";
                            toolbar = true;
                            bookmarks = [
                                {
                                    name = "GitHub";
                                    bookmarks = [
                                        {
                                            name = "yozhgoor";
                                            url = "https://github.com/yozhgoor";
                                        }
                                        {
                                            name = "rustminded";
                                            url = "https://github.com/rustminded";
                                        }
                                    ];
                                }
                                {
                                    name = "Rust";
                                    bookmarks = [
                                        {
                                            name = "the book";
                                            url = "https://doc.rust-lang.org/book";
                                        }
                                        {
                                            name = "the cargo book";
                                            url = "https://doc.rust-lang.org/cargo";
                                        }
                                    ];
                                }
                                {
                                    name = "Tools";
                                    bookmarks = [
                                        {
                                            name = "deepl";
                                            url = "https://www.deepl.com/en/translator";
                                        }
                                        {
                                            name = "alternativeto";
                                            url = "https://alternativeto.net";
                                        }
                                    ];
                                }
                            ];
                        }
                    ];
                };
            };
        };
    };
}
