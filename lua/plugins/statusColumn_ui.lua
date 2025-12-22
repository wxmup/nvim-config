vim.opt.signcolumn = "no"
-- 当行号小于1000时，status column不会抖动
vim.o.numberwidth = 3

return {
	-- make marks great
	{
		"chentoast/marks.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },
		opts = {
			-- 避免在侧边栏/特殊 buffer 里折腾
			-- excluded_filetypes = { "neo-tree", "help", "dashboard" },
			-- excluded_buftypes = { "nofile", "prompt" },
		},
	},

	-- make statul column great
	{
		"luukvbaal/statuscol.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },
		config = function()
			local builtin = require("statuscol.builtin")

			local function fold_or_space(args)
				local s = builtin.foldfunc(args)
				if s == "" then
					return string.rep(" ", args.fold.width)
				end
				return s
			end

			require("statuscol").setup({
				setopt = true,
				ft_ignore = { "neo-tree", "help", "dashboard" },
				bt_ignore = { "nofile", "prompt", "terminal" },
				-- 用默认的右对齐逻辑；并让当前行号在 rnu 下也跟其它行对齐
				relculright = true, -- statuscol 提供的选项 :contentReference[oaicite:4]{index=4}

				segments = {
					-- 左1：marks（你 namespaces 里有 MarkSigns；同时也兼容 legacy Marks_）
					{
						sign = {
							namespace = { "MarkSigns" },
							name = { "^Marks_" },
							maxwidth = 1,
							colwidth = 1,
							auto = " ", -- 关键：永远占位，不抖 :contentReference[oaicite:5]{index=5}
							fillchar = " ",
						},
						click = "v:lua.ScSa",
					},

					-- 左2：诊断 signs（你给的 namespaces 明确包含 *.diagnostic.signs）
					{
						sign = {
							namespace = { ".*diagnostic%.signs" },
							maxwidth = 1,

							-- 关键：这里很可能需要 1（取决于你的字体宽度自检结果）
							colwidth = 1,

							auto = " ", -- 关键：永远占位，不抖 :contentReference[oaicite:6]{index=6}
							fillchar = " ",
						},
						click = "v:lua.ScSa",
					},

					-- 中间：行号（右对齐、稳定）
					{ text = { " ", builtin.lnumfunc, " " }, click = "v:lua.ScLa" },

					-- 右1：fold（固定宽度）
					{ text = { fold_or_space }, click = "v:lua.ScFa", hl = "FoldColumn" },

					-- 右2：git（如果你的 git 图标也会撑宽，就把 colwidth 改成 2）
					{
						sign = {
							namespace = { "gitsigns" },
							name = { "^GitSigns" },
							maxwidth = 1,
							colwidth = 1,
							auto = " ", -- 永远占位，不抖 :contentReference[oaicite:7]{index=7}
							fillchar = " ",
						},
						click = "v:lua.ScSa",
					},

					-- 最右侧留 1 格，避免 fold/git 贴到代码与缩进线
					{ text = { " " } },
				},
			})
		end,
	},
}
