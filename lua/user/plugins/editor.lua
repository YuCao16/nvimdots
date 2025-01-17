local editor = {}

editor["yucao16/persisted.nvim"] = {
	lazy = true,
	cmd = {
		"SessionToggle",
		"SessionStart",
		"SessionStop",
		"SessionSave",
		"SessionLoad",
		"SessionLoadLast",
		"SessionLoadFromFile",
		"SessionDelete",
	},
	config = require("editor.persisted"),
}
editor["gbprod/cutlass.nvim"] = {
	lazy = true,
	event = { "VeryLazy" },
	config = function()
		require("cutlass").setup({ cut_key = "c" })
	end,
}
editor["windwp/nvim-autopairs"] = {
	lazy = true,
	event = { "InsertEnter" },
	config = require("editor.autopairs"),
}
editor["famiu/bufdelete.nvim"] = {
	lazy = true,
	event = { "BufReadPost" },
}
editor["yucao16/nvim-navic"] = {
	lazy = true,
	event = { "BufReadPost" },
	config = require("editor.navic"),
}
editor["yorickpeterse/nvim-window"] = {
	lazy = true,
	event = { "WinNew" },
}
editor["mg979/vim-visual-multi"] = {
	lazy = true,
	branch = "master",
	event = { "CursorHold", "InsertEnter" },
}
editor["kylechui/nvim-surround"] = {
	lazy = true,
	event = { "CursorHold", "InsertEnter" },
	config = true,
}
editor["nmac427/guess-indent.nvim"] = {
	event = { "BufReadPost" },
	config = require("editor.guess_indent"),
}
editor["Wansmer/treesj"] = {
	cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
	config = require("editor.treesj"),
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}
editor["nvim-treesitter/playground"] = {
	lazy = true,
	cmd = { "TSPlaygroundToggle" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}
editor["smoka7/hop.nvim"] = {
	lazy = true,
	version = "*",
	event = false,
	cmd = { "HopWord" },
	config = require("editor.hop"),
}
editor["brenoprata10/nvim-highlight-colors"] = {
	lazy = true,
	event = false,
	cmd = { "HighlightColors" },
	ft = { "lua", "toml" },
	config = require("editor.highlight-colors"),
}
editor["nvim-pack/nvim-spectre"] = {
	lazy = true,
	cmd = { "Spectre" },
	config = true,
}
editor["lambdalisue/suda.vim"] = {
	lazy = true,
	cmd = { "SudaRead", "SudaWrite" },
	init = false,
	config = require("editor.suda"),
}

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor["nvim-treesitter/nvim-treesitter"] = {
	lazy = true,
	build = function()
		if #vim.api.nvim_list_uis() ~= 0 then
			vim.api.nvim_command([[TSUpdate]])
		end
	end,
	event = { "BufReadPre" },
	config = require("editor.treesitter"),
	dependencies = {
		{ "anuvyklack/pretty-fold.nvim" },
		{ "RRethy/nvim-treesitter-endwise" },
		{
			"andymass/vim-matchup",
			init = function()
				vim.g.matchup_matchparen_offscreen = { method = "popup" }
			end,
		},
		{ "mfussenegger/nvim-treehopper" },
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{
			"windwp/nvim-ts-autotag",
			config = require("editor.autotag"),
		},
		{
			"hiphish/rainbow-delimiters.nvim",
			config = require("editor.rainbow_delims"),
		},
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = require("editor.ts-context-commentstring"),
		},
	},
}

return editor
