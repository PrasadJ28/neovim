-- lua/languages/cpp.lua

local M = {}

M.setup = function()
  local lspconfig = require("lspconfig")

  -- Shared LSP defaults
  local ok, shared = pcall(require, "languages.shared")
  local capabilities = ok and shared.capabilities or vim.lsp.protocol.make_client_capabilities()
  local on_attach = ok and shared.on_attach or function() end

  --------------------------------------------------------------------
  -- C / C++ LSP (clangd)
  --------------------------------------------------------------------
  lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
    },
  })

  --------------------------------------------------------------------
  -- clang-format formatting via none-ls
  --------------------------------------------------------------------
  local ok_null, null_ls = pcall(require, "null-ls")
  if ok_null then
    null_ls.register(null_ls.builtins.formatting.clang_format)
  end
end

return M

