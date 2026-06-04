# NixOS configuration

This repository keeps track of my personal [NixOS][nixos] configuration.

## Structure

This setup use [Flakes][flakes] so the "entrypoint" is [`flake.nix`][flake_path].

### Configuration

The [`configuration`][configuration] directory contains configuration specific to the hosts:

- Configuration specific to [sanctuary][sanctuary]: [`configuration/sanctuary`][sanctuary_path]
- Configuration specific to [atlantis][atlantis]: [`configuration/atlantis`][atlantis_path]
- Default configuration for all hosts: [`configuration/default.nix`][default_path]

### Modules

The [`modules`][modules] directory is related to the programs or services optionally imported.

### Dev shells

The [`dev shells`][dev_shells] file is related to development shells available on the system. For
example, you can enter a dev shell with:
```
nix develop <path_to_repo>#rust
```

### Archives

The [`archives`][archives] directory is related to older files not used in the current configuration.

## Usage

Rebuild the system from the local repository:
```
sudo nixos-rebuild switch --flake <path_to_repo>#hostname
```

Note that `<path_to_repo>` can be the path to the local repository but also the remote repository:
```
sudo nixos-rebuild switch --flake github:owner/repo#hostname
```

## Upgrade

You can upgrade NixOS to the latest version by running:
```
nixos-rebuild switch --upgrade --flake <path_to_repo>#hostname
```

Note that auto-upgrade is enabled in [`configuration/default.nix`][default_path].

## Clean up

The following command deletes old unreferenced packages and old roots, removing the ability to roll
back to them:
```
nix-collect-garbage -d
sudo nix-collect-garbage -d
```

Note that `gc.automatic` is enabled in [`configuration/default.nix`][default_path].

## Optimize

You can manually optimize the store using:
```
nix-store --optimise
```

Note that `auto-optimise-store` is enabled in [`configuration/default.nix`][default_path].

[nixos]: https://nixos.org
[flakes]: https://nixos.wiki/wiki/flakes
[flake_path]: https://github.com/yozhgoor/nixos-config/blob/main/flake.nix
[configuration]: https://github.com/yozhgoor/nixos-config/blob/main/configuration
[sanctuary]: https://marvelcinematicuniverse.fandom.com/wiki/Sanctuary_II
[sanctuary_path]: https://github.com/yozhgoor/nixos-config/blob/main/configuration/sanctuary
[atlantis]: https://memory-alpha.fandom.com/wiki/Atlantis_(starship)
[atlantis_path]: https://github.com/yozhgoor/nixos-config/blob/main/configuration/atlantis
[default_path]: https://github.com/yozhgoor/nixos-config/blob/main/configuration/default.nix
[modules]: https://github.com/yozhgoor/nixos-config/blob/main/modules
[dev-shells]: https://github.com/yozhgoor/nixos-config/blob/main/dev-shells.nix
[archives]: https://github.com/yozhgoor/nixos-config/blob/main/archives
