-- lua/ftplugin/lua.lua

-- Lua indentation
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

-- Lua comment style
vim.bo.commentstring = "-- %s"

-- Optional: whitespace formatting for Lua code
vim.bo.autoindent = true
vim.bo.smartindent = true

-- Optional: Lua-specific keymaps
local opts = { buffer = true }

vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, vim.tbl_extend("force", opts, { desc = "Lua: Format file" }))

