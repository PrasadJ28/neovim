-- lua/ftplugin/go.lua

-- Go indentation (Tabs are the Go standard)
vim.bo.expandtab = false
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4

-- Go comment style
vim.bo.commentstring = "// %s"

-- Optional: Go-specific keymaps
local opts = { buffer = true }

-- Format using gopls
vim.keymap.set("n", "<leader>gf", function()
  vim.lsp.buf.format({ async = true })
end, vim.tbl_extend("force", opts, { desc = "Go: Format file" }))

-- Optional: go run current file
vim.keymap.set("n", "<leader>gr", function()
  local file = vim.fn.expand("%")
  vim.cmd("split | terminal go run " .. file)
end, vim.tbl_extend("force", opts, { desc = "Go: Run file" }))

