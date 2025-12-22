vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- 设置折叠时的ui
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"

return {
	"kevinhwang91/nvim-ufo",
	-- 懒加载设置
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
	dependencies = { "kevinhwang91/promise-async" },
	opts = {
		open_fold_hl_timeout = 0,

		provider_selector = function(bufnr, filetype, buftype)
			-- 可选：对这些 buffer 不启用（避免在侧边栏/特殊窗口浪费性能）
			if buftype == "nofile" or buftype == "prompt" then
				return ""
			end
			if filetype == "neo-tree" or filetype == "help" or filetype == "dashboard" then
				return ""
			end
			return { "treesitter", "indent" }
		end,
	},
}
