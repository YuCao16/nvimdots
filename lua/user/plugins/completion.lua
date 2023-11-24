local completion = {}

completion["yucao16/lspsaga.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.lspsaga"),
	dependencies = { "nvim-tree/nvim-web-devicons" },
	branch = "finder",
}
completion["kdheepak/cmp-latex-symbols"] = {
	lazy = true,
	ft = { "tex", "latex", "markdown" },
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
}
return completion
