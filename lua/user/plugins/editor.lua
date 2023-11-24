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
editor["folke/todo-comments.nvim"] = {
	lazy = true,
	cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
	config = true,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
}
editor["SmiteshP/nvim-navic"] = {
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
	cmd = "TSPlaygroundToggle",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}

return editor
