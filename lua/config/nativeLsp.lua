-- 1) 统一配置所有语言服务器的诊断（错误/警告等）的外观和行为
vim.diagnostic.config({
	underline = true, -- 在出问题的范围下划线
	update_in_insert = false, -- 插入模式不实时刷新诊断（减少打字卡顿）
	severity_sort = true, -- 诊断按严重级别在列表里排序（先 Error 再 Warn）

	-- 定义状态列的诊断图标
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅙", -- Error
			[vim.diagnostic.severity.WARN] = "", -- Warn
			[vim.diagnostic.severity.HINT] = "󰌵", -- Hint
			[vim.diagnostic.severity.INFO] = "󰋼", -- Info
		},
	},

	-- 仅显示图标，提示有错误
	virtual_text = {
		spacing = 2,
		-- 仅显示前缀图标（正文为空串）
		prefix = "●",
		source = "if_many",
		-- 显示一个简洁的错误提示
	},

	-- 浮窗（按 gl 打开那种）里的展示：信息更完整
	float = {
		border = "rounded", -- 圆角边框，观感更好
		source = "if_many",
	},
})

-- 2) 在插入模式和选择模式下，不显示代码诊断信息
local grp = vim.api.nvim_create_augroup("HideDiagnosticsWhileTyping", { clear = true })

local function toggle(buf)
	local m = vim.api.nvim_get_mode().mode
	local first = m:sub(1, 1)

	local in_insert = (first == "i")
	local in_select = (first == "s") or (first == "S") or (m == string.char(19)) -- ^S 选择块
	local in_visual = (first == "v") or (first == "V") or (m == string.char(22)) -- ^V 可视块

	-- 在插入 / 选择 / 可视模式：关掉诊断；其他模式：打开诊断
	local enable = not (in_insert or in_select or in_visual)

	-- 新 API：第一个参数是 boolean，第二个参数是 filter table
	vim.diagnostic.enable(enable, { bufnr = buf })
end

-- ModeChanged 足够覆盖大多数切换，BufEnter 确保切到缓冲区时状态正确。
vim.api.nvim_create_autocmd({ "ModeChanged", "BufEnter" }, {
	group = grp,
	callback = function(ev)
		toggle(ev.buf)
	end,
})

-- 2) 查看/跳转诊断的快捷键（建议）
-- 浮窗查看当前行诊断；focusable=false 让浮窗不抢焦点，按 Esc 不用关
-- 上/下条诊断（跨行跳转）
vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float(nil, { focusable = false })
end, { desc = "显示本行诊断（浮窗）" })

vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "上一条诊断" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "下一条诊断" })

vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "上一条 Error" })

vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "下一条 Error" })

-- 5) 调用lsp文件夹下的配置
vim.lsp.enable({ "emmylua_ls", "clangd" })
