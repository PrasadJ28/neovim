-- Set our leader keybinding to space
-- Anywhere you see <leader> in a keymapping specifies the space key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remove search highlights after searching
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

-- Exit Vim's terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- OPTIONAL: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Easily split windows
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Interactive Search and Replace using Noice UI
vim.keymap.set("n", "<leader>r", function()
  -- 1. Ask for the word to search
  vim.ui.input({ prompt = "Search for: " }, function(query)
    if not query or query == "" then return end -- Cancel if empty

    -- 2. Ask for the replacement word
    vim.ui.input({ prompt = "Replace with: " }, function(replace)
      if replace == nil then return end -- Cancel if Esc pressed

      -- 3. Execute the command (Global replace with confirmation)
      -- The 'c' flag asks for confirmation for every match
      vim.cmd("%s/" .. query .. "/" .. replace .. "/gc")
    end)
  end)
end, { desc = "Search and Replace (UI)" })

-- Handle the keys that Tmux is passing through
-- Alt + \ to split vertically inside Neovim
vim.keymap.set('n', '<M-\\>', ':vsplit<CR>', { silent = true })

-- Alt + - to split horizontally inside Neovim
vim.keymap.set('n', '<M-->', ':split<CR>', { silent = true })

vim.api.nvim_set_keymap("n", "<space>ci", ":Telescope lsp_implementations<CR>", { noremap = true, silent = true, desc = "Go to Implementation" })
vim.api.nvim_set_keymap("n", "<space>cr", ":Telescope lsp_references<CR>",      { noremap = true, silent = true, desc = "Go to References" })
