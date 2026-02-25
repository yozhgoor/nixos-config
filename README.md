# NixOS configuration

This repository keep track of my personal [NixOS][nixos] configuration.

## Structure

This setup use [Flakes][flakes] so the "entrypoint" is [`flake.nix`][flake_path].

### Configuration

The [`configuration`][configuration] directory contains configuration specific to the hosts.

- Configuration specific to [nostromo][nostromo]: [`configuration/nostromo`][nostromo_path]
- Configuration specific to [sanctuary][sanctuary]: [`configuration/sanctuary`][sanctuary_path]
- Configuration specific to [atlantis][atlantis]: [`configuration/atlantis`][atlantis_path]
- Default configuration: [`configuration/default.nix`][default_path]

### Modules

The [`modules`][modules] directory is related to the programs or services optionally imported.

- Module related to [bash][bash]: [`modules/bash.nix`][bash_path]
- Module related to [firefox][firefox]: [`modules/firefox.nix`][firefox_path]
- Module related to [git][git]: [`modules/git.nix`][git_path]
- Module related to [home-manager][home-manager]: [`modules/home-manager.nix`][home-manager_path]
- Module related to [i3][i3]: [`modules/i3.nix`][i3_path]
- Module related to [neovim][neovim]: [`modules/neovim`][neovim_path]
- Module related to [rust][rust]: [`modules/rust.nix`][rust_path]
- Module related to [steam][steam]: [`modules/steam.nix`][steam_path]
- Module related to [xorg][xorg]: [`modules/xorg.nix][xorg_path]

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

Note that auto-upgrade is enabled in `configuration/default.nix`.

## Clean up

To remove old, unreferenced packages:
```
nix-collect-garbage
```

The following command deletes old unreferenced packages and old roots, removing the ability to roll
back to them:
```
nix-collect-garbage -d
sudo nix-collect-garbage -d
```

To delete all historical versions you can use
```
sudo nix profile wipe-history
```

## Optimize

You can manually optimize the store using:
```
nix-store --optimise
```

[nixos]: https://nixos.org
[flakes]: https://nixos.wiki/wiki/flakes
[flake_path]: https://github.com/yozhgoor/nixos-config/blob/main/flake.nix
[configuration]: https://github.com/yozhgoor/nixos-config/blob/main/configuration
[nostromo]: https://avp.fandom.com/wiki/USCSS_Nostromo
[nostromo_path]: https://github.com/yozhgoor/nixos-config/blob/main/configuration/nostromo
[sanctuary]: https://marvelcinematicuniverse.fandom.com/wiki/Sanctuary_II
[sanctuary_path]: https://github.com/yozhgoor/nixos-config/blob/main/configuration/sanctuary
[atlantis]: https://memory-alpha.fandom.com/wiki/Atlantis_(starship)
[atlantis_path]: https://github.com/yozhgoor/nixos-config/blob/main/configuration/atlantis
[default_path]: https://github.com/yozhgoor/nixos-config/blob/main/configuration/default.nix
[modules]: https://github.com/yozhgoor/nixos-config/blob/main/modules
[bash]: https://www.gnu.org/software/bash
[bash_path]: https://github.com/yozhgoor/nixos-config/blob/main/modules/bash.nix
[firefox]: https://www.mozilla.org/en-US/firefox/new
[firefox_path]: https://github.com/yozhgoor/nixos-config/blob/main/modules/firefox.nix
[git]: https://git-scm.com
[git_path]: https://github.com/yozhgoor/nixos-config/blob/main/modules/git.nix
[home-manager]: https://github.com/nix-community/home-manager
[home-manager_path]: https://github.com/yozhgoor/nixos-config/blob/main/modules/home-manager.nix
[i3]: https://i3wm.org
[i3_path]: https://github.com/yozhgoor/nixos-config/blob/main/modules/i3.nix
[neovim]: https://neovim.io
[neovim_path]: https://github.com/yozhgoor/nixos-config/blob/main/modules/neovim
[rust]: https://rust-lang.org
[rust_path]: https://github.com/yozhgoor/nixos-config/blob/main/modules/rust.nix
[steam]: https://store.steampowered.com
[steam_path]: https://github.com/yozhgoor/nixos-config/blob/main/modules/steam.nix
[xorg]: https://www.x.org/wiki
[xorg_path]: https://github.com/yozhgoor/nixos-config/blob/main/modules/xorg.nix
