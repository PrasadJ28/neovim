return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({

        -- v19: adapters now live under adapters.http.*
        adapters = {
          http = {
            ollama = function()
              return require("codecompanion.adapters").extend("ollama", {
                schema = {
                  model = {
                    default = "qwen2.5-coder:7b-instruct-q4_K_M",
                  },
                },
              })
            end,
          },
        },

        -- v19: "strategies" renamed to "interactions"
        interactions = {
          chat   = { adapter = "ollama" },
          inline = { adapter = "ollama" },
        },

        -- v19: prompt_library uses "interaction" not "strategy"
        prompt_library = {

          ["AnalyzeCode"] = {
            interaction  = "chat",
            description  = "Analyze selected code for issues, complexity, and improvements",
            opts         = { modes = { "v" }, auto_submit = true, alias = "analyzecode" },
            prompts = {
              {
                role = "user",
                content = function(context)
                  local code = require("codecompanion.helpers.actions").get_code(
                    context.start_line, context.end_line)
                  return string.format(
                    "Analyze this %s code:\n\n```%s\n%s\n```\n\nCover: 1) What it does, 2) Potential bugs, 3) Performance issues, 4) Suggestions.",
                    context.filetype, context.filetype, code)
                end,
              },
            },
          },

          ["ExplainCode"] = {
            interaction  = "chat",
            description  = "Explain what selected code does in plain English",
            opts         = { modes = { "v" }, auto_submit = true, alias = "explaincode" },
            prompts = {
              {
                role = "user",
                content = function(context)
                  local code = require("codecompanion.helpers.actions").get_code(
                    context.start_line, context.end_line)
                  return string.format(
                    "Explain this %s code clearly:\n\n```%s\n%s\n```",
                    context.filetype, context.filetype, code)
                end,
              },
            },
          },

          ["FixCode"] = {
            interaction  = "inline",
            description  = "Fix bugs in selected code and replace inline",
            opts         = { modes = { "v" }, auto_submit = true, alias = "fixcode" },
            prompts = {
              {
                role = "user",
                content = function(context)
                  local code = require("codecompanion.helpers.actions").get_code(
                    context.start_line, context.end_line)
                  return string.format(
                    "Fix any bugs in this %s code. Return ONLY the corrected code, no explanation:\n\n```%s\n%s\n```",
                    context.filetype, context.filetype, code)
                end,
              },
            },
          },

          ["RefactorCode"] = {
            interaction  = "inline",
            description  = "Refactor selected code for clarity and performance",
            opts         = { modes = { "v" }, auto_submit = true, alias = "refactorcode" },
            prompts = {
              {
                role = "user",
                content = function(context)
                  local code = require("codecompanion.helpers.actions").get_code(
                    context.start_line, context.end_line)
                  return string.format(
                    "Refactor this %s code for better readability and performance. Return ONLY the refactored code:\n\n```%s\n%s\n```",
                    context.filetype, context.filetype, code)
                end,
              },
            },
          },

          ["GenerateTests"] = {
            interaction  = "chat",
            description  = "Generate unit tests for selected code",
            opts         = { modes = { "v" }, auto_submit = true, alias = "generatetests" },
            prompts = {
              {
                role = "user",
                content = function(context)
                  local code = require("codecompanion.helpers.actions").get_code(
                    context.start_line, context.end_line)
                  return string.format(
                    "Write unit tests for this %s code:\n\n```%s\n%s\n```",
                    context.filetype, context.filetype, code)
                end,
              },
            },
          },

          ["AddDocumentation"] = {
            interaction  = "inline",
            description  = "Add docstrings and comments to selected code",
            opts         = { modes = { "v" }, auto_submit = true, alias = "adddocs" },
            prompts = {
              {
                role = "user",
                content = function(context)
                  local code = require("codecompanion.helpers.actions").get_code(
                    context.start_line, context.end_line)
                  return string.format(
                    "Add proper documentation and comments to this %s code. Return ONLY the documented code:\n\n```%s\n%s\n```",
                    context.filetype, context.filetype, code)
                end,
              },
            },
          },

          ["AnalyzeFile"] = {
            interaction  = "chat",
            description  = "Analyze the entire current file",
            opts         = { modes = { "n" }, auto_submit = true, alias = "analyzefile" },
            prompts = {
              {
                role = "user",
                content = function(context)
                  local lines   = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                  local content = table.concat(lines, "\n")
                  local filename = vim.fn.expand("%:t")
                  return string.format(
                    "Analyze this file '%s':\n\n```%s\n%s\n```\n\nCover: architecture, potential issues, improvements, and code quality.",
                    filename, context.filetype, content)
                end,
              },
            },
          },

          ["AnalyzeProject"] = {
            interaction  = "chat",
            description  = "Analyze the project structure and architecture",
            opts         = { modes = { "n" }, auto_submit = true, alias = "analyzeproject" },
            prompts = {
              {
                role = "user",
                content = function()
                  local handle = io.popen("find . -type f -not -path '*/.*' -not -path '*/node_modules/*' -not -path '*/vendor/*' | head -60 2>/dev/null")
                  local tree   = handle and handle:read("*a") or "Could not read project"
                  if handle then handle:close() end
                  local cwd = vim.fn.getcwd()
                  return string.format(
                    "Analyze this project at '%s'.\n\nFile structure:\n```\n%s\n```\n\nDescribe: architecture, tech stack, entry points, and improvement suggestions.",
                    cwd, tree)
                end,
              },
            },
          },

        },
      })

      -- ── Chat panel ────────────────────────────────────────────────────────
      vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanionChat<cr>",        { desc = "AI Chat" })
      vim.keymap.set("n", "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat Toggle" })

      -- ── Actions menu ──────────────────────────────────────────────────────
      vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>",     { desc = "AI Actions" })
      vim.keymap.set("v", "<leader>aa", "<cmd>CodeCompanionActions<cr>",     { desc = "AI Actions on selection" })

      -- ── Visual selection ──────────────────────────────────────────────────
      vim.keymap.set("v", "<leader>ae", "<cmd>CodeCompanionChat Add<cr>",    { desc = "Add selection to chat" })
      vim.keymap.set("v", "<leader>af", function() require("codecompanion").prompt("fixcode") end,       { desc = "AI Fix (inline)" })
      vim.keymap.set("v", "<leader>ar", function() require("codecompanion").prompt("refactorcode") end,  { desc = "AI Refactor (inline)" })
      vim.keymap.set("v", "<leader>ax", function() require("codecompanion").prompt("analyzecode") end,   { desc = "AI Analyze selection" })
      vim.keymap.set("v", "<leader>ad", function() require("codecompanion").prompt("adddocs") end,       { desc = "AI Add Docs (inline)" })
      vim.keymap.set("v", "<leader>ag", function() require("codecompanion").prompt("generatetests") end, { desc = "AI Generate Tests" })
      vim.keymap.set("v", "<leader>az", function() require("codecompanion").prompt("explaincode") end,   { desc = "AI Explain selection" })

      -- ── Normal mode ───────────────────────────────────────────────────────
      vim.keymap.set("n", "<leader>aF", function() require("codecompanion").prompt("analyzefile") end,    { desc = "AI Analyze File" })
      vim.keymap.set("n", "<leader>aP", function() require("codecompanion").prompt("analyzeproject") end, { desc = "AI Analyze Project" })

      -- ── Free-form inline prompt ───────────────────────────────────────────
      vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanion<cr>",            { desc = "AI Inline Prompt" })
      vim.keymap.set("v", "<leader>ac", "<cmd>CodeCompanion<cr>",            { desc = "AI Inline Prompt on selection" })

    end,
  },
}

