-- lua/languages/elixir.lua

local M = {}

M.setup = function()
  local lspconfig = require("lspconfig")

  -- Pull shared LSP defaults
  local ok, shared = pcall(require, "languages.shared")
  local capabilities = ok and shared.capabilities or vim.lsp.protocol.make_client_capabilities()
  local on_attach = ok and shared.on_attach or function() end

  --------------------------------------------------------------------
  -- Elixir LSP (elixirls)
  --------------------------------------------------------------------
  lspconfig.elixirls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      elixirLS = {
        -- Turn off dialyzer if it's too slow for you
        dialyzerEnabled = true,
        fetchDeps = false,
      },
    },
  })

  --------------------------------------------------------------------
  -- none-ls formatters: mix
  --------------------------------------------------------------------
  local ok_null, null_ls = pcall(require, "null-ls")
  if ok_null then
    null_ls.register(null_ls.builtins.formatting.mix)
  end

  --------------------------------------------------------------------
  -- Elixir DAP (Debugger)
  --------------------------------------------------------------------
  local ok_dap, dap = pcall(require, "dap")
  if ok_dap then
    -- Configure the adapter that Mason installs
    dap.adapters.mix_task = {
      type = "executable",
      -- This path points to the debugger script installed by Mason
      command = vim.fn.stdpath("data") .. "/mason/bin/elixir-ls-debugger",
      args = {},
    }

    dap.configurations.elixir = {
      {
        type = "mix_task",
        name = "mix test",
        task = "test",
        taskArgs = { "--trace" },
        request = "launch",
        startApps = true, -- for Phoenix projects
        projectDir = "${workspaceFolder}",
        requireFiles = {
          "test/**/test_helper.exs",
          "test/**/*_test.exs",
        },
      },
      {
        type = "mix_task",
        name = "Phoenix Server",
        task = "phx.server",
        request = "launch",
        projectDir = "${workspaceFolder}",
        exitAfterTaskReturns = false,
        debugAutoInterpretAllModules = false,
      },
    }
  end
end

return M
