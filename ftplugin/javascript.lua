-- lua/ftplugin/javascript.lua

-- JavaScript indentation
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

-- JS comment style
vim.bo.commentstring = "// %s"

-- Buffer-local keymaps
local opts = { buffer = true }

-- Format using LSP or null-ls (eslint/prettier)
vim.keymap.set("n", "<leader>jf", function()
  vim.lsp.buf.format({ async = true })
end, vim.tbl_extend("force", opts, { desc = "JS: Format file" }))

-- Run current file with Node
vim.keymap.set("n", "<leader>jr", function()
  local file = vim.fn.expand("%")
  vim.cmd("split | terminal node " .. file)
end, vim.tbl_extend("force", opts, { desc = "JS: Run file" }))

