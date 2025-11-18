-- lua/languages/shared.lua

local M = {}

----------------------------------------------------------------
-- 1. Capabilities (completion support via nvim-cmp)
----------------------------------------------------------------
function M.capabilities()
  local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if not ok then
    return vim.lsp.protocol.make_client_capabilities()
  end
  return cmp_lsp.default_capabilities()
end

----------------------------------------------------------------
-- 2. Shared LSP keymaps
----------------------------------------------------------------
function M.set_keymaps(bufnr)
  local opts = { buffer = bufnr }

  vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>cf", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

----------------------------------------------------------------
-- 3. Shared on_attach for all LSP servers
----------------------------------------------------------------
function M.on_attach(client, bufnr)
  -- Set shared keymaps
  M.set_keymaps(bufnr)

  -- Optional: turn off formatting if using null-ls/prettier
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  if client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end
end

----------------------------------------------------------------
-- 4. Shared diagnostic setup
----------------------------------------------------------------
function M.setup_diagnostics()
  vim.diagnostic.config({
    virtual_text = {
      prefix = "●",
      spacing = 2,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
  })
end

return M

