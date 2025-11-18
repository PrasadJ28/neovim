print("config.options loaded successfully")

--Left column and similar settings
vim.opt.number = true --display line numbers
--vim.opt.relativenumber = true --display relative line numbers
vim.opt.numberwidth = 2 --set width of line number column
vim.opt.signcolumn = "yes" --always show sign column
vim.opt.wrap = false -- display lines as single line
vim.opt.scrolloff = 10 -- number of lines to keep above/below cursor
vim.opt.sidescrolloff = 8 --number of columns to keep to the left/right of cursor

-- Tab spacing behavior
vim.opt.expandtab = true --convert tabs to spaces
vim.opt.shiftwidth = 2 --number of spaces inserted for each indetion level
vim.opt.tabstop = 2 --number of spaces inserted for tab character
vim.opt.softtabstop  = 2 --number of spaces isnerted for <Tab> key
vim.opt.smartindent = true --enable smart indentation 
vim.opt.breakindent = true --enable line breaking indention

--General Behaviors
vim.g.loaded_netrw = 1 -- disable default file browser
vim.g.loaded_netrwPlugin = 1 --disable plugin for file browser
vim.opt.backup = false --disable backup file creation
vim.opt.clipboard = "unnamedplus" --enable system clipboard access
vim.opt.conceallevel = 0 --show concealed characters in markdown files
vim.opt.fileencoding = "utf-8" --set file encoding UTF-8
vim.opt.mouse = "a" --enable mouse support for things like resizing
vim.opt.showmode = false -- hide mode display
vim.opt.splitbelow = true --force horizantal splits below current window
vim.opt.splitright = true --force vertical splits right of current window
vim.opt.termguicolors = true --enable term GUI colors
vim.opt.timeoutlen = 1000 --set timeout for mapped sequences
vim.opt.undofile = true --enable persistent undo
vim.opt.updatetime =100 -- set faster completion
vim.opt.writebackup = false --preventediting of files being edited elsewhere
vim.opt.cursorline = true --highlight current line

-- Searching Behaviors
vim.opt.hlsearch = true -- highlight all matches in search
vim.opt.ignorecase = true --ignore case in search
vim.opt.smartcase = true -- match case if explicitly stated
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"


