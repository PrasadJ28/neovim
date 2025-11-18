return {
  --------------------------------------------------------------------
  --  Modern UI Enhancements (IDE-like Neovim)
  --------------------------------------------------------------------

  -------------------------------------------
  -- 1. Noice (Command UI + LSP UI + Popups)
  -------------------------------------------
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      presets = {
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },

  ---------------------------------------------------------
  -- 2. Notify (Better notifications instead of echo area)
  ---------------------------------------------------------
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      vim.notify = require("notify")
    end,
  },

  ---------------------------------------------------------
  -- 3. Neo-tree (Modern File Explorer)
  ---------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
    },
    opts = {
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_default",
      },
    },
  },

  ---------------------------------------------------------
  -- 4. Breadcrumbs (like VSCode symbols in winbar)
  ---------------------------------------------------------
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  },

  ---------------------------------------------------------
  -- 5. Outline Sidebar (Symbols tree for current file)
  ---------------------------------------------------------
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<cr>", desc = "Symbols Outline" },
    },
    opts = {},
  },

  ---------------------------------------------------------
  -- 6. ToggleTerm (Integrated Terminal like VS Code)
  ---------------------------------------------------------
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<C-\>]],
        direction = "horizontal",
      })
    end,
  },

  ---------------------------------------------------------
  -- 7. Dressing (Better UI for input and select prompts)
  ---------------------------------------------------------
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  ---------------------------------------------------------
  -- 8. Gitsigns (Git gutter, inline blame)
  ---------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
      },
    },
  },

  ---------------------------------------------------------
  -- 9. Diffview (VS Code style Git Diff panel)
  ---------------------------------------------------------
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
  },

  ---------------------------------------------------------
  -- 10. Project Manager (Auto detect project roots)
  ---------------------------------------------------------
  {
    "ahmedkhalf/project.nvim",
    config = function()
    require("project_nvim").setup({
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "mvnw", "gradlew", "package.json" },
    })
  end,
  },

  ---------------------------------------------------------
  -- 11. Alpha Dashboard (Startup screen)
  ---------------------------------------------------------
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },

  ---------------------------------------------------------
  -- 12. Dropbar (IntelliJ-like breadcrumbs + menu)
  ---------------------------------------------------------
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
    },
  },
}
