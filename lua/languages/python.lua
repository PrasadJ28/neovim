-- lua/languages/python.lua

local M = {}

M.setup = function()
  local lspconfig = require("lspconfig")

  -- Load shared LSP defaults
  local ok, shared = pcall(require, "languages.shared")
  local capabilities = ok and shared.capabilities or vim.lsp.protocol.make_client_capabilities()
  local on_attach = ok and shared.on_attach or function() end

  lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",  -- "off" | "basic" | "strict"
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
  })

  --------------------------------------------------------------------
  -- Formatters for Python (Black + isort) via none-ls
  --------------------------------------------------------------------
  local ok_null, null_ls = pcall(require, "null-ls")
  if ok_null then
    null_ls.register(null_ls.builtins.formatting.black)
    null_ls.register(null_ls.builtins.formatting.isort)
  end
end

return M

