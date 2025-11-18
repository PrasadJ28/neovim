-- lua/languages/go.lua

local M = {}

M.setup = function()
  local lspconfig = require("lspconfig")

  -- Pull shared LSP defaults
  local ok, shared = pcall(require, "languages.shared")
  local capabilities = ok and shared.capabilities or vim.lsp.protocol.make_client_capabilities()
  local on_attach = ok and shared.on_attach or function() end

  --------------------------------------------------------------------
  -- Go LSP (gopls)
  --------------------------------------------------------------------
  lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      gopls = {
        gofumpt = true,
        analyses = {
          unusedparams = true,
          fieldalignment = true,
        },
        staticcheck = true,
      },
    },
  })

  --------------------------------------------------------------------
  -- none-ls formatters: goimports, gofmt
  --------------------------------------------------------------------
  local ok_null, null_ls = pcall(require, "null-ls")
  if ok_null then
    null_ls.register(null_ls.builtins.formatting.goimports)
    null_ls.register(null_ls.builtins.formatting.gofmt)
  end

  --------------------------------------------------------------------
  -- Go DAP (optional)
  --------------------------------------------------------------------
  local ok_dap, dap = pcall(require, "dap")
  if ok_dap then
    dap.adapters.go = function(callback)
      local handle
      local port = 38697

      handle = vim.loop.spawn("dlv", {
        args = { "dap", "-l", "127.0.0.1:" .. port },
        detached = true,
      }, function()
        handle:close()
      end)

      -- Wait a bit, then connect
      vim.defer_fn(function()
        callback({
          type = "server",
          host = "127.0.0.1",
          port = port,
        })
      end, 300)
    end

    dap.configurations.go = {
      {
        type = "go",
        name = "Debug Go File",
        request = "launch",
        program = "${file}",
      },
    }
  end
end

return M

