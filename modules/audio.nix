{ ... }:

{
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.extraConfig = {
            "10-disable-suspend" = {
                "monitor.alsa.rules" = [
                    {
                        matches = [{ "node.name" = "~alsa_output.*"; }];
                        actions = {
                            update-props = {
                                "session.suspend-timeout-seconds" = 0;
                            };
                        };
                    }
                ];
            };
        };
    };
}
