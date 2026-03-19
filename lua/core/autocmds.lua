print("core.autocmds loaded successfully")

local autocmd = vim.api.nvim_create_autocmd

-- Highlight text after yanking
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.hl.on_yank {
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

print("core.autocmds loaded successfully")

local autocmd = vim.api.nvim_create_autocmd

-- 1. Highlight text after yanking
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.hl.on_yank {
      higroup = "IncSearch",
      timeout = 200,
    }
  end,
})

-- 2. Automatically remove trailing spaces on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- 3. Reload file if changed outside
autocmd("FocusGained", {
  pattern = "*",
  command = "checktime",
})

-- 4. Better terminal behavior
autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})

-- =======================================================
-- 🛠️ KRONOS THEME DEV: Auto-Reload on Save
-- =======================================================
-- This section watches your local project folder.
-- When you save a file there, it reloads the theme instantly.
local kronos_dev_path = vim.fn.expand("~/Files/projects/kronos.nvim")
local dev_group = vim.api.nvim_create_augroup("DevThemeReload", { clear = true })

autocmd("BufWritePost", {
  -- Watch all .lua files inside your project directory
  pattern = kronos_dev_path .. "/**/*.lua",
  group = dev_group,
  callback = function()
    -- A. Clear Lua Cache for all 'kronos' modules so Neovim re-reads them
    for k, _ in pairs(package.loaded) do
      if k:match("^kronos") then
        package.loaded[k] = nil
      end
    end

    -- B. Clear Lualine theme cache specifically
    package.loaded["lualine.themes.kronos"] = nil

    -- C. Re-apply the colorscheme safely
    vim.schedule(function()
       -- Note: If you want to force a specific theme variant while testing, uncomment below:
       -- require("kronos").setup({ theme = "dusk" })

       vim.cmd("colorscheme kronos")
       print("⚡ Kronos Theme Reloaded!")
    end)
  end,
})
