return function()
	require("modules.utils").load_plugin("vim-illuminate", {
		providers = {
			"lsp",
			"treesitter",
			"regex",
		},
		delay = 100,
		filetypes_denylist = {
			"DoomInfo",
			"DressingSelect",
			"NvimTree",
			"neo-tree",
			"Outline",
			"TelescopePrompt",
			"Trouble",
			"dashboard",
			"dirvish",
			"fugitive",
			"help",
			"lsgsagaoutline",
			"neogitstatus",
			"norg",
			"toggleterm",
		},
		under_cursor = true,
	}, false, require("illuminate").configure)
end
