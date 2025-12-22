return {
	"rachartier/tiny-glimmer.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
	priority = 10, -- Low priority to catch other plugins' keybindings
	config = function()
		require("tiny-glimmer").setup()
	end,
}
