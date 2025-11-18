-- lua/ftplugin/cpp.lua

-- C plus plus indentation
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4

-- Comment style
vim.bo.commentstring = "// %s"

local opts = { buffer = true }

-- Format using clangd or null-ls clang-format
vim.keymap.set("n", "<leader>cf", function()
  vim.lsp.buf.format({ async = true })
end, vim.tbl_extend("force", opts, { desc = "C++: Format file" }))

-- Compile and run C++
vim.keymap.set("n", "<leader>cr", function()
  local file = vim.fn.expand("%:r")
  local src = vim.fn.expand("%")
  vim.cmd("split | terminal g++ " .. src .. " -o " .. file .. " && ./" .. file)
end, vim.tbl_extend("force", opts, { desc = "C++: Build and Run" }))

