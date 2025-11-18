-- lua/ftplugin/python.lua

-- Python indentation (PEP 8: 4 spaces)
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4

-- Python comment style
vim.bo.commentstring = "# %s"

-- Buffer-local keymaps
local opts = { buffer = true }

-- Format using LSP (pyright + black/null-ls if available)
vim.keymap.set("n", "<leader>pf", function()
  vim.lsp.buf.format({ async = true })
end, vim.tbl_extend("force", opts, { desc = "Python: Format file" }))

-- Run current file with Python
vim.keymap.set("n", "<leader>pr", function()
  local file = vim.fn.expand("%")
  vim.cmd("split | terminal python3 " .. file)
end, vim.tbl_extend("force", opts, { desc = "Python: Run file" }))

