-- lua/ftplugin/rust.lua

-- Rust indentation style
vim.bo.expandtab = true        -- spaces, not tabs
vim.bo.shiftwidth = 4          -- rustfmt default
vim.bo.tabstop = 4
vim.bo.softtabstop = 4

-- Rust comment style
vim.bo.commentstring = "// %s"

-- Rust-specific keymaps (buffer-local)
local opts = { buffer = true }

-- Format using rust-analyzer / rustfmt
vim.keymap.set("n", "<leader>rf", function()
  vim.lsp.buf.format({ async = true })
end, vim.tbl_extend("force", opts, { desc = "Rust: Format file" }))

-- Run cargo build
vim.keymap.set("n", "<leader>rb", function()
  vim.cmd("split | terminal cargo build")
end, vim.tbl_extend("force", opts, { desc = "Rust: Build project" }))

-- Run cargo run
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd("split | terminal cargo run")
end, vim.tbl_extend("force", opts, { desc = "Rust: Run project" }))

