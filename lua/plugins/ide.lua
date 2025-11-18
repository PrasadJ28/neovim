return {

  ---------------------------------------------------------------------------
  -- Outline Sidebar (Symbols) — like VS Code outline
  ---------------------------------------------------------------------------
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    config = function()
      require("aerial").setup({})
      vim.keymap.set("n", "<leader>ao", "<cmd>AerialToggle!<CR>", { desc = "Toggle Outline" })
    end,
  },

  ---------------------------------------------------------------------------
  -- Test Runner Panel (Java, Go, Python, TS, etc.)
  ---------------------------------------------------------------------------
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      -- Most common test adapters:
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python"),
          require("neotest-go"),
          require("neotest-jest")({
            jestCommand = "npm test --",
          }),
        },
      })

      vim.keymap.set("n", "<leader>tt", "<cmd>lua require('neotest').run.run()<CR>", { desc = "Run Test" })
      vim.keymap.set("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "Run File Tests" })
      vim.keymap.set("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = "Toggle Test Summary" })
    end,
  },

  ---------------------------------------------------------------------------
  -- Refactoring — Extract Function, Variable, Inline, etc.
  ---------------------------------------------------------------------------
  {
    "ThePrimeagen/refactoring.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("refactoring").setup({})
      vim.keymap.set("v", "<leader>re", ":Refactor extract<CR>", { desc = "Extract Function" })
      vim.keymap.set("v", "<leader>rv", ":Refactor extract_var<CR>", { desc = "Extract Variable" })
    end,
  },

  ---------------------------------------------------------------------------
  -- Git UI — like a mini VS Code Git panel
  ---------------------------------------------------------------------------
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neogit").setup({})
      vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Open Git UI" })
    end,
  },

  ---------------------------------------------------------------------------
  -- Git Diff Viewer — side-by-side diffs
  ---------------------------------------------------------------------------
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory"
    },
    config = function()
      require("diffview").setup({})
    end,
  },

  ---------------------------------------------------------------------------
  -- Toggleterm — IDE-style integrated terminal panel
  ---------------------------------------------------------------------------
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        direction = "horizontal",
        size = 15,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- LSP Progress — VS Code-style loading spinner
  ---------------------------------------------------------------------------
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require("fidget").setup({})
    end,
  },

  ---------------------------------------------------------------------------
  -- Breadcrumbs — class > method > block (like JetBrains)
  ---------------------------------------------------------------------------
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup({})
    end,
  },

}

