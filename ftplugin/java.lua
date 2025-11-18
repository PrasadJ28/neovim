-- lua/ftplugin/java.lua

-- Java indentation
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

-- Java comment style
vim.bo.commentstring = "// %s"

-- Optional: Java-specific keybindings
local opts = { buffer = true }

vim.keymap.set("n", "<leader>jo", "<cmd>JdtCompile<CR>",
  vim.tbl_extend("force", opts, { desc = "Java: Compile" }))

vim.keymap.set("n", "<leader>jr", "<cmd>JdtUpdateConfig<CR>",
  vim.tbl_extend("force", opts, { desc = "Java: Reload Config" }))

-----------------------------------------------------------------------
-- Java LSP + Debugger (JDTLS)
-----------------------------------------------------------------------
local jdtls_status, jdtls = pcall(require, "jdtls")
if not jdtls_status then
  return
end

local home = os.getenv("HOME")

-- Find project root
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

-- Mason paths
local mason = home .. "/.local/share/nvim/mason/packages/jdtls"
local launcher = vim.fn.glob(mason .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = mason .. "/config_linux"
local lombok = mason .. "/lombok.jar"

-- Workspace folder per project
local workspace = home .. "/.local/share/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-----------------------------------------------------------------------
-- DAP Bundles (Debug + Test)
-----------------------------------------------------------------------
local bundles = {
  home .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin.jar",
}

vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"),
    "\n"
  )
)

-----------------------------------------------------------------------
-- JDTLS Config
-----------------------------------------------------------------------
local config = {
  cmd = {
    "java",
    "-javaagent:" .. lombok,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "-jar", launcher,
    "-configuration", config_dir,
    "-data", workspace,
  },

  root_dir = root_dir,

  -- Debugger!!
  init_options = {
    bundles = bundles,
  },

  -- Enable LSP completion
  capabilities = require("cmp_nvim_lsp").default_capabilities(),

  on_attach = function(client, bufnr)
    require("jdtls.setup").add_commands()
    require("jdtls.dap").setup_dap()
    require("jdtls.dap").setup_dap_main_class_configs()
  end,
}

jdtls.start_or_attach(config)

