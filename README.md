# NixOS configuration

This repository keep track of my personal [NixOS][nixos] configuration.

## Structure

This setup use [Flakes][flakes] so the "entrypoint" is [`flake.nix`][flake_path].

### Configuration

The [`configuration`][configuration] directory contains configuration specific to the hosts.

- Configuration specific to [sanctuary][sanctuary]: [`configuration/sanctuary`][sanctuary_path]
- Default configuration: [`configuration/default.nix`][default_path]

### Modules

The [`modules`][modules] directory is related to the programs or services optionally imported.

- Module related to [alacritty][alacritty]: [`modules/alacritty.nix`][alacritty_path]
- Module related to [bash][bash]: [`modules/bash.nix`][bash_path]
- Module related to [firefox][firefox]: [`modules/firefox.nix`][firefox_path]
- Module related to [git][git]: [`modules/git.nix`][git_path]
- Module related to [home-manager][home-manager]: [`modules/home-manager.nix`][home-manager_path]
- Module related to [i3][i3]: [`modules/i3.nix`][i3_path]
- Module related to [mangohud][mangohud]: [`modules/mangohud.nix`][mangohud_path]
- Module related to [markdown][markdown]: [`modules/markdown.nix`][markdown_path]
- Module related to [neovim][neovim]: [`modules/neovim`][neovim_path]
- Module related to [sway][sway]: [`modules/sway`][sway_path]

## Usage

Rebuild the system from the local repository:
```
sudo nixos-rebuild switch --flake <path_to_repo>#hostname
```

The available hostnames available at the moment are:
- `sanctuary` (`x86_64-linux`)
- `nostromo` (`aarch64-linux`)

Example: `sudo nixos-rebuild switch --flake .config/nixos#sanctuary`

Note that `<path_to_repo>` can be the path to the local repository but also the remote repository:
```
sudo nixos-rebuild switch --flake github:owner/repo#hostname
```

Example: `sudo nixos-rebuild switch --flake github:yozhgoor/nixos#nostromo`

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

The following command deletes old roots, removing the ability to roll back to them:
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
[flake_path]: https://github.com/yozhgoor/nixos/blob/main/flake.nix
[configuration]: https://github.com/yozhgoor/nixos/blob/main/configuration
[sanctuary]: https://marvel.fandom.com/wiki/Sanctuary_(Vehicle)
[sanctuary_path]: https://github.com/yozhgoor/nixos/blob/main/configuration/sanctuary
[default_path]: https://github.com/yozhgoor/nixos/blob/main/configuration/default.nix
[modules]: https://github.com/yozhgoor/nixos/blob/main/modules
[alacritty]: https://alacritty.org
[alacritty_path]: https://github.com/yozhgoor/nixos/blob/main/modules/alacritty.nix
[bash]: https://www.gnu.org/software/bash
[bash_path]: https://github.com/yozhgoor/nixos/blob/main/modules/bash.nix
[firefox]: https://www.mozilla.org/en-US/firefox/new
[firefox_path]: https://github.com/yozhgoor/nixos/blob/main/modules/firefox.nix
[git]: https://git-scm.com
[git_path]: https://github.com/yozhgoor/nixos/blob/main/modules/git.nix
[home-manager]: https://github.com/nix-community/home-manager
[home-manager_path]: https://github.com/yozhgoor/nixos/blob/main/modules/home-manager.nix
[i3]: https://i3wm.org
[i3_path]: https://github.com/yozhgoor/nixos/blob/main/modules/i3.nix
[mangohud]: https://github.com/flightlessmango/MangoHud
[mangohud_path]: https://github.com/yozhgoor/nixos/blob/main/modules/mangohud.nix
[markdown]: https://en.wikipedia.org/wiki/Markdown
[markdown_path]: https://github.com/yozhgoor/nixos/blob/main/modules/markdown.nix
[neovim]: https://neovim.io
[neovim_path]: https://github.com/yozhgoor/nixos/blob/main/modules/neovim
[sway]: https://swaywm.org
[sway_path]: https://github.com/yozhgoor/nixos/blob/main/modules/sway
