return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    local home = os.getenv("HOME")
    local jdtls = require("jdtls")

    local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
    local root_dir = require("jdtls.setup").find_root(root_markers)
    if root_dir == "" then
      return
    end

    local mason = home .. "/.local/share/nvim/mason/packages/jdtls"
    local launcher = mason .. "/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.2.1500.v20250801-0854.jar"
    local config_dir = mason .. "/config_linux"
    local lombok = mason .. "/lombok.jar"

    local workspace = home .. "/.local/share/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    local config = {
      cmd = {
        "java",
        "-javaagent:" .. lombok,
        "-jar", launcher,
        "-configuration", config_dir,
        "-data", workspace,
      },
      root_dir = root_dir,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = function(client, bufnr)
        require("jdtls.setup").add_commands()
        require("jdtls.dap").setup_dap()
        require("jdtls.dap").setup_dap_main_class_configs()

        -- Your java-specific keymaps here if you want
      end,
    }

    jdtls.start_or_attach(config)
  end
}

