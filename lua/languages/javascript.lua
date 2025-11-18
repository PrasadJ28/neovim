-- lua/languages/javascript.lua

local shared = require("languages.shared")
local lspconfig = require("lspconfig")

-- JavaScript LSP using tsserver (ts_ls)
lspconfig.ts_ls.setup({
  capabilities = shared.capabilities(),
  on_attach = function(client, bufnr)
    -- Shared keymaps
    shared.on_attach(client, bufnr)

    -- Disable formatting (Prettier / eslint_d should handle it)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

