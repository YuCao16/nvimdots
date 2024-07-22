local bind = require("keymap.bind")
local map_cr = bind.map_cr

local mapping = {
	["n|<leader>b"] = map_cr("BufferLineCycleNext"):with_noremap():with_desc("buffer: Cycle next"),
	["n|<leader>B"] = map_cr("BufferLineCyclePrev"):with_noremap():with_desc("buffer: Cycle prev"),
	["n|<leader>gb"] = map_cr("BufferLinePick"):with_noremap():with_desc("buffer: Line pick"),
	["n|<leader>be"] = "",
	["n|<leader>bd"] = "",
	-- Plugin: ZenMode
	["n|<leader>z"] = map_cr("ZenMode"):with_noremap():with_silent():with_desc("Toggle ZenMode"),
	-- Plugin: hi-my-words
	["n|<leader>hw"] = map_cr("HiMyWordsToggle"):with_noremap():with_silent():with_desc("Toggle hi-my-words"),
	["n|<leader>hW"] = map_cr("HiMyWordsClear"):with_noremap():with_silent():with_desc("Toggle hi-my-words"),
}

function mapping.gitsigns(buf)
	local actions = require("gitsigns.actions")
	local map = {
		["n|]g"] = bind.map_callback(function()
			if vim.wo.diff then
				return "]g"
			end
			vim.schedule(function()
				actions.next_hunk()
			end)
			return "<Ignore>"
		end)
			:with_buffer(buf)
			:with_expr()
			:with_desc("git: Goto next hunk"),
		["n|[g"] = bind.map_callback(function()
			if vim.wo.diff then
				return "[g"
			end
			vim.schedule(function()
				actions.prev_hunk()
			end)
			return "<Ignore>"
		end)
			:with_buffer(buf)
			:with_expr()
			:with_desc("git: Goto prev hunk"),
		["n|<leader>hs"] = bind.map_callback(function()
			actions.stage_hunk()
		end)
			:with_buffer(buf)
			:with_desc("git: Stage hunk"),
		["v|<leader>hs"] = bind.map_callback(function()
			actions.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
			:with_buffer(buf)
			:with_desc("git: Stage hunk"),
		["n|<leader>hu"] = bind.map_callback(function()
			actions.undo_stage_hunk()
		end)
			:with_buffer(buf)
			:with_desc("git: Undo stage hunk"),
		["n|<leader>hr"] = bind.map_callback(function()
			actions.reset_hunk()
		end)
			:with_buffer(buf)
			:with_desc("git: Reset hunk"),
		["v|<leader>hr"] = bind.map_callback(function()
			actions.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
			:with_buffer(buf)
			:with_desc("git: Reset hunk"),
		["n|<leader>hR"] = bind.map_callback(function()
			actions.reset_buffer()
		end)
			:with_buffer(buf)
			:with_desc("git: Reset buffer"),
		["n|<leader>hp"] = bind.map_callback(function()
			actions.preview_hunk()
		end)
			:with_buffer(buf)
			:with_desc("git: Preview hunk"),
		["n|<leader>hb"] = bind.map_callback(function()
			actions.blame_line({ full = true })
		end)
			:with_buffer(buf)
			:with_desc("git: Blame line"),
		-- Text objects
		["ox|ih"] = bind.map_callback(function()
			actions.text_object()
		end):with_buffer(buf),
	}
	bind.nvim_load_mapping(map)
end

return mapping
