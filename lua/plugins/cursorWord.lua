-- cursorWord的高亮
return {
	"sontungexpt/stcursorword",
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
	opts = {
		min_word_length = 1,
	},
}
