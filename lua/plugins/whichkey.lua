return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      local which_key = require('which-key')

      which_key.setup()

      which_key.add({
        { "<leader>/", group = "Comments" },
        { "<leader>c", group = "[C]ode" },
        { "<leader>d", group = "[D]ebug" },
        { "<leader>e", group = "[E]xplorer" },
        { "<leader>f", group = "[F]ind" },
        { "<leader>g", group = "[G]it" },
        { "<leader>J", group = "[J]ava" },
        { "<leader>w", group = "[W]indow" },
      }, { mode = "n" })
    end
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.icons").setup()
    end
  }
}

