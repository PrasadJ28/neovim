return {
  ---------------------------------------------------------------------------
  -- Colorscheme
  ---------------------------------------------------------------------------
  {
    "kvrohit/rasmus.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("rasmus")
    end,
  },

  ---------------------------------------------------------------------------
  -- Lualine (statusline)
  ---------------------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- Bufferline
  ---------------------------------------------------------------------------
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          separator_style = "slant",
          show_close_icon = false,
          show_buffer_close_icons = false,
        },
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- Which-Key for keybinding popup
  ---------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  ---------------------------------------------------------------------------
  -- Noice + Notify (improved messages + cmdline UI)
  ---------------------------------------------------------------------------
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({})
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    config = function()
      require("notify").setup({
        stages = "fade",
        timeout = 1500,
      })
      vim.notify = require("notify")
    end,
  },

  ---------------------------------------------------------------------------
  -- Indent Guides
  ---------------------------------------------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- Smooth Scrolling
  ---------------------------------------------------------------------------
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end
  },

  ------------------------------------------------------------------
-- Theme switcher (Themify)
------------------------------------------------------------------
{
  "lmantw/themify.nvim",
  lazy = false,
  priority = 999,
  config = function()
    require("themify").setup({
      "Mofiqul/dracula.nvim",
      "embark-theme/vim",
      "rebelot/kanagawa.nvim",
      --"EdenEast/nightfox.nvim",
      "xiantang/darcula-dark.nvim",
      "shaunsingh/nord.nvim",
      "motaz-shokry/gruvbox.nvim",
      "ntk148v/slack.nvim",
      "dark-orchid/neovim",
      "tiesen243/vercel.nvim",
      "kevinm6/kurayami.nvim",
      "b0o/lavi.nvim",
      "datsfilipe/vesper.nvim",
      "kdheepak/monochrome.nvim",
      "kvrohit/rasmus.nvim",
      "zootedb0t/citruszest.nvim",
      "shaunsingh/moonlight.nvim",
      "AlexvZyl/nordic.nvim",
      "sainnhe/sonokai",
      "bluz71/vim-moonfly-colors",
      "catppuccin/nvim",
      "rose-pine/neovim",
      "mellow-theme/mellow.nvim",
      "kyazdani42/blue-moon",
      "yashguptaz/calvera-dark.nvim",
      "wurli/cobalt.nvim",
      "Everblush/nvim",
      "rktjmp/lush.nvim",
      "default",
    })
  end,
},
--Lush for soem themes
{
  "rktjmp/lush.nvim",
}

}
