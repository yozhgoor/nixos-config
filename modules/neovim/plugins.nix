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
