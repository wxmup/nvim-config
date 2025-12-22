-- 高亮注释里的关键词
return {
	"folke/todo-comments.nvim",

	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		-- signs = false,
	},
}
