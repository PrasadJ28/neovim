-- lua/ftplugin/elixir.lua

-- Elixir indentation (2 spaces is standard)
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

-- Elixir comment style
vim.bo.commentstring = "# %s"

-- Optional: Elixir-specific keymaps
local opts = { buffer = true }

-- Format using LSP (ElixirLS) or Mix
vim.keymap.set("n", "<leader>gf", function()
  vim.lsp.buf.format({ async = true })
end, vim.tbl_extend("force", opts, { desc = "Elixir: Format file" }))

-- Optional: Run the current file using elixir
vim.keymap.set("n", "<leader>gr", function()
  local file = vim.fn.expand("%")
  vim.cmd("split | terminal elixir " .. file)
end, vim.tbl_extend("force", opts, { desc = "Elixir: Run file" }))
