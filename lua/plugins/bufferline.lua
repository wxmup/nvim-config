return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
	dependencies = "nvim-tree/nvim-web-devicons",

	opts = function()
		local bufferline = require("bufferline")

		return {
			-- 使用catppuccin的高亮
			highlights = require("catppuccin.special.bufferline").get_theme({
				styles = { "bold" },
				-- custom = {
				-- 	all = {
				-- 		fill = { bg = "#000000" },
				-- 	},
				-- 	mocha = {
				-- 		background = { fg = mocha.text },
				-- 	},
				-- 	latte = {
				-- 		background = { fg = "#000000" },
				-- 	},
				-- },
			}),

			options = {
				buffer_close_icon = "×",
				-- close_icon = " ",
				-- 禁用当前标签页的标题斜体
				style_preset = {
					bufferline.style_preset.no_italic,
					-- bufferline.style_preset.minimal,
				},
				always_show_bufferline = true, -- 不开这个，按tab隐藏lualine
				-- 视觉上不挤占文件树的空间
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "left",
						-- separator = true, -- 给右侧加一条分割线
					},
				},
			},
		}
	end,

	keys = {

		{ "<A-c>", "<Cmd>bdelete<CR>", desc = "delete now buffer" },
		{ "<A-a>", "<Cmd>BufferLinePickClose<CR>", desc = "delete any buffer" },
		{ "<A-o>", "<Cmd>BufferLineCloseOthers<CR>", desc = "delete other buffer" },
		{ "<A-r>", "<Cmd>BufferLineCloseRight<CR>", desc = "deleete buffer of right" },
		{ "<A-l>", "<Cmd>BufferLineCloseLeft<CR>", desc = "delete buffer of left" },
		{ "<tab>", "<cmd>BufferLineCycleNext<cr>", desc = "goto next buffer" },
		{ "<A-1>", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "goto no.1 buffer" },
		{ "<A-2>", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "goto no.2 buffer" },
		{ "<A-3>", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "goto no.3 buffer" },
		{ "<A-4>", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "goto no.4 buffer" },
	},
}
