-- 光标始终保持居中效果，并且滚动到最后一行仍然能生效
return {
	"Aasim-A/scrollEOF.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
	opts = {},
}
