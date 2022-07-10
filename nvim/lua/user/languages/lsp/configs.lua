local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local server_configs = {
	-- Use null_ls for formatting
	sumneko_lua = require("user.languages.lua.sumneko"),
	tsserver = require("user.languages.typescript.tsserver"),
	eslint = require("user.languages.typescript.eslint"),
	gopls = require("user.languages.go.gopls"),
	terraformls = require("user.languages.terraform.terraformls"),
	dockerls = require("user.languages.docker.dockerls"),
	svelte = require("user.languages.svelte.init"),
	jsonls = require("user.languages.json.jsonls"),
	ansiblels = require("user.languages.ansible.ansiblels"),
	pyright = require("user.languages.python.init"),
	-- jsonls = require("lsp.jsonls").config,
	-- Conflicts with prettier formatting in TS files.
	-- bashls = default_server_config,
	-- cssls = default_server_config,
	-- yamlls = require("user.lsp.settings.yamlls"),
}

local function setup_lsp_servers()
	for server_name, server_config in pairs(server_configs) do
		lspconfig[server_name].setup(server_config)
	end
	-- lspconfig.diagnosticls.setup {
	-- filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "css"},
	-- init_options = {
	--   filetypes = {
	--     javascript = "eslint",
	--     typescript = "eslint",
	--     javascriptreact = "eslint",
	--     typescriptreact = "eslint"
	--   },
	--   linters = {
	--     eslint = {
	--       sourceName = "eslint",
	--       command = "./node_modules/.bin/eslint",
	--       rootPatterns = {
	--         ".eslitrc.js",
	--         "package.json"
	--       },
	--       debounce = 100,
	--       args = {
	--         "--cache",
	--         "--stdin",
	--         "--stdin-filename",
	--         "%filepath",
	--         "--format",
	--         "json"
	--       },
	--       parseJson = {
	--         errorsRoot = "[0].messages",
	--         line = "line",
	--         column = "column",
	--         endLine = "endLine",
	--         endColumn = "endColumn",
	--         message = "${message} [${ruleId}]",
	--         security = "severity"
	--       },
	--       securities = {
	--         [2] = "error",
	--         [1] = "warning"
	--       }
	--     }
	--   }
	-- }
	-- }
end

setup_lsp_servers()
