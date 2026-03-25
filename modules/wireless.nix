{ ... }:

{
    networking.wireless = {
        enable = true;
        secretsFile = "/etc/nixos/networks.conf";
        networks = {
            yoz = {
                pskRaw = "ext:yoz_psk";
                priority = 10;
            };
            Ilfaitbeau.pskRaw = "ext:ilfaitbeau_psk";
            "WiFi-5.0-FC57".pskRaw = "ext:fc57_psk";
        };
    };
    networking.useDHCP = true;
}
