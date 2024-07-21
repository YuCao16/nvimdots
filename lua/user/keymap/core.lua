local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

return {
	["n|<leader>9"] = map_cr([[execute 'source '.bufname('%')]])
		:with_noremap()
		:with_silent()
		:with_desc("source current buffer"),
	["n|<leader>w"] = map_cmd("<C-w>"):with_noremap():with_silent():with_desc("toggle wincmd"),
	["n|<leader>f"] = map_cr("Format"):with_noremap():with_silent():with_desc("toggle Format"),
	["n|<c-j>"] = map_cr("resize -1"):with_silent():with_desc("window: Resize -2 horizontally"),
	["n|<c-k>"] = map_cr("resize +1"):with_silent():with_desc("window: Resize +2 horizontally"),
	["n|<A-h>"] = "",
	["n|<A-l>"] = "",
	["n|<A-j>"] = "",
	["n|<A-k>"] = "",
	["n|<S-H>"] = map_cr("vertical resize -1"):with_silent():with_desc("window: Resize -5 vertically"),
	["n|<S-L>"] = map_cr("vertical resize +1"):with_silent():with_desc("window: Resize +5 vertically"),
	["n|<leader>bn"] = "",
}
