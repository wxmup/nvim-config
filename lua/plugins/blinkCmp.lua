return {
	"saghen/blink.cmp",

	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets" },

	-- 懒加载设置
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },

	-- use a release tag to download pre-built binaries
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "super-tab" }, -- 使用vs code键位进行补全
		-- 光标处显示参数信息
		signature = {
			enabled = false,
			-- 调整窗口 圆角 边框背景
			window = { border = "rounded" },
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			nerd_font_variant = "mono",
		},

		completion = {
			menu = {
				-- 让弹出窗口变成圆角边框
				border = "rounded",
				-- 让补全窗口跟随全局浮窗阴影（已禁用遮罩），避免异常的遮罩出现
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",

				-- 美化补全布局
				draw = {
					align_to = "cursor", -- 让补全窗口对齐光标
					gap = 2, -- 补全菜单各个元素之间的间距，默认是1

					-- 在ui上对齐每个标签icon
					columns = { { "kind_icon" }, { "label" }, { "kind" }, { "label_description" } },

					-- 使用treesitter高亮标签
					treesitter = { "lsp" },
				},
			},

			documentation = {
				-- 调整窗口 圆角边框 边框背景
				window = {
					border = "rounded",
				},
				-- 在补全时显示文档,此文档显示函数形参和返回类型等
				auto_show = false,
				auto_show_delay_ms = 200,
			},

			accept = {
				-- 开启函数自动添加括号
				auto_brackets = { enabled = true },
			},
		},

		-- neovim输入终端命令时自动弹出补全
		cmdline = {
			keymap = { preset = "super-tab" }, -- 命令行使用vs code命令
			completion = {
				menu = {
					auto_show = true,
				},
			},
		},

		sources = {
			-- 在注释行时不显示菜单补全。并且在全局不会弹出中文补全
			default = function()
				local row, col = unpack(vim.api.nvim_win_get_cursor(0))
				local ok, node = pcall(vim.treesitter.get_node, {
					bufnr = 0,
					pos = { row - 1, math.max(0, col - 1) },
				})
				if ok and node and node.type and node:type():find("comment") then
					return {}
				end
				return { "lsp", "path", "snippets" }
			end,
		},

		-- 使用性能最好的 rust 补全
		fuzzy = { implementation = "rust" },
	},
}
