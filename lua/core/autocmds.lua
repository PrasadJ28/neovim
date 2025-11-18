print("core.autocmds loaded successfully")

local autocmd = vim.api.nvim_create_autocmd

-- Highlight text after yanking
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 200,
    }
  end,
})

-- Automatically remove trailing spaces on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Reload file if changed outside
autocmd("FocusGained", {
  pattern = "*",
  command = "checktime",
})

-- Make certain filetypes use 4 spaces instead of 2 if you want later
-- (we keep it commented as optional)
-- autocmd("FileType", {
--   pattern = { "python", "go" },
--   callback = function()
--     vim.opt_local.shiftwidth = 4
--     vim.opt_local.tabstop = 4
--     vim.opt_local.softtabstop = 4
--   end,
-- })

-- Better terminal behavior (optional but useful)
autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})

