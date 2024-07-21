local definitions = {
	-- SaveSession
	wins = {
		{
			"VimLeave",
			"*",
			[[lua require('persisted').save({override = true, leave_vim = true })]],
		},
	},
	ft = {
		{ "FileType", "dashboard", "set showtabline=0" },
	},
}

-- LastPlace
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = lastplace,
	pattern = { "*" },
	desc = "remember last cursor place",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

_G.orig_win_id = nil
vim.api.nvim_create_user_command("DiffOrigOpen", function()
	_G.orig_win_id = vim.api.nvim_get_current_win()
	local scratch_buffer = vim.api.nvim_create_buf(false, true)
	local current_ft = vim.bo.filetype
	vim.cmd("vertical sbuffer" .. scratch_buffer)
	vim.bo[scratch_buffer].filetype = current_ft
	vim.cmd("read ++edit #") -- load contents of previous buffer into scratch_buffer
	vim.cmd.normal('1G"_d_') -- delete extra newline at top of scratch_buffer without overriding register
	vim.cmd.diffthis() -- scratch_buffer
	vim.cmd.wincmd("p")
	vim.cmd.diffthis() -- current buffer
end, {})

-- vim.api.nvim_create_augroup("IndentBlankLineFix", {})
-- vim.api.nvim_create_autocmd("WinScrolled", {
-- 	group = "IndentBlankLineFix",
-- 	callback = function()
-- 		if vim.v.event.all.leftcol ~= 0 then
-- 			vim.cmd("silent! IndentBlanklineRefresh")
-- 		end
-- 	end,
-- })

-- auto close some filetype with <ESC>
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("SoftESCQuit", { clear = true }),
	pattern = {
		"sagacodeaction",
		"nil",
		"nofile",
		"notify",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.api.nvim_buf_set_keymap(event.buf, "n", "<ESC>", "<CMD>close<CR>", { silent = true })
	end,
})

-- auto close some filetype with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"fugitive",
		"lspsagaoutline",
		"spectre_panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<Cmd>close<CR>", { silent = true })
	end,
})

-- Load internal plugins
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		require("user.internal")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("HardQuit", { clear = true }),
	pattern = {
		"dashboard",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<CMD>q<CR>", { silent = true })
	end,
})

vim.api.nvim_create_user_command("DiffOrigClose", function()
	vim.cmd("windo diffoff")
	local windows = vim.api.nvim_list_wins()
	for _, win in ipairs(windows) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "nofile" then
			vim.api.nvim_win_close(win, false)
		end
	end
	if _G.orig_win_id and vim.api.nvim_win_is_valid(_G.orig_win_id) then
		vim.api.nvim_set_current_win(_G.orig_win_id)
	end
end, {})

vim.api.nvim_create_user_command("Diffthis", function()
	_G.orig_win_id = vim.api.nvim_get_current_win()
	local current_buffer = vim.api.nvim_get_current_buf()
	local current_ft = vim.bo.filetype
	local scratch_buffer = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_set_option_value("filetype", current_ft, { buf = scratch_buffer })
	vim.api.nvim_win_set_buf(_G.orig_win_id, scratch_buffer)
	vim.cmd("read ++edit #")
	vim.cmd('normal! gg0"_dd')
	vim.cmd("diffthis")
	vim.api.nvim_set_current_buf(current_buffer)
	vim.cmd("diffthis")
end, {})

vim.api.nvim_create_user_command("Diffoff", function()
	vim.cmd("diffoff!")
	if _G.orig_win_id and vim.api.nvim_win_is_valid(_G.orig_win_id) then
		vim.api.nvim_set_current_win(_G.orig_win_id)
	end
	local buffers = vim.api.nvim_list_bufs()
	for _, buf in ipairs(buffers) do
		if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "nofile" then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, {})

require("user.commands")

return definitions
