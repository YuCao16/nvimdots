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
settings["disabled_plugins"] = {
	"fatih/vim-go",
	"rainbowhxch/accelerated-jk.nvim",
	"m4xshen/autoclose.nvim",
	"max397574/better-escape.nvim",
	"ojroques/nvim-bufdel",
	"RRethy/vim-illuminate",
	"romainl/vim-cool",
	-- "nvimdev/lspsaga.nvim",
	"stevearc/aerial.nvim",
	"goolord/alpha-nvim",
	"zbirenbaum/neodim",
	"dstein64/nvim-scrollview",
	"edluffy/specs.nvim",
	"nvim-tree/nvim-tree.lua",
	"ibhagwan/smartyank.nvim",
}
return settings
