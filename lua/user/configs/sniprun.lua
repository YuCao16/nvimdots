return {
	display = function()
		return {
			-- "TempFloatingWindowOk", -- display ok results in the floating window
			-- "NvimNotifyErr", -- display err results with the nvim-notify plugin
			-- "Classic", -- display results in the command line"
			-- "VirtualText", -- display results in virtual text"
			-- "LongTempFloatingWindow", -- display results in the long floating window
			"Terminal", -- display results in a vertical split
			-- "TerminalWithCode" -- display results and code history in a vertical split
		}
	end,
	borders = "rounded", -- " display borders around floating windows
}
