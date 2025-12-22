return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	opts = {
		-- 自动检测已安装的插件并启用相应的集成。
		auto_integrations = true,

		-- 定义几组高亮，以基于blink.cmp的cursorline指定颜色
		highlight_overrides = {
			latte = function(cp)
				return {
					-- 改blink.cmp的补全选择条颜色：一种很蓝的蓝色
					BlinkCmpMenuSelection = { fg = cp.base, bg = cp.blue },

					-- 修改blink.pairs在mocha主题下的彩虹括号高亮
					BlinkPairsRed = { fg = cp.maroon },
					BlinkPairsYellow = { fg = cp.peach },
					BlinkPairsBlue = { fg = cp.blue },
					BlinkPairsOrange = { fg = cp.red },
					BlinkPairsGreen = { fg = cp.green },
					BlinkPairsPurple = { fg = cp.mauve },
					BlinkPairsCyan = { fg = cp.teal },

					-- 未匹配括号和突出所在括号对时的高亮
					BlinkPairsUnmatched = { fg = cp.red, underline = true },
					BlinkPairsMatchParen = { bold = true, nocombine = true },
				}
			end,

			mocha = function(cp)
				return {
					-- 改blink.cmp的补全选择条颜色：一种有点黄的绿色
					BlinkCmpMenuSelection = { fg = cp.base, bg = cp.green },

					-- 修改blink.pairs在mocha主题下的彩虹括号高亮
					BlinkPairsRed = { fg = cp.red, bold = true },
					BlinkPairsYellow = { fg = cp.yellow, bold = true },
					BlinkPairsBlue = { fg = cp.sapphire, bold = true },
					BlinkPairsOrange = { fg = cp.peach, bold = true },
					BlinkPairsGreen = { fg = cp.green, bold = true },
					BlinkPairsPurple = { fg = cp.lavender, bold = true },
					BlinkPairsCyan = { fg = cp.teal, bold = true },

					BlinkPairsUnmatched = { fg = cp.red, bold = false, underline = true },
					-- BlinkPairsMatchParen = { fg = cp.base, bg = cp.surface2, bold = true },
				}
			end,
		},

		-- 禁用lsp诊断信息的斜体
		lsp_styles = {
			virtual_text = {
				errors = {},
				hints = {},
				warnings = {},
				information = {},
				ok = {},
			},
			-- underlines = {
			-- 	errors = { "underline" },
			-- 	hints = { "underline" },
			-- 	warnings = { "underline" },
			-- 	information = { "underline" },
			-- 	ok = { "underline" },
			-- },
			-- inlay_hints = { background = false },
		},

		-- 去除 virtual_text 诊断背景遮罩
		custom_highlights = function(c)
			return {
				DiagnosticVirtualTextError = { bg = c.none, style = {} },
				DiagnosticVirtualTextWarn = { bg = c.none, style = {} },
				DiagnosticVirtualTextInfo = { bg = c.none, style = {} },
				DiagnosticVirtualTextHint = { bg = c.none, style = {} },
				DiagnosticVirtualTextOk = { bg = c.none, style = {} },
				-- DiagnosticVirtualLinesError = { bg = c.none, style = {} },
				-- DiagnosticVirtualLinesWarn = { bg = c.none, style = {} },
				-- DiagnosticVirtualLinesInfo = { bg = c.none, style = {} },
				-- DiagnosticVirtualLinesHint = { bg = c.none, style = {} },
				-- DiagnosticVirtualLinesOk = { bg = c.none, style = {} },
			}
		end,

		-- 改亮暗色主题的代码背景颜色
		color_overrides = {
			latte = {
				base = "#f5f5f5", -- ← 改成你想要的背景色
				mantle = "#f5f5f5", -- 可选：控制neo-tree和lualine的背景
				crust = "#f5f5f5", -- 可选：控制bufferline的颜色和背景
			},
			mocha = {
				base = "#262626", -- ← 改成你想要的背景色
				mantle = "#262626", -- 可选：侧边/浮窗等更深的背景
				crust = "#262626", -- 可选：最外层背景
			},
		},
	},

	-- 应用主题
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
