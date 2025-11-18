-- lua/languages/typescript.lua

local shared = require("languages.shared")
local lspconfig = require("lspconfig")

-- TypeScript / JavaScript LSP config (tsserver)
lspconfig.ts_ls.setup({
  capabilities = shared.capabilities(),
  on_attach = function(client, bufnr)
    -- Shared keymaps
    shared.on_attach(client, bufnr)

    -- Disable tsserver formatting (you use prettier/null-ls)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

