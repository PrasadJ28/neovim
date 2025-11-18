return {

  ------------------------------------------------------------------
  -- Core DAP and UI
  ------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local function safe_continue()
        local ft = vim.bo.filetype
        local configs = dap.configurations[ft]
        if not configs or vim.tbl_isempty(configs) then
          vim.notify(
            "No debug configuration for filetype: " .. ft,
            vim.log.levels.WARN,
            { title = "nvim-dap" }
          )
          return
        end
        dap.continue()
      end

      -- Main debug keymaps
      vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle breakpoint" })
      vim.keymap.set("n", "<leader>ds", safe_continue, { desc = "[D]ebug [S]tart or continue" })
      vim.keymap.set("n", "<leader>dc", function()
        dapui.close()
        dap.terminate()
      end, { desc = "[D]ebug [C]lose" })

      -- Variable and inspection windows
      vim.keymap.set("n", "<leader>dh", function()
        require("dap.ui.widgets").hover()
      end, { desc = "[D]ebug [H]over value" })

      vim.keymap.set("n", "<leader>df", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end, { desc = "[D]ebug scopes [F]loat" })

      -- GO DEBUGGER (Delve) ----------------------------------------------------
    local dap = require("dap")

    dap.adapters.go = function(callback)
      local handle
      local pid_or_err
      local port = 38697

      handle, pid_or_err = vim.loop.spawn("dlv", {
        args = { "dap", "-l", "127.0.0.1:" .. port },
        detached = true
      }, function(code)
        handle:close()
      end)

      -- Wait for Delve to boot
      vim.defer_fn(function()
        callback({ type = "server", host = "127.0.0.1", port = port })
      end, 100)
    end

    dap.configurations.go = {
      {
        type = "go",
        name = "Debug File",
        request = "launch",
        program = "${file}"
      },
      {
        type = "go",
        name = "Debug Module",
        request = "launch",
        program = "${workspaceFolder}"
      }
    }

    end,
  },

  ------------------------------------------------------------------
  -- Mason DAP adapter manager
  ------------------------------------------------------------------
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    config = function()
      local mason_dap = require("mason-nvim-dap")

      mason_dap.setup({
        ensure_installed = {
          "java-debug-adapter",
          "java-test",
          "codelldb",   -- C, C plus plus, Rust
          "python",     -- debugpy
          "delve",      -- Go
        },
        automatic_installation = true,
      })
    end,
  },

}

