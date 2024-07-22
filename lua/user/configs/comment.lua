local settings = require("core.settings")

return {
	pre_hook = (settings.mode == "server" and nil)
		or require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
}
