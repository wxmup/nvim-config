return {
	"nvim-mini/mini.nvim",
	version = false,

	-- configure lazy load
	event = { "BufReadPre", "BufNewFile", "InsertEnter" },

	-- 导入需要的模块
	config = function()
		-- 给 选中的文本 加/删/改 成对符号
		require("mini.surround").setup()

		-- 更加方便的文本虚拟指示器选择
		require("mini.ai").setup()

		-- 交互式对齐多行文本（等号、冒号、逗号、竖线……），写表格/键值很舒服。
		require("mini.align").setup()
	end,
}
