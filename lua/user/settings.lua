-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["colorscheme"] = "onedark"

-- Set to cmp menu max width
---@type number
settings["cmp_max_width"] = 45

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
