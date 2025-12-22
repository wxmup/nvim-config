return {
	"nvim-lualine/lualine.nvim",

	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
	dependencies = { "nvim-tree/nvim-web-devicons" },

	opts = {
		options = {
			theme = "catppuccin",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		-- tabline = {
		-- 	lualine_z = { "buffers" },
		-- },
	},
}
