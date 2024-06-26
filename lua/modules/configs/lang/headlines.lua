return function()
	require("modules.utils").load_plugin("headlines", {
		markdown = {
			headline_highlights = { "Headline1", "Headline2" },
			codeblock_highlight = "CodeBlock",
			dash_highlight = "Dash",
			dash_string = "-",
			quote_highlight = "Quote",
			quote_string = "┃",
			fat_headlines = true,
			fat_headline_upper_string = "▃",
			fat_headline_lower_string = "▀",
		},
		rmd = {
			treesitter_language = "markdown",
			headline_highlights = { "Headline1", "Headline2" },
			codeblock_highlight = "CodeBlock",
			dash_highlight = "Dash",
			dash_string = "-",
			quote_highlight = "Quote",
			quote_string = "┃",
			fat_headlines = true,
			fat_headline_upper_string = "▃",
			fat_headline_lower_string = "▀",
		},
		norg = {
			headline_highlights = { "Headline1", "Headline2" },
			codeblock_highlight = "CodeBlock",
			dash_highlight = "Dash",
			dash_string = "-",
			doubledash_highlight = "DoubleDash",
			doubledash_string = "=",
			quote_highlight = "Quote",
			quote_string = "┃",
			fat_headlines = true,
			fat_headline_upper_string = "▃",
			fat_headline_lower_string = "▀",
		},
		org = {
			headline_highlights = { "Headline1", "Headline2" },
			codeblock_highlight = "CodeBlock",
			dash_highlight = "Dash",
			dash_string = "-",
			quote_highlight = "Quote",
			quote_string = "┃",
			fat_headlines = true,
			fat_headline_upper_string = "▃",
			fat_headline_lower_string = "▀",
		},
	})
end
