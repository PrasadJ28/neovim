return {
  "stevearc/overseer.nvim",
  lazy = false,
  config = function()
    require("overseer").setup({
      strategy = "terminal", -- ✅ old syntax expects string, NOT table
      templates = { "builtin", "user.java_build" }, -- ✅ ok for v1.6.0
      template_dir = vim.fn.stdpath("config") .. "/lua/overseer/templates", -- ✅ v1.x uses template_dir not template_dirs
    })
  end,
}

