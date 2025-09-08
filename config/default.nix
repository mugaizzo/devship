{
  pkgs,
  lib,
  ...
}: {
  vim = {
    dashboard.alpha = {
      enable = true;
      theme = "startify";
      # it is unclear how to add the head, skipping for now
      #       opts = { header.val = "{
      # [[⠀⠀⣤⣤⠀⠀⠀       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      # [[⠀⠀⣿⣿⠀ ⠀⣀⣀⡀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      # [[⠀⠀⢸⣿⠀ ⣾⣿⣿⣿⣾⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⡿⠏⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠁⠀⠀⠀⣰⣶⡀⠀⠀⠀⠀]],
      # [[⠀⠀⢸⣿⠀ ⠻⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⢰⣶⣶⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣶⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⣠⣶⣿⣿⠀⠸⣿⣿⣷⣶⣶⣿⣿⡿⠀⠀⠀⠀⠀]],
      # [[⠀⠀⣠⣤⠀ ⠀⠙⢿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠻⢿⣿⣿⣿⣿⣿⣷⣶⣾⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠟⠉⠀⠀⠙⠻⠿⠿⠿⠟⣋⣀⣤⣄⡀⠀⠀]],
      # [[⠀⠀⠈⠉⠀ ⠀⠀⠀⢻⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠻⠿⠿⠿⠛⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⠿⠿⠃⠀⠀]],
      # [[    ⠀⠀⠀                  ⠀⠀⢀⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠉⠀⠀⠀⠀⠀⠀]],
      # [[      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]]
      #   }";};
    };

    clipboard = {
      enable = true;
      registers = "unnamedplus";
      providers.xclip.enable = true;
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    statusline = {
      lualine = {
        enable = true;
        theme = "dracula";
      };
    };
    visuals = {
      nvim-web-devicons.enable = true;
      cinnamon-nvim = {
        enable = true;
        setupOpts = {
          keymaps.basic = true;
          options.mode = "cursor";
        };
      };
    };

    ui.noice.enable = true;

    telescope = {
      enable = true;
    };

    treesitter = {
      enable = true;
      highlight.enable = true;
      fold = true;
      indent.enable = true;
    };

    languages = {
      enableTreesitter = true;
      nix = {
        enable = true;
        format.enable = true;
        format.package = pkgs.alejandra;
        extraDiagnostics = {
          enable = true;
          types = ["statix"];
        };
      };
    };

    lsp.null-ls = {
      enable = true;

      setupOpts.sources = [
        (lib.generators.mkLuaInline
          ''require("null-ls").builtins.formatting.stylua'')
        (lib.generators.mkLuaInline
          ''require("null-ls").builtins.formatting.prettier'')
        (lib.generators.mkLuaInline
          ''require("null-ls").builtins.formatting.shellharden'')
        (lib.generators.mkLuaInline
          ''require("null-ls").builtins.formatting.shfmt'')
        (lib.generators.mkLuaInline
          ''require("null-ls").builtins.formatting.alejandra'')
        (lib.generators.mkLuaInline
          ''require("null-ls").builtins.diagnostics.statix'')
        # (lib.generators.lua-inline ''require("null-ls").builtins.formatting.black'')
        # (lib.generators.lua-inline ''require("null-ls").builtins.formatting.isort'')
        # (lib.generators.lua-inline ''require("null-ls").builtins.diagnostics.mypy'')
        (lib.generators.mkLuaInline
          ''require("null-ls").builtins.diagnostics.ansiblelint'')
        (lib.generators.mkLuaInline
          ''require("null-ls").builtins.formatting.clang_format'')
        # (lib.generators.mkLuaInline
        #   ''require("none-ls").diagnostics.eslint'')
      ];
    };
    options = {
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      ignorecase = true;
      number = true;
      relativenumber = true;
    };

    keymaps = [
      {
        key = "<leader>w";
        mode = ["n"];
        noremap = true;
        action = ":w<CR>";
        silent = true;
        desc = "Save file";
      }
      {
        key = "<C-d>";
        mode = ["n"];
        noremap = true;
        action = "<C-d>zz";
        silent = true;
        desc = "Center after scroll downward half screen";
      }
      {
        key = "<C-u>";
        mode = ["n"];
        noremap = true;
        action = "<C-u>zz";
        silent = true;
        desc = "Center after scroll upward half screen";
      }
      {
        key = "n";
        mode = ["n"];
        noremap = true;
        action = "nzz";
        silent = true;
        desc = "Center after search forward";
      }
      {
        key = "N";
        mode = ["n"];
        noremap = true;
        action = "Nzz";
        silent = true;
        desc = "Center after search backwards";
      }
      {
        key = "<A-Down>";
        mode = ["n"];
        noremap = true;
        action = ":m .+1<CR>==";
        silent = true;
        desc = "Move line Down(n)";
      }
      {
        key = "<A-Down>";
        mode = ["v"];
        noremap = true;
        action = ":m '>+1<CR>gv=gv";
        silent = true;
        desc = "Move line Down(v)";
      }
      {
        key = "<A-Up>";
        mode = ["n"];
        noremap = true;
        action = ":m .-2<CR>==";
        silent = true;
        desc = "Move line Up(n)";
      }
      {
        key = "<A-Up>";
        mode = ["v"];
        noremap = true;
        action = ":m '<-2<CR>gv=gv";
        silent = true;
        desc = "Move line Up(v)";
      }
      # {
      #   key = "<leader>y";
      #   mode = ["n"];
      #   noremap = true;
      #   action = "+y";
      #   # silent = true;
      #   desc = "yank";
      # }
      {
        key = "<leader>y";
        mode = ["x"];
        noremap = true;
        action = "+y";
        # silent = true;
        desc = "yank";
      }
      # {
      #   key = "<leader>y";
      #   mode = ["s"];
      #   noremap = true;
      #   action = "+y";
      #   # silent = true;
      #   desc = "yank";
      # }
      {
        key = "<Space>Y";
        mode = ["n"];
        noremap = true;
        action = "+y$";
        # silent = true;
        desc = "yank";
      }
      {
        key = "<Space>p";
        mode = ["n"];
        noremap = true;
        action = "+p";
        # silent = true;
        desc = "paste";
      }
      {
        key = "<C-h>";
        mode = ["n"];
        noremap = true;
        action = "<C-w>h";
        desc = "move b/w windows";
      }
      {
        key = "<C-j>";
        mode = ["n"];
        noremap = true;
        action = "<C-w>j";
        desc = "move b/w windows";
      }
      {
        key = "<C-k>";
        mode = ["n"];
        noremap = true;
        action = "<C-w>k";
        desc = "move b/w windows";
      }
      {
        key = "K";
        mode = ["n"];
        action = "vim.lsp.buf.hover";
        desc = "buffer hover vim.lsp.buf.hover";
      }
      {
        key = "<leader>gd";
        mode = ["n"];
        action = "vim.lsp.buf.definition";
        desc = "go to definition vim.lsp.buf.definition";
      }
      {
        key = "<leader>gr";
        mode = ["n"];
        action = "vim.lsp.buf.references";
        desc = "go to references vim.lsp.buf.references";
      }
      {
        key = "<leader>ca";
        mode = ["n"];
        action = "vim.lsp.buf.code_action";
        desc = "code action vim.lsp.buf.code_action";
      }
      # {
      #   key = "<leader>fp";
      #   mode = ["n"];
      #   action = "vim.lsp.buf.format";
      #   desc = "format please vim.lsp.buf.format";
      # }
      {
        key = "<leader>c";
        mode = ["n"];
        action = "<cmd>CopilotChatToggle<cr>";
        desc = "Toggle CopilotChat";
      }
      {
        key = "<leader>gp";
        mode = ["n"];
        action = ":Gitsigns preview_hunk<CR>";
        desc = "Gitsigns preview_hunk";
      }
      {
        key = "<leader>gt";
        mode = ["n"];
        action = ":Gitsigns toggle_current_line_blame<CR>";
        desc = "Gitsigns toggle blame";
      }
      # {
      #   key = "<leader>lg";
      #   mode = ["n"];
      #   action = "<cmd>LazyGit<cr>";
      #   desc = "Open Lazygit";
      # }
    ];

    mini = {
      pairs.enable = true;
      surround.enable = true;
      move.enable = true;
      # ai.enable = true;
      # hipatterns.enable = true;
      # cursorword.enabble = true;
    };

    snippets.luasnip.enable = true;

    autocomplete.nvim-cmp = {
      enable = true;
      sourcePlugins = ["luasnip" "cmp-luasnip" "which-key-nvim" "nvim-treesitter" "mini-surround"];
      sources = {
        nvim_lsp = "[LSP]";
        luasnip = "[LuaSnip]";
        buffer = "[buffer]";
      };
    };

    git.vim-fugitive.enable = true;

    terminal.toggleterm.lazygit = {
      enable = true;
      package = pkgs.lazygit;
      direction = "float";
      mappings.open = "<leader>lg";
    };

    notify.nvim-notify = {
      enable = true;
      setupOpts.background_colour = "#000000";
    };
    utility.yazi-nvim = {
      enable = true;
      setupOpts.open_for_directories = true;
    };
    additionalRuntimePaths = [
      # You can list more than one file here.
      ./clipboard.lua
    ];
  };
}
