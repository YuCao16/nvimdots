local colors = require("modules.utils").get_palette()
local icons = {
	diagnostics = require("modules.utils.icons").get("diagnostics", true),
	git = require("modules.utils.icons").get("git", true),
	git_nosep = require("modules.utils.icons").get("git"),
	misc = require("modules.utils.icons").get("misc", true),
	ui = require("modules.utils.icons").get("ui", true),
}

local mini_sections = {
	lualine_a = { "filetype" },
	lualine_b = {},
	lualine_c = {},
	lualine_x = {},
	lualine_y = {},
	lualine_z = {},
}
local outline = {
	sections = mini_sections,
	filetypes = { "VistaNvim" },
}
local diffview = {
	sections = mini_sections,
	filetypes = { "DiffviewFiles" },
}

local conditionals = {
	has_enough_room = function()
		return vim.o.columns > 100
	end,
	has_comp_before = function()
		return vim.bo.filetype ~= ""
	end,
	has_git = function()
		local gitdir = vim.fs.find(".git", {
			limit = 1,
			upward = true,
			type = "directory",
			path = vim.fn.expand("%:p:h"),
		})
		return #gitdir > 0
	end,
}

---@class lualine_hlgrp
---@field fg string
---@field bg string
---@field gui string?
local utils = {
	force_centering = function()
		return "%="
	end,
	abbreviate_path = function(path)
		local home = require("core.global").home
		if path:find(home, 1, true) == 1 then
			path = "~" .. path:sub(#home + 1)
		end
		return path
	end,
	---Generate <func>`color` for any component
	---@param fg string @Foreground hl group
	---@param gen_bg boolean @Generate guibg from hl group |StatusLine|?
	---@param special_nobg boolean @Disable guibg for transparent backgrounds?
	---@param bg string? @Background hl group
	---@param gui string? @GUI highlight arguments
	---@return fun():lualine_hlgrp
	gen_hl = function(fg, gen_bg, special_nobg, bg, gui)
		return function()
			local guifg = colors[fg]
			local guibg = gen_bg and require("modules.utils").hl_to_rgb("StatusLine", true, colors.mantle) or colors[bg]
			local nobg = special_nobg and require("core.settings").transparent_background
			return {
				fg = guifg and guifg or colors.none,
				bg = (guibg and not nobg) and guibg or nil,
				gui = gui and gui or nil,
			}
		end
	end,
}

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local components = {
	separator = { -- use as section separators
		function()
			return "│"
		end,
		padding = 0,
		color = utils.gen_hl("surface1", true, true),
	},

	file_status = {
		function()
			local function is_new_file()
				local filename = vim.fn.expand("%")
				return filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0
			end

			local symbols = {}
			if vim.bo.modified then
				table.insert(symbols, "[+]")
			end
			if vim.bo.modifiable == false then
				table.insert(symbols, "[-]")
			end
			if vim.bo.readonly == true then
				table.insert(symbols, "[RO]")
			end
			if is_new_file() then
				table.insert(symbols, "[New]")
			end
			return #symbols > 0 and table.concat(symbols, "") or ""
		end,
		padding = { left = -1, right = 1 },
		cond = conditionals.has_comp_before,
	},

	lsp = {
		function()
			local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
			local clients = vim.lsp.get_clients()
			local lsp_lists = {}
			local available_servers = {}
			if next(clients) == nil then
				return icons.misc.NoActiveLsp -- No server available
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				local client_name = client.name
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					-- Avoid adding servers that already exists.
					if not lsp_lists[client_name] then
						lsp_lists[client_name] = true
						table.insert(available_servers, client_name)
					end
				end
			end
			return next(available_servers) == nil and icons.misc.NoActiveLsp
				or string.format("%s[%s]", icons.misc.LspAvailable, table.concat(available_servers, ", "))
		end,
		color = utils.gen_hl("blue", false, true, "nil", "bold"),
		cond = conditionals.has_enough_room,
	},

	python_venv = {
		function()
			local function env_cleanup(venv)
				if string.find(venv, "/") then
					local final_venv = venv
					for w in venv:gmatch("([^/]+)") do
						final_venv = w
					end
					venv = final_venv
				end
				return venv
			end

			if vim.api.nvim_get_option_value("filetype", { scope = "local" }) == "python" then
				local venv = os.getenv("CONDA_DEFAULT_ENV")
				if venv then
					return icons.misc.PyEnv .. env_cleanup(venv)
				end
				venv = os.getenv("VIRTUAL_ENV")
				if venv then
					return icons.misc.PyEnv .. env_cleanup(venv)
				end
			end
			return ""
		end,
		color = utils.gen_hl("green", false, true, "nil", "bold"),
		cond = conditionals.has_enough_room,
	},

	tabwidth = {
		function()
			return icons.ui.Tab .. vim.api.nvim_get_option_value("shiftwidth", { scope = "local" })
		end,
		padding = 1,
	},

	cwd = {
		function()
			return icons.ui.FolderWithHeart .. utils.abbreviate_path(vim.fs.normalize(vim.fn.getcwd()))
		end,
		color = utils.gen_hl("subtext0", true, true, nil, "bold"),
	},

	file_location = {
		function()
			local cursorline = vim.fn.line(".")
			local cursorcol = vim.fn.virtcol(".")
			local filelines = vim.fn.line("$")
			local position
			if cursorline == 1 then
				position = "Top"
			elseif cursorline == filelines then
				position = "Bot"
			else
				position = string.format("%2d%%%%", math.floor(cursorline / filelines * 100))
			end
			return string.format("%s · %3d:%-2d", position, cursorline, cursorcol)
		end,
	},
}

local function getWords()
	if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
		if vim.fn.wordcount().visual_words == 1 then
			return tostring(vim.fn.wordcount().visual_words) .. " word"
		elseif not (vim.fn.wordcount().visual_words == nil) then
			return tostring(vim.fn.wordcount().visual_words) .. " words"
		else
			return tostring(vim.fn.wordcount().words) .. " words"
		end
	else
		return vim.opt.fileencoding:get()
	end
end

function Split(s, delimiter)
	local result = {}
	for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

local function showLsp()
	local msg = " LSP: No Active Lsp"
	local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
	local clients = vim.lsp.get_clients()
	if next(clients) == nil then
		return msg
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return " LSP: " .. client.name
		end
	end
	return msg
end

return function()
	return {
		options = {
			component_separators = "",
			section_separators = { left = "", right = "" },
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "" }, right_padding = 2 },
			},
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{ utils.force_centering },
				components.lsp,
			},
			lualine_x = {
				getWords,
				components.tabwidth,
				components.file_status,
			},
			lualine_y = {
				components.python_venv,
				"filetype",
				"filesize",
				"progress",
			},
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = { "filename" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "location" },
		},
		tabline = {},
		extensions = { "toggleterm", "nvim-tree", "neo-tree", "nvim-dap-ui", "fugitive", outline, diffview },
	}
end
