return {

  ------------------------------------------------------------------
  -- Treesitter
  ------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "windwp/nvim-ts-autotag" },

    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "vim", "vimdoc", "lua",
          "java", "javascript", "typescript",
          "html", "css", "json", "tsx",
          "markdown", "markdown_inline", "gitignore"
        },

        highlight = { enable = true },
        autotag = { enable = true },
      })
    end,
  },

  ------------------------------------------------------------------
  -- Snippets (LuaSnip)
  ------------------------------------------------------------------
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  ------------------------------------------------------------------
  -- Completion sources
  ------------------------------------------------------------------
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },

  ------------------------------------------------------------------
  -- nvim-cmp (Completion UI)
  ------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        completion = { completeopt = "menu,menuone,preview,noselect" },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  ------------------------------------------------------------------
  -- Autopairs
  ------------------------------------------------------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },

    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  ------------------------------------------------------------------
  -- Comment.nvim
  ------------------------------------------------------------------
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },

    config = function()
      vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment Line" })
      vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment Selected" })

      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim")
          .create_pre_hook(),
      })
    end,
  },

}

