-- lua/languages/lua.lua

local M = {}

M.setup = function()
  local lspconfig = require("lspconfig")

  -- Shared defaults
  local ok, shared = pcall(require, "languages.shared")
  local capabilities = ok and shared.capabilities or vim.lsp.protocol.make_client_capabilities()
  local on_attach = ok and shared.on_attach or function() end

  --------------------------------------------------------------------
  -- Lua Language Server (lua_ls)
  --------------------------------------------------------------------
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },         -- Avoid "undefined global vim"
        },
        workspace = {
          checkThirdParty = false,     -- Avoid annoying prompts
          library = {
            vim.env.VIMRUNTIME,        -- Nvim runtime files
            "${3rd}/luv/library",      -- Lua + libuv types
            "${3rd}/busted/library",   -- Test framework types
          },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
end

return M

