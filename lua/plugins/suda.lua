-- 可自动识别 直读文件 并提供编辑和保存
return {
	"lambdalisue/suda.vim",
	init = function()
		vim.g.suda_smart_edit = 1 -- 智能模式，自动切换到 suda:/// 打开
		-- 可选：自定义密码提示
		-- vim.g["suda#prompt"] = "Password: "
	end,
	event = { "BufReadPre", "BufNewFile" },
}
