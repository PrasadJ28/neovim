-- lua/ftplugin/typescript.lua

-- Indentation rules for TS
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

-- Correct comment style
vim.bo.commentstring = "// %s"

-- Buffer-local keymaps
local opts = { buffer = true }

-- Format using LSP (tsserver or eslint_d/prettier via null-ls)
vim.keymap.set("n", "<leader>tf", function()
  vim.lsp.buf.format({ async = true })
end, vim.tbl_extend("force", opts, { desc = "TS: Format file" }))

-- Run file with node (rarely needed but nice for quick checks)
vim.keymap.set("n", "<leader>tr", function()
  local file = vim.fn.expand("%")
  vim.cmd("split | terminal node " .. file)
end, vim.tbl_extend("force", opts, { desc = "TS: Run file" }))

