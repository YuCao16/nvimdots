return {
	on_open = function(term)
		-- Prevent infinite calls from freezing neovim.
		-- Only set these options specific to this terminal buffer.
		vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
		vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
	end,
	float_opts = {
		border = "rounded",
		width = function()
			return math.floor(vim.o.columns * 0.75)
		end,

		height = function()
			return math.floor((vim.o.lines - vim.o.cmdheight) * 0.75)
		end,
	},
}
