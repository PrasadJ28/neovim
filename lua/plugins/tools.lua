return {

  ------------------------------------------------------------------
  -- Telescope
  ------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]inder [R]esume" })
      vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "[F]ind Recent Files" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind Help" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind Keymaps" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect" })
      vim.keymap.set("n", "<leader>ot", "<cmd>Telescope overseer<cr>", { desc = "Overseer Tasks" })
    end,
  },

  ------------------------------------------------------------------
  -- Telescope UI Select
  ------------------------------------------------------------------
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },

    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      })

      require("telescope").load_extension("ui-select")
    end,
  },

  ------------------------------------------------------------------
  -- Trouble
  ------------------------------------------------------------------
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    },
  },

  ------------------------------------------------------------------
  -- Harpoon
  ------------------------------------------------------------------
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
      vim.keymap.set("n", "<S-m>", function() require("harpoon.mark").add_file() end,
        { desc = "Harpoon Mark File" })
      vim.keymap.set("n", "<TAB>", function() require("harpoon.ui").toggle_quick_menu() end,
        { desc = "Harpoon Menu" })
    end,
  },

  ------------------------------------------------------------------
  -- Overseer
  ------------------------------------------------------------------
  {
    "stevearc/overseer.nvim",
    lazy = false,
    config = function()
      require("overseer").setup({
        strategy = "terminal",
        templates = { "builtin", "user.java_build" },
        template_dir = vim.fn.stdpath("config") .. "/lua/overseer/templates",
      })
    end,
  },

  ------------------------------------------------------------------
  -- Tmux Navigator
  ------------------------------------------------------------------
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  ------------------------------------------------------------------
  -- Nvim Tree (File Explorer)
  ------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })

      require("nvim-tree").setup({
        hijack_netrw = true,
        auto_reload_on_write = true,
      })
    end,
  },
}
