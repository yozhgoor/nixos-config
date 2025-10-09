# Default configuration for Neovim
{ inputs, config, pkgs, ... }:

{
  imports = [
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.gruvbox.enable = true;

    viAlias = true;
    vimAlias = true;

    withPython3 = false;
    withRuby = false;

    clipboard = {
      register = "unnamedplus";
    };

    globals.mapleader = ",";

    opts = {
      lazyredraw = true;
      updatetime = 100;

      encoding = "utf-8";
      autoread = true;
      swapfile = false;
      hidden = true;

      spell = true;
      spelllang = "en_us";

      showmatch = true;
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;

      termguicolors = true;
      signcolumn = "yes:1";
      number = true;
      cursorline = true;
      colorcolumn = "100";
      textwidth = 100;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      smartindent = true;
      expandtab = true;
      breakindent = true;
    };

    keymaps = [
      {
        key = "<leader><Left>";
        action = ":bprev<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        key = "<leader><Right>";
        action = ":bnext<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        key = "<leader><Down>";
        action = ":bdel<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
    ];

    autoCmd = [
      {
        event = "BufWritePre";
        pattern = "*";
        command = "%s/\\s\\+$//e";
      }

      {
        event = "FileType";
        pattern = [ "nix" "javascript" "yaml" ];
        callback = {
          __raw = ''
            function()
              vim.opt_local.tabstop = 2
              vim.opt_local.softtabstop = 2
              vim.opt_local.shiftwidth = 2
            end
          '';
        };
      }

      {
        event = "FileType";
        pattern = "xml";
        callback = {
          __raw = ''
            function()
              vim.opt_local.wrap = true
              vim.opt_local.linebreak = true
              vim.opt_local.tabstop = 2
              vim.opt_local.softtabstop = 2
              vim.opt_local.shiftwidth = 2
            end
          '';
        };
      }

      {
        event = "FileType";
        pattern = [ "markdown" "rust" "toml" ];
        callback = {
          __raw = ''
            function()
              vim.cmd("highlight Invalid ctermbg=red guibg=red")
              vim.fn.matchadd("Invalid", [[\s*\t\s*\|\s*\t\s*\|\s\+$\|[^\x00-\xff]\+]])
            end
          '';
        };
      }
    ];
  };
}
