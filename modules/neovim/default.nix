{ ... }:

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

    clipboard.register = "unnamedplus";

    globals.mapleader = ",";

    opts = {
      # Use a swapfile for the local buffer.
      swapfile = false;

      # Enable spell checking.
      spell = true;

      # When a bracket is inserted, briefly jump to the matching one if it can be seen on screen.
      showmatch = true;

      # Ignore case in search patterns.
      ignorecase = true;
      # Override the `ignorecase` option if the search pattern contains upper case characters.
      smartcase = true;

      # Enable 24-bit RGB color in the TUI.
      termguicolors = true;
      # When and how to draw the signcolumn (always with a fixed space of 1).
      signcolumn = "yes:1";
      # Print the line number in front of each line.
      number = true;
      # Highlight the text line of the cursor
      cursorline = true;
      # Highlight columns
      colorcolumn = "100";
      # Maximum width of text that is being inserted.
      textwidth = 100;

      # Define the column multiple used to display the horizontal Tab character.
      tabstop = 4;
      # Create soft tab stops, separated by n number of columns.
      softtabstop = 4;
      # Number of columns that make up one level of (auto)indentation.
      shiftwidth = 4;
      # Do smart autoindenting when starting a new line.
      smartindent = true;
      # Use the appropriate number of spaces to insert a <Tab>.
      expandtab = true;
      # Every wrapped line will continue visually indented.
      breakindent = true;
    };

    keymaps =
      let
        mkKeymap = key: action: {
          inherit key action;
          options.silent = true;
        };
        mkNoop = key: mkKeymap key "<Nop>" // {
          mode = [ "n" "v" "i" "c" "t" ];
        };
      in
        [
          (mkNoop "<PageUp>")
          (mkNoop "<PageDown>")
          (mkNoop "<MiddleMouse>")
          (mkNoop "<2-MiddleMouse>")
          (mkNoop "<3-MiddleMouse>")
          (mkNoop "<4-MiddleMouse>")
          (mkKeymap "<leader><Left>" ":bprev<CR>")
          (mkKeymap "<leader><Right>" ":bnext<CR>")
          (mkKeymap "<leader><Down>" ":bdel<CR>")
        ];

    autoCmd = [
      {
        event = "BufWritePre";
        pattern = "*";
        callback = {
          __raw = ''
            function()
              local view = vim.fn.winsaveview()
              vim.cmd([[keeppatterns %s/\s\+$//e]])
              vim.fn.winrestview(view)
            end
          '';
        };
      }
      {
        event = "FileType";
        pattern = [ "javascript" "nix" "xml" "yaml" "html" "json" ];
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
        pattern = [ "xml" ];
          callback = {
            __raw = ''
              function()
                vim.opt_local.wrap = true
                vim.opt_local.linebreak = true
              end
            '';
          };
      }
      {
        event = "FileType";
        pattern = [ "markdown" "rust" "toml" "yaml" ];
        callback = {
          __raw = ''
            function()
              vim.cmd("highlight Invalid ctermbg=red guibg=red")
              vim.fn.matchadd("Invalid", [[\s*\t\s*\|\s\+$\|[^\x00-\xff]\+]])
            end
          '';
        };
      }
    ];
  };
}
