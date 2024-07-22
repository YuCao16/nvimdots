return function()
	local null_ls = require("null-ls")

	local btns = null_ls.builtins

	---Return formatter args required by `extra_args`
	---@param formatter_name string
	---@return table|nil
	local function formatter_args(formatter_name)
		local ok, args = pcall(require, "user.configs.formatters." .. formatter_name)
		if not ok then
			args = require("completion.formatters." .. formatter_name)
		end
		return args
	end

	local is_executable = function(cmd_name, cond)
		local u = require("null-ls.utils")
		return function()
			local ie = u.is_executable(cmd_name)
			if cond == false then
				ie = not ie
			end
			return ie
		end
	end

	-- Please set additional flags for the supported servers here
	-- Don't specify any config here if you are using the default one.
	local sources = {
		btns.formatting.clang_format.with({
			filetypes = { "c", "cpp", "objc", "objcpp", "cs", "java", "cuda", "proto" },
			extra_args = formatter_args("clang_format"),
		}),
		btns.formatting.prettier.with({
			filetypes = {
				"vue",
				"typescript",
				"javascript",
				"typescriptreact",
				"javascriptreact",
				"yaml",
				"html",
				"css",
				"scss",
				"sh",
				-- "markdown",
			},
			condition = is_executable("prettier"),
		}),
		btns.diagnostics.markdownlint.with({
			extra_args = { "--disable=line_length" },
			condition = is_executable("markdownlint"),
		}),
		btns.diagnostics.alex.with({
			condition = is_executable("alex"),
		}),
		btns.formatting.mdformat.with({
			condition = is_executable("mdformat"),
		}),
	}
	return {
		border = "rounded",
		debug = false,
		log_level = "warn",
		update_in_insert = false,
		sources = sources,
		default_timeout = require("core.settings").format_timeout,
	}
end
