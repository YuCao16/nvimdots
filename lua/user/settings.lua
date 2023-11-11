-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["colorscheme"] = "onedark"
settings["diagnostics_virtual_text"] = false
settings["format_on_save"] = false
settings["lsp_deps"] = {
	"bashls",
	"clangd",
	"html",
	"jsonls",
	"lua_ls",
	"pyright",
	"jedi_language_server",
	"gopls",
}
return settings
