local tool = {}

tool["nvim-neo-tree/neo-tree.nvim"] = {
	lazy = true,
	cmd = { "Neotree" },
	branch = "v3.x",
	init = function()
		vim.api.nvim_create_autocmd("BufEnter", {
			desc = "Load NeoTree if entering a directory",
			callback = function(args)
				if vim.fn.isdirectory(vim.api.nvim_buf_get_name(args.buf)) > 0 then
					require("lazy").load({ plugins = { "neo-tree.nvim" } })
					vim.api.nvim_del_autocmd(args.id)
				end
			end,
		})
	end,
	config = require("tool.neotree"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		{
			"s1n7ax/nvim-window-picker",
			version = "2.*",
			config = require("tool.window_picker"),
		},
	},
}
tool["yetone/avante.nvim"] = {
	lazy = true,
	cmd = { "AvanteAsk" },
	version = false, -- set this if you want to always pull the latest change
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	config = require("tool.avante"),
	keys = {
		{
			"<leader>aa",
			function()
				require("avante.api").ask()
			end,
			desc = "avante: ask",
			mode = { "n", "v" },
		},
		{
			"<leader>ar",
			function()
				require("avante.api").refresh()
			end,
			desc = "avante: refresh",
		},
		{
			"<leader>ae",
			function()
				require("avante.api").edit()
			end,
			desc = "avante: edit",
			mode = "v",
		},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below is optional, make sure to setup it properly if you have lazy=true
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
	},
}
tool["stevearc/oil.nvim"] = {
	lazy = true,
	cmd = { "Oil" },
	config = require("tool.oil"),
}
tool["samjwill/nvim-unception"] = {
	lazy = true,
	event = { "TermOpen" },
	config = require("tool.unception"),
}
tool["NeogitOrg/neogit"] = {
	lazy = true,
	cmd = { "Neogit" },
	config = require("tool.neogit_config"),
}
tool["neomake/neomake"] = {
	lazy = true,
	cmd = { "Neomake" },
}
tool["JellyApple102/flote.nvim"] = {
	lazy = true,
	cmd = { "Flote" },
	config = require("tool.flote"),
}
tool["danymat/neogen"] = {
	lazy = true,
	cmd = { "Neogen" },
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter" },
	},
	config = true,
}
tool["folke/edgy.nvim"] = {
	lazy = true,
	event = { "VeryLazy" },
	config = require("tool.edgy"),
}
tool["yucao16/vista.nvim"] = {
	lazy = true,
	cmd = { "VistaNvimOpen", "VistaNvimToggle", "VistaNvimToggle" },
	branch = "vista.nvim-dev",
	config = require("tool.vista"),
}
tool["sidebar-nvim/sidebar.nvim"] = {
	lazy = true,
	cmd = { "SidebarNvimOpen", "SidebarNvimFocus", "SidebarNvimToggle" },
	config = require("tool.sidebar"),
}
tool["yucao16/registers.nvim"] = {
	lazy = true,
	event = { "VeryLazy" },
	config = function()
		vim.g["registers_delay"] = 200
		vim.g["registers_window_border"] = "rounded"
		vim.g["system_clip"] = 1
		vim.g["peekup_open"] = '"'
	end,
}
tool["m4xshen/hardtime.nvim"] = {
	lazy = true,
	cmd = { "Hardtime" },
	config = function()
		require("hardtime").setup({
			notification = false,
			hint = true,
			disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
		})
	end,
}
tool["CRAG666/code_runner.nvim"] = {
	lazy = true,
	config = require("tool.code_runner"),
	cmd = { "RunCode" },
}

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool["nvim-telescope/telescope.nvim"] = {
	lazy = true,
	cmd = "Telescope",
	config = require("tool.telescope"),
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{ "LinArcX/telescope-env.nvim" },
		{ "jvgrootveld/telescope-zoxide" },
		{ "nvim-telescope/telescope-frecency.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "smartpde/telescope-recent-files" },
		{ "crispgm/telescope-heading.nvim" },
		{
			"FabianWirth/search.nvim",
			config = require("tool.search"),
		},
		{
			"AckslD/nvim-neoclip.lua",
			event = { "CmdlineEnter", "TextYankPost" },
			config = require("tool.neoclip"),
			dependencies = {
				{ "kkharji/sqlite.lua" },
			},
		},
		{
			"aaronhallaert/advanced-git-search.nvim",
			cmd = { "AdvancedGitSearch" },
			dependencies = {
				"tpope/vim-rhubarb",
				"tpope/vim-fugitive",
				"sindrets/diffview.nvim",
			},
		},
	},
}

return tool
