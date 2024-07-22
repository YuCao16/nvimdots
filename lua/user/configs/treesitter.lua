return function()
	local function table_contains(tbl, x)
		local found = false
		for _, v in pairs(tbl) do
			if v == x then
				found = true
			end
		end
		return found
	end
	local function disable_treesitter(disable_types, size_limit)
		return function(_, bufnr)
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
			if table_contains(disable_types, filetype) then
				return true
			end
			local buf_name = vim.api.nvim_buf_get_name(bufnr)
			local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
			return file_size > size_limit
		end
	end

	return {
		ensure_installed = require("core.settings").treesitter_deps,
		highlight = {
			enable = true,
			disable = disable_treesitter({ "org", "tex", "latex" }, 50 * 1024),
			additional_vim_regex_highlighting = false,
		},
		textobjects = {
			select = {
				enable = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]["] = "@function.outer",
					["]m"] = "@class.outer",
				},
				goto_next_end = {
					["]]"] = "@function.outer",
					["]M"] = "@class.outer",
				},
				goto_previous_start = {
					["[["] = "@function.outer",
					["[m"] = "@class.outer",
				},
				goto_previous_end = {
					["[]"] = "@function.outer",
					["[M"] = "@class.outer",
				},
			},
		},
		endwise = {
			enable = true,
			disable = disable_treesitter({}, 256 * 1024),
		},
		playground = {
			enable = true,
			disable = disable_treesitter({}, 256 * 1024),
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
		indent = {
			enable = true,
			disable = disable_treesitter({}, 256 * 1024),
		},
		rainbow = {
			enable = false,
			disable = disable_treesitter({}, 256 * 1024),
			extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
			max_file_lines = 2000, -- Do not enable for files with more than 2000 lines, int
		},
		matchup = {
			enable = true,
			disable = disable_treesitter({}, 256 * 1024),
			disable_virtual_text = true,
			include_match_words = true,
		},
	}
end
