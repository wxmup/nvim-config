return {
	"saghen/blink.indent",
	--- @module 'blink.indent'
	--- @type blink.indent.Config

	-- 懒加载设置
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },

	opts = {
		scope = {
			char = "│",
		},
		static = {
			char = "│",
		},
	},
}
