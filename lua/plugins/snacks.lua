return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	---@module "snacks",
	---@type snacks.Config
	opts = {
		dim = { enabled = true },
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		animate = { enabled = true, fps = 240 },

		picker = {
			enabled = true,

			-- 调整picker的一些算法
			matcher = {
				cwd_bonus = true, -- 当前目录加权。更倾向于当前路径下的文件
				frecency = true, -- 开启记忆加权。打开次数越多越靠前。
				sort_empty = true, --  首次打开时预览器就显示排序后的结果
			},

			-- 全局调整搜索时的路径规则：fd
			sources = {
				files = {
					-- 排除以下的文件路径
					exclude = {
						-- do not search these filefolder
						"/dwhelper/",
						"/LightlyShaders/",
						"/下载/",
						"/图片/",
						"/视频/",
						"/文档/xwechat_files/",
						-- do not search these suffix file
						"*.pdf",
						"*.mp4",
						"*.jpg",
						"*.png",
						-- do not search build binary file folder
						"/build/",
						"/out/",
						"/bin/",
						"/dist/",
						"/cmake-build-*/",
					},
				},
			},
		},
	},

	-- snacks全局键位设定
	keys = {
		-- 查找家目录文件
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find File",
		},

		-- 查找neoovim的配置文件
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true })
			end,
			desc = "Find Config File",
		},

		-- 查找根目录文件
		{
			"<leader>fr",
			function()
				Snacks.picker.files({
					cwd = "/",
					args = {
						-- 只搜文件，不搜目录
						"--type",
						"f",
						-- 只搜如下目录的文件夹
						"--search-path",
						"/etc",
						"--search-path",
						"/boot",
						"--search-path",
						"/usr/lib/systemd",
						"--search-path",
						"/etc/systemd",
						"--search-path",
						"/usr/share/fontconfig",
						-- 排除如下目录的文件夹
						"--exclude",
						"build",
						"--exclude",
						"out",
						-- 不跨文件系统搜索
						"--one-file-system",
						-- 搜索时的递归深度不超过6层
						-- 	"--max-depth",
						-- 	"6",
					},
				})
			end,
			desc = "Find Root File",
		},

		{
			"<leader>fR",
			function()
				Snacks.picker.grep({
					cwd = "/",
					args = {
						-- 只搜文件，不搜目录
						"--type",
						"f",
						-- 只搜如下目录的文件夹
						"--search-path",
						"/etc",
						"--search-path",
						"/boot",
						"--search-path",
						"/usr/lib/systemd",
						"--search-path",
						"/etc/systemd",
						"--search-path",
						"/usr/share/fontconfig",
						-- 排除如下目录的文件夹
						"--exclude",
						"build",
						"--exclude",
						"out",
						-- 不跨文件系统搜索
						"--one-file-system",
					},
				})
			end,
			desc = "Find Root File",
		},

		-- 显示所有的代码诊断信息
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "显示所有的诊断信息",
		},

		-- 查询重做历史
		{
			"<leader>fu",
			function()
				Snacks.picker.undo()
			end,
			desc = "Find Undo history",
		},
	},
}
