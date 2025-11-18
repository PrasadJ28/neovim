-- lua/languages/java.lua

local jdtls = require("jdtls")
local home = vim.fn.expand("~")

-- Identify project root
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

-- Mason jdtls install paths
local mason_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local launcher = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = mason_path .. "/config_linux"
local lombok = mason_path .. "/lombok.jar"

-- Workspace per project
local workspace = home .. "/.local/share/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- DAP bundles (Java Debug + Java Test)
local bundles = {}

-- java-debug
local java_debug = vim.fn.glob(home .. "/java-debug/com.microsoft.java.debug.plugin/target/*.jar")
if java_debug and java_debug ~= "" then
  table.insert(bundles, java_debug)
end

-- java-test
local test_bundles = vim.split(vim.fn.glob(home .. "/vscode-java-test/server/*.jar"), "\n")
for _, jar in ipairs(test_bundles) do
  if jar ~= "" then
    table.insert(bundles, jar)
  end
end

-- LSP capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

------------------------------------------------------------------------
-- LSP + DAP
------------------------------------------------------------------------
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

  init_options = {
    bundles = bundles,
  },

  on_attach = function(client, bufnr)
    -- Standard LSP keymaps handled by global LSP config
    -- Java-specific on_attach
    require("jdtls.setup").add_commands()
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
  end,

  capabilities = capabilities,
}

-- Start or attach jdtls
jdtls.start_or_attach(config)

