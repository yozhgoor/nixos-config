{ pkgs, ... }:

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
        settings = {
          close_if_last_window = true;
          filesystem.filtered_items.hide_dotfiles = false;
          event_handlers = [
            {
              event = "file_opened";
              handler = {
                __raw =''
                  function(file_path)
                    require("neo-tree.command").execute({ action = "close" })
                  end
                '';
              };
            }
          ];
        };
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
          sql
          toml
          vim
          vimdoc
          xml
          yaml
        ];
      };

      render-markdown = {
        enable = true;
        settings = {
          render_modes = true;
          heading = {
            sign = false;
            width = "block";
            min_width = 100;
            position = "inline";
          };
          code = {
            style = "normal";
            width = "block";
            min_width = 100;
          };
          dash.width = 100;
          latex.enabled = false;
        };
      };

      image = {
        enable = true;
        settings = {
          whatever = true;
          backend = "kitty";
          integrations = {
            markdown = {
              enabled = true;
              clear_in_insert_mode = false;
              download_remote_images = false;
              filetypes = [ "markdown" ];
            };
          };
        };
      };
    };

    extraPackages = with pkgs; [
      # Related to image.nvim
      imagemagick
    ];

    autoCmd = [
      # Related to `render-markdown`
      {
        event = "FileType";
        pattern = "markdown";
        callback = {
          __raw = ''
            function()
              vim.opt_local.conceallevel = 2
              for i = 1,6 do
                vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i .. "Bg", { bg = "NONE" })
              end
            end
          '';
        };
      }
    ];

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
