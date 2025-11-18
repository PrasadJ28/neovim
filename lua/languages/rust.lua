-- lua/languages/rust.lua

-- rustaceanvim is configured through vim.g.rustaceanvim
-- This file provides a clean minimal config following your modular layout

local M = {}

M.setup = function()
  vim.g.rustaceanvim = {
    tools = {
      float_win_config = {
        border = "rounded",
      },
    },

    server = {
      on_attach = function(client, bufnr)
        -- Shared LSP keymaps (if you want them)
        local ok, shared = pcall(require, "languages.shared")
        if ok then shared.on_attach(client, bufnr) end

        -- Rust-specific keymaps
        vim.keymap.set("n", "<leader>dr", function()
          vim.cmd("RustLsp debuggables")
        end, { desc = "Rust Debuggables", buffer = bufnr })

        vim.keymap.set("n", "<leader>cR", function()
          vim.cmd("RustLsp codeAction")
        end, { desc = "Rust Code Action", buffer = bufnr })
      end,

      default_settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = { enable = true },
          },
          procMacro = { enable = true },
          files = {
            watcher = "client",
          },
        },
      },
    },

    dap = {
      -- Rustaceanvim automatically finds codelldb if installed through Mason
      autoload_configurations = true,
    },
  }
end

return M

