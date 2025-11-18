return {

  ---------------------------------------------------------------------------
  -- Mason (LSP, DAP, Formatters installer)
  ---------------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  ---------------------------------------------------------------------------
  -- Mason LSPConfig (auto install and manage language servers)
  ---------------------------------------------------------------------------
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },

    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "gopls",
          "jdtls",
          "pyright",
          "rust_analyzer",
        },
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- LSPConfig (default LSP behavior for all languages)
  ---------------------------------------------------------------------------
  {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    vim.diagnostic.config({
      virtual_text = { prefix = "●", spacing = 2 },
      signs = true,
      underline = true,
      update_in_insert = false,
    })

    local on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }

      vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, opts)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    end

    require("mason-lspconfig").setup({
      handlers = {

        -- default setup for all servers
        function(server)
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,

        -- lua_ls override
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
              },
            },
          })
        end,
      }
    })
  end,
},

}

