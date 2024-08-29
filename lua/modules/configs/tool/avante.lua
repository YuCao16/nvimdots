return function()
	require("avante").setup({
		provider = "claude",
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-3-5-sonnet-20240620",
			temperature = 0,
			max_tokens = 4096,
		},
		mappings = {
			--- @class AvanteConflictMappings
			diff = {
				ours = "<leader>co",
				theirs = "<leader>ct",
				both = "<leader>cb",
				cursor = "<leader>cc",
				next = "]x",
				prev = "[x",
			},
			jump = {
				next = "]]",
				prev = "[[",
			},
			submit = {
				normal = "<CR>",
				insert = "<C-s>",
			},
		},
	})
end
