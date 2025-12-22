-- 进入普通模式时切换到英文输入法。
return {
	"keaising/im-select.nvim",
	event = "VeryLazy",
	opts = {
		default_im_select = "keyboard-us",

		default_command = "fcitx5-remote",

		set_default_events = { "InsertLeave", "CmdlineLeave" },

		-- set_previous_events = { "InsertEnter" }, -- 插入时恢复先前的输入法
		set_previous_events = {}, -- 插入时不恢复之前的输入法

		-- Show notification about how to install executable binary when binary missed
		keep_quiet_on_no_binary = false,

		-- Async run `default_command` to switch IM or not
		async_switch_im = true,
	},
}
