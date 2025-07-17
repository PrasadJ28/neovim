return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    vim.keymap.set('n','<leader>e','<cmd>NvimTreeToggle<CR>',{desc = "Toggle [E]xplorer"})
    require("nvim-tree").setup({
      hijack_netrw = true,
      auto_reload_on_write = true,
    })
  end
}

--Space e - open file explorer
--on folder click a - to add file
--on file click r - to rename file
--on file click d - to delete file