-- ─── Keymaps Reference ──────────────────────────────────────────────────────
--
-- CHAT
--   <leader>ai   Open AI chat panel
--   <leader>at   Toggle AI chat panel
--
-- ACTIONS MENU (normal + visual)
--   <leader>aa   Open all AI actions menu
--
-- VISUAL SELECTION (highlight code first)
--   <leader>ae   Add selection to chat window
--   <leader>af   Fix bugs → replaces inline
--   <leader>ar   Refactor → replaces inline
--   <leader>ax   Analyze selection → opens chat
--   <leader>ad   Add docs/comments → replaces inline
--   <leader>ag   Generate tests → opens chat
--   <leader>az   Explain code → opens chat
--   <leader>ac   Free-form inline prompt on selection
--
-- NORMAL MODE (file/project)
--   <leader>aF   Analyze entire current file
--   <leader>aP   Analyze project structure (runs find)
--   <leader>ac   Free-form inline prompt
--
-- STRATEGIES (v19: now called "interactions")
--   inline   → replaces selected buffer text directly
--   chat     → opens side panel for discussion
--
-- PROMPT LIBRARY (triggered via alias)
--   alias: analyzecode     analyze highlighted code (bugs, perf, suggestions)
--   alias: explaincode     plain English explanation of selection
--   alias: fixcode         fix bugs inline (inline interaction)
--   alias: refactorcode    refactor for clarity/perf inline
--   alias: generatetests   write unit tests for selection
--   alias: adddocs         add docstrings/comments inline
--   alias: analyzefile     analyze entire current buffer
--   alias: analyzeproject  walk project with find, analyze structure
--
-- CHAT WINDOW USAGE
--   Type message → Enter (normal mode)    send message to LLM
--   Type message → Ctrl+s (insert mode)   send message to LLM
--   ga                                     change adapter for current chat
--   gc                                     insert a codeblock
--   gd                                     view/debug chat contents
--   gr                                     regenerate last response
--   gx                                     clear chat buffer
--   gy                                     yank last codeblock
--   [[  / ]]                               move between headers
--   ?                                      show all chat keymaps
--
-- OLLAMA
--   ollama serve                           start Ollama if LLM not responding
