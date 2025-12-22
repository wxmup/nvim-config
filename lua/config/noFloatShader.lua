-- 清除浮动窗口阴影

local M = {}

local set_hl = vim.api.nvim_set_hl

local function kill_float_shadow()
	-- 1) 关闭透明混合（浮窗/补全菜单）
	vim.o.winblend = 0
	vim.o.pumblend = 0

	-- 2) 让浮窗背景与普通背景一致（避免罩层）
	set_hl(0, "NormalFloat", { bg = "NONE" })

	-- 3) 去掉边框/阴影的底色 #8aadf4
	set_hl(0, "FloatBorder", { fg = "#61afef", bg = "NONE" })
	set_hl(0, "FloatShadow", { bg = "NONE", blend = 0 })
	set_hl(0, "FloatShadowThrough", { bg = "NONE", blend = 0 })
end

-- 先执行一次（应对当前 colorscheme）
kill_float_shadow()

-- 每次切换 colorscheme 后再应用，防止被主题覆盖
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = kill_float_shadow,
})

M.refresh = kill_float_shadow
return M
