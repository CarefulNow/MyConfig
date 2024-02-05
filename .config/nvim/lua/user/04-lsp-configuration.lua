require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
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
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

