-- 用一个插件管理所有语言的格式化，code format 也在这个插件定义

-- 目标：提升 C/C++ 代码可读性（Allman 花括号、禁止短语句挤一行、定义块分隔、空行上限、4 空格缩进等）
-- 把 style 拆开写，最后拼成 clang-format 接受的单个 --style=... 字符串（YAML inline map）
local clang_style = table.concat({
	"{",
	-- 基础
	"BasedOnStyle: LLVM,",
	"Language: C,", -- 让 clang-format 明确按 C 语言规则处理（对 .c 文件基本多余，但放着更直观）

	-- 缩进 / 列宽
	"IndentWidth: 4,",
	"TabWidth: 4,",
	"ContinuationIndentWidth: 4,",

	-- 大括号风格
	"BreakBeforeBraces: Allman,",

	-- 可读性：避免短代码挤成一行
	"AllowShortFunctionsOnASingleLine: None,",
	"AllowShortIfStatementsOnASingleLine: Never,",
	"AllowShortLoopsOnASingleLine: false,",
	"AllowShortBlocksOnASingleLine: Never,",

	-- 空格：控制语句更易读
	"SpaceBeforeParens: ControlStatements,",

	-- 参数/实参换行：避免“塞一团”
	"BinPackParameters: false,",
	"BinPackArguments: false,",
	"AlignAfterOpenBracket: true,",

	-- 对齐：适度增强可读性（不喜欢“竖线感”可把两行 Consecutive 删掉）
	"AlignTrailingComments: true,",
	"AlignConsecutiveAssignments: Consecutive,",
	"AlignConsecutiveDeclarations: Consecutive,",

	-- 指针风格
	"DerivePointerAlignment: false,",
	"PointerAlignment: Right,",

	-- 空行策略（注意：clang-format 不能强制“函数之间两行”，这里只能确保分隔 + 最多保留两行）
	"SeparateDefinitionBlocks: Always,",
	"MaxEmptyLinesToKeep: 2,",
	"}",
}, " ")

return {
	"stevearc/conform.nvim",

	-- 仅在加载 c/cpp/lua 文件的时候加载插件
	ft = { "c", "cpp", "lua" },

	-- 或者仅在明确手动触发格式化的情况下加载插件
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			mode = "n",
			desc = "手动格式化代码",
		},
	},

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },

			-- 代码保存时自动清空行尾的空字符
			["_"] = { "trim_whitespace" },
		},

		-- 保存时自动格式化
		format_on_save = {
			timeout_ms = 500, -- 格式化超过这个时间就停止格式化，防止卡死
			lsp_format = "fallback",
		},

		-- 自定义 clang-format（方案 B：内联 style）
		formatters = {
			["clang-format"] = {
				-- prepend_args / append_args 都行；这里把 style 放前面更直观
				prepend_args = {
					"--style=" .. clang_style,
				},
				-- 强烈建议加这个：很多格式化是走 stdin 的，assume-filename 能让 clang-format 正确识别语言/行为更稳定
				append_args = {
					"-assume-filename",
					"$FILENAME",
				},
			},
		},
	},
}
