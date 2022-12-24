-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
	"clangd", -- C/C++
	"html", -- HTML
	"jdtls", -- Java
	"lemminx", -- XML
	"intelephense", -- PHP
	"pyright", -- Python
	"sumneko_lua", -- Lua
	"tsserver", -- JavaScript
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		-- on_attach = my_custom_on_attach,
		single_file_support = true,
		capabilities = capabilities,
	})
end
