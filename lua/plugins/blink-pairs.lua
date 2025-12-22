return {
	"saghen/blink.pairs",

	version = "*", -- (recommended) only required with prebuilt binaries

	event = { "InsertEnter", "BufReadPost", "BufNewFile", "BufWritePost" },

	-- download prebuilt binaries from github releases
	dependencies = "saghen/blink.download",

	--- @module 'blink.pairs'
	--- @type blink.pairs.Config
	opts = {
		-- 以下高亮均使用catppuccin设定的高亮
		highlights = {
			-- 设置彩虹括号的高亮组颜色
			groups = {
				"BlinkPairsRed",
				"BlinkPairsYellow",
				"BlinkPairsBlue",
				"BlinkPairsOrange",
				"BlinkPairsGreen",
				"BlinkPairsPurple",
				"BlinkPairsCyan",
			},

			-- 非成对的括号的高亮
			unmatched_group = "BlinkPairsUnmatched",

			matchparen = {
				-- 光标在当前括号对内部，则突出当前括号对
				include_surrounding = true,
				-- 突出当前括号对的高亮
				group = "BlinkPairsMatchParen",
			},
		},
	},
}
