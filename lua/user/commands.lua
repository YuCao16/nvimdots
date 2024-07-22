local _runcode = nil
_G._toggle_runcode = function()
	if vim.fn.executable("python") == 1 then
		if not _lazygit then
			_runcode = require("toggleterm.terminal").Terminal:new({
				cmd = "python " .. vim.fn.expand("%:p"),
				direction = "horizontal",
				close_on_exit = false,
				hidden = false,
			})
		end
		if _runcode ~= nil then
			_runcode:toggle()
		end
	else
		vim.notify("Command [python] not found!", vim.log.levels.ERROR, { title = "toggleterm.nvim" })
	end
end

local bufnames = {}
_G.command_to_buffer = function(command, bufname)
	bufname = bufname or "Record"
	-- Check if a buffer with this name already exists
	local original_bufname = bufname
	local i = (bufnames[bufname] or 1)
	while bufnames[bufname] do
		-- If a buffer with this name exists, append a suffix to the name
		bufname = original_bufname .. "_" .. i
		i = i + 1
	end
	bufnames[bufname] = 1

	-- Create a new scratch buffer
	local buf = vim.api.nvim_create_buf(true, true)

	-- Execute the command and capture its output
	local ok, result = pcall(function()
		return vim.api.nvim_exec2(command, { output = true })
	end, true)
	if not ok then
		print("Error executing command: " .. result)
		return
	end

	-- Split the output by newline and put it in the buffer
	local output = vim.split(result.output, "\n")
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
	vim.api.nvim_buf_set_name(buf, bufname)

	-- Switch to the new buffer in the current window
	vim.api.nvim_set_current_buf(buf)
end

vim.api.nvim_command("command! -nargs=* Record lua _G.command_to_buffer(<f-args>)")

vim.api.nvim_create_user_command("Path", 'lua print(vim.fn.expand("%:p"))<cr>', {})
