local settings = require("core.settings")
local pre_hook = nil
if settings["mode"] == "full" then
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
end
return {
	pre_hook = pre_hook,
}
