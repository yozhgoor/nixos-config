# Plugins configuration for Neovim
{ inputs, config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "-";
        };
      };

      web-devicons.enable = true;
      bufferline.enable = true;

      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        eventHandlers.file_opened = ''
          function(file_path)
            require("neo-tree").close_all()
          end
        '';
        filesystem.filteredItems.hideDotfiles = false;
      };

      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
        };

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          comment
          diff
          gitignore
          gitcommit
          html
          javascript
          json
          latex
          lua
          markdown
          mermaid
          nix
          python
          query
          regex
          ron
          rust
          toml
          vim
          vimdoc
          xml
          yaml
        ];
      };
    };

    keymaps = [
      # Toggle neo-tree
      {
	      mode = "n";
	      key = "<leader>m";
	      action = ":Neotree toggle<CR>";
	      options = {
	        silent = true;
	        noremap = true;
	      };
      }
    ];
  };
}
