local completion = {}
local use_copilot = require("core.settings").use_copilot

completion["neovim/nvim-lspconfig"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI", "BufReadPost", "BufAdd" },
	config = require("completion.lsp"),
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{
			"Jint-lzxy/lsp_signature.nvim",
			config = require("completion.lsp-signature"),
		},
	},
}
completion["yucao16/lspsaga.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.lspsaga"),
	dependencies = { "nvim-tree/nvim-web-devicons" },
	branch = "finder",
}
completion["dnlhc/glance.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.glance"),
}
completion["joechrisellis/lsp-format-modifications.nvim"] = {
	lazy = true,
	event = "LspAttach",
}
completion["jose-elias-alvarez/null-ls.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("completion.null-ls"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
}
completion["hrsh7th/nvim-cmp"] = {
	lazy = true,
	event = { "InsertEnter", "CmdlineEnter" },
	config = require("completion.cmp"),
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = require("completion.luasnip"),
		},
		{ "lukas-reineke/cmp-under-comparator" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "andersevenrud/cmp-tmux" },
		{ "hrsh7th/cmp-path" },
		{ "f3fora/cmp-spell" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-cmdline" },
		{ "ray-x/cmp-treesitter", commit = "c8e3a74" },
		{ "tzachar/cmp-tabnine", build = "./install.sh", config = require("completion.tabnine") },
		{
			"jellydn/codeium.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
			},
			config = require("completion.codeium"),
		},
	},
}
if use_copilot then
	completion["zbirenbaum/copilot.lua"] = {
		lazy = true,
		cmd = "Copilot",
		event = "InsertEnter",
		config = require("completion.copilot"),
		dependencies = {
			{
				"zbirenbaum/copilot-cmp",
				config = require("completion.copilot-cmp"),
			},
		},
	}
end
completion["kdheepak/cmp-latex-symbols"] = {
	lazy = true,
	ft = { "tex", "latex", "markdown" },
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
}

return completion
