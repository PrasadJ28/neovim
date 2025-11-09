return {
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      local wk = require("which-key")

      wk.setup()

      -- Display top-level group names
      wk.add({
        { "<leader>/", group = "Comments" },
        { "<leader>c", group = "[C]ode" },
        { "<leader>d", group = "[D]ebug" },
        { "<leader>e", group = "[E]xplorer" },
        { "<leader>f", group = "[F]ind" },
        { "<leader>g", group = "[G]it" },
        { "<leader>J", group = "[J]ava" },
        { "<leader>w", group = "[W]indow" },
        { "<leader>o", group = "[O]verseer / Tasks" },
      })

      -- ✅ Overseer mappings (new format)
      wk.add({
        { "<leader>ol", "<Cmd>OverseerLoadBundle<CR>", desc = "Load Task Bundle" },
        { "<leader>oo", "<Cmd>OverseerToggle<CR>", desc = "Open Task List" },
        { "<leader>or", "<Cmd>OverseerRun<CR>", desc = "Run Task" },
        { "<leader>os", "<Cmd>OverseerSaveBundle<CR>", desc = "Save Task Bundle" },
        { "<leader>ot", "<Cmd>Telescope overseer<CR>", desc = "Task Telescope" },
      })

      -- ✅ Java / Spring Boot mappings (new format)
      wk.add({
        { "<leader>Jc", "<Cmd>lua require('springboot-nvim').generate_class()<CR>", desc = "Create Class" },
        { "<leader>Je", "<Cmd>lua require('springboot-nvim').generate_enum()<CR>", desc = "Create Enum" },
        { "<leader>Ji", "<Cmd>lua require('springboot-nvim').generate_interface()<CR>", desc = "Create Interface" },
        { "<leader>Jl", "<Cmd>OverseerLoadBundle<CR>", desc = "Load Task Bundle" },
        { "<leader>Jo", "<Cmd>OverseerToggle<CR>", desc = "Open Tasks" },
        { "<leader>Jr", "<Cmd>OverseerRun<CR>", desc = "Run Task" },
        { "<leader>Js", "<Cmd>OverseerSaveBundle<CR>", desc = "Save Task Bundle" },
        { "<leader>Jt", "<Cmd>Telescope overseer<CR>", desc = "Task Telescope" },
      })
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

