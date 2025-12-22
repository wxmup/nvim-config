-- 检查是否在 Neovide 中运行
if vim.g.neovide then
	vim.o.guifont = "Maple Mono CN,Symbols Nerd Font Mono:h13"

	-- 禁用浮动窗口阴影,会造成亮色主题的额外边框.
	vim.g.neovide_floating_shadow = false

	-- 平滑滚动到目的地的时间，越小则滚动速度越快
	vim.g.neovide_scroll_animation_length = 0.2

	-- 设定程序刷新率
	vim.g.neovide_refresh_rate = 240

	-- 设定光标最大动画时长
	vim.g.neovide_cursor_animation_length = 0.170

	-- 光标在短距离移动时的动画时长
	vim.g.neovide_cursor_short_animation_length = 0.07

	-- 光标闪烁动画
	vim.g.neovide_cursor_smooth_blink = true
	vim.opt.guicursor:append("a:blinkwait700-blinkon475-blinkoff475")

	-- 跟随系统自动切换主题
	vim.g.neovide_theme = "auto"
end
