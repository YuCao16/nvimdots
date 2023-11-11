return function()
	require("modules.utils").load_plugin("diffview", {
		view = {
			merge_tool = {
				disable_diagnostics = true,
			},
		},
	})
end
