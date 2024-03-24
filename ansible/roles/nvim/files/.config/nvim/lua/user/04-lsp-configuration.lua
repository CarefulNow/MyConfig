local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		"ansiblels",                      --ansible
		"bashls",                         --bash
		"clangd",                         --C/C++
		"cmake",                          --cmake
		"cssls",                          --css
		"codeqlls",                       --codeql
		"cucumber_language_server",       --cucumber
		"dockerls",                       --docker
		"gopls",                          --go
		"graphql",                        --graphql
		"html",                           --html
		"jsonls",                         --json
		"jdtls",                          --java
		"java-test",                      --more java
		"java-debug-adapter",             --even more java
		"tsserver",                       --javascript
		"kotlin_language_server",         --Kotlin
		"texlab",                         --latex
		"remark_ls",                      --markdown
		"perlnavigator",                  --perl
		"puppet",                         --puppet
		"jedi_language_server",           --python
		"solargraph",                     --ruby
		"rust_analyzer",                  --rust
		"sqlls",                          --sql
		"sumneko_lua",                    --lua
		"taplo",                          --TOML
		"terraformls",                    --terraform
		"tflint",                         --terraform linting
		"tsserver",                       --Typescript
		"lemminx",                        --XML
		"yamlls"                          --YAML
	},
	handlers = {
		lsp_zero.default_setup,
	},
})
--
--local config = {
--	cmd = {'/path/to/jdt-language-server/bin/jdtls'},
--	root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
--}
--require('jdtls').start_or_attach(config)
