return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- 禁止noice接管lsp悬浮文档
		lsp = {
			-- 这两项会产生文档说明“大窗”
			hover = { enabled = false },
			signature = { enabled = false },
			-- 不要覆盖 LSP/cmp 的 markdown 渲染（否则又会走 Noice 的大窗）
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = false,
				["vim.lsp.util.stylize_markdown"] = false,
				["cmp.entry.get_documentation"] = false,
			},
		},

		-- -- 禁用浮窗遮罩
		-- cmdline_popup = {
		-- 	border = { style = "none", padding = { 0, 0 } }, -- 去边框+内边距
		-- 	win_options = {
		-- 		winblend = 0, -- 关闭浮窗伪透明
		-- 		winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
		-- 	},
		-- },
		-- -- popupmenu（补全菜单）
		-- popupmenu = {
		-- 	border = { style = "none", padding = { 0, 0 } },
		-- 	win_options = { winblend = 0 },
		-- },
	},

	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		-- "rcarriga/nvim-notify",
	},

	keys = {
		{ "<leader>hm", "<cmd>Noice<cr>" },
		desc = "[Noice] show history messages",
	},
}
