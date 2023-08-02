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
	event = { "BufReadPost" },
	config = function()
		require("cutlass").setup({ cut_key = "c" })
	end,
}
editor["windwp/nvim-autopairs"] = {
	lazy = true,
	event = { "InsertEnter" },
	config = require("editor.autopairs"),
}
editor["LunarVim/bigfile.nvim"] = {
	lazy = false,
	config = require("editor.bigfile"),
	cond = require("core.settings").load_big_files_faster,
}
editor["famiu/bufdelete.nvim"] = {
	lazy = true,
	event = "BufReadPre",
}
editor["numToStr/Comment.nvim"] = {
	lazy = true,
	event = { "VeryLazy" },
	config = require("editor.comment"),
}
editor["folke/todo-comments.nvim"] = {
	lazy = true,
	event = { "VeryLazy" },
	config = true,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
}
editor["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
}
editor["junegunn/vim-easy-align"] = {
	lazy = true,
	cmd = "EasyAlign",
}
editor["smoka7/hop.nvim"] = {
	lazy = true,
	version = "*",
	event = { "VeryLazy" },
	config = require("editor.hop"),
}
editor["folke/flash.nvim"] = {
	lazy = true,
	event = { "VeryLazy" },
	config = true,
}
editor["RRethy/vim-illuminate"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.vim-illuminate"),
}
editor["lambdalisue/suda.vim"] = {
	lazy = true,
	cmd = { "SudaRead", "SudaWrite" },
	config = require("editor.suda"),
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
	event = { "BufAdd", "InsertEnter" },
}
editor["kylechui/nvim-surround"] = {
	lazy = true,
	event = { "BufAdd", "InsertEnter" },
	config = true,
}
editor["roobert/search-replace.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("editor.search-replace"),
}
editor["nmac427/guess-indent.nvim"] = {
	event = { "BufReadPost" },
	config = require("editor.guess_indent"),
}

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor["nvim-treesitter/nvim-treesitter"] = {
	lazy = true,
	build = function()
		if #vim.api.nvim_list_uis() ~= 0 then
			vim.api.nvim_command("TSUpdate")
		end
	end,
	event = "BufReadPost",
	config = require("editor.treesitter"),
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "RRethy/nvim-treesitter-endwise" },
		{ "nvim-treesitter/playground" },
		{ "windwp/nvim-ts-autotag" },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "mfussenegger/nvim-treehopper" },
		{ "andymass/vim-matchup" },
		{ "anuvyklack/pretty-fold.nvim" },
		{
			"ziontee113/syntax-tree-surfer",
			config = require("editor.tree-surfer"),
		},
		{
			"Wansmer/treesj",
			config = require("editor.treesj"),
		},
		{
			"hiphish/rainbow-delimiters.nvim",
			config = require("editor.rainbow_delims"),
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			config = require("editor.ts-context"),
		},
		{
			"uga-rosa/ccc.nvim",
			config = require("editor.ccc_config"),
		},
	},
}

return editor
