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
editor["LunarVim/bigfile.nvim"] = {
	lazy = false,
	config = require("editor.bigfile"),
	cond = require("core.settings").load_big_files_faster,
}
editor["famiu/bufdelete.nvim"] = {
	lazy = true,
	event = { "BufReadPost" },
}
editor["numToStr/Comment.nvim"] = {
	lazy = true,
	event = { "CursorHold" },
	config = require("editor.comment"),
}
editor["folke/todo-comments.nvim"] = {
	lazy = true,
	cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
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
	cmd = { "EasyAlign" },
}
editor["smoka7/hop.nvim"] = {
	lazy = true,
	version = "*",
	cmd = { "HopWord" },
	config = require("editor.hop"),
}
-- NOTE: `flash.nvim` is a powerful plugin that can be used as partial or complete replacements for:
--  > `hop.nvim`,
--  > `wilder.nvim`
--  > `nvim-treehopper`
-- Considering its steep learning curve as well as backward compatibility issues...
--  > We have no plan to remove the above plugins for the time being.
-- But as usual, you can always tweak the plugin to your liking.
editor["folke/flash.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.flash"),
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
	event = { "BufReadPost" },
	config = require("editor.treesitter"),
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "RRethy/nvim-treesitter-endwise" },
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
			"hiphish/rainbow-delimiters.nvim",
			config = require("editor.rainbow_delims"),
		},
	},
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
