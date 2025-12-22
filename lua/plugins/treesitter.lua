return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- 不支持 lazy-loading
		build = ":TSUpdate", -- 升级时同步 parser

		config = function()
			-- 1) 缺 parser 就自动安装，装好后自动启用高亮
			do
				local ts = require("nvim-treesitter")
				local installing = {}
				local pending = {} ---@type table<string, table<integer, true>>

				local function parser_exists(lang)
					return lang and lang ~= "" and #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) > 0
				end

				local function can_start(buf, lang)
					if not (buf and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf)) then
						return false
					end
					if vim.bo[buf].buftype ~= "" then
						return false
					end
					local ft = vim.bo[buf].filetype
					local cur_lang = vim.treesitter.language.get_lang(ft)
					return cur_lang == lang
				end

				local function start_ts(buf, lang)
					if can_start(buf, lang) then
						pcall(vim.treesitter.start, buf, lang)
					end
				end

				local function enqueue(buf, lang)
					pending[lang] = pending[lang] or {}
					pending[lang][buf] = true
				end

				local function flush(lang)
					local q = pending[lang]
					pending[lang] = nil
					if not q then
						return
					end
					for buf, _ in pairs(q) do
						start_ts(buf, lang)
					end
				end

				local function ensure_parser_then_start(buf, lang)
					if not lang or lang == "" then
						return
					end
					enqueue(buf, lang)

					if parser_exists(lang) then
						flush(lang)
						return
					end

					if installing[lang] then
						return
					end
					installing[lang] = true

					pcall(ts.install, { lang })

					local tries = 0
					local timer = vim.uv.new_timer()
					timer:start(100, 200, function()
						tries = tries + 1
						if parser_exists(lang) or tries > 60 then
							timer:stop()
							timer:close()
							vim.schedule(function()
								installing[lang] = nil
								if parser_exists(lang) then
									flush(lang)
								end
							end)
						end
					end)
				end

				vim.api.nvim_create_autocmd("FileType", {
					group = vim.api.nvim_create_augroup("ts_parser_auto_install_and_start", { clear = true }),
					callback = function(ev)
						if vim.bo[ev.buf].buftype ~= "" then
							return
						end
						local lang = vim.treesitter.language.get_lang(ev.match)
						if not lang then
							return
						end
						ensure_parser_then_start(ev.buf, lang)
					end,
				})
			end

			-- 2) 初次安装/补齐 parsers（按需改成你的语言清单）
			require("nvim-treesitter")
				.install({
					"lua",
					"vim",
					"vimdoc",
					"query",
					"c",
					"bash",
					"python",
					"javascript",
					"typescript",
					"regex",
					"fish",
					"json",
					"jsonc",
					"yaml",
					"toml",
					"ini",
					"xml",
					"diff",
				})
				:wait(300000) -- 引导期需要同步装好时加上
		end,
	},

	-- 代码块预览
	{
		"nvim-treesitter/nvim-treesitter-context",

		-- 懒加载设置
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },

		opts = {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			multiwindow = false, -- Enable multiwindow support.
			max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		},
	},

	-- 语法感知（选择函数/类等，跳转函数/类等）
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		opts = {
			move = {
				enable = true,
				set_jumps = true,
				keys = {
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]A"] = "@parameter.inner",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			-- 1. 不再用 LazyVim.error，改成 vim.notify
			local ok, TS = pcall(require, "nvim-treesitter-textobjects")
			if not ok or not TS.setup then
				vim.notify("nvim-treesitter-textobjects is not installed or too old", vim.log.levels.ERROR)
				return
			end

			TS.setup(opts)

			-- 2. 自己实现一个 has_textobjects，替代 LazyVim.treesitter.have
			local function has_textobjects(ft)
				local ok_query, query = pcall(vim.treesitter.query.get, ft, "textobjects")
				return ok_query and query ~= nil
			end

			local function attach(buf)
				local ft = vim.bo[buf].filetype
				if not (opts.move and opts.move.enable and has_textobjects(ft)) then
					return
				end

				---@type table<string, table<string, string>>
				local moves = (opts.move and opts.move.keys) or {}

				for method, keymaps in pairs(moves) do
					for key, query in pairs(keymaps) do
						local queries = type(query) == "table" and query or { query }
						local parts = {}
						for _, q in ipairs(queries) do
							local part = q:gsub("@", ""):gsub("%..*", "")
							part = part:sub(1, 1):upper() .. part:sub(2)
							table.insert(parts, part)
						end
						local desc = table.concat(parts, " or ")
						desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
						desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")

						-- 3. 保留 diff 兼容逻辑（避免抢占 [c / ]c）
						if not (vim.wo.diff and key:find("[cC]")) then
							vim.keymap.set({ "n", "x", "o" }, key, function()
								require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
							end, {
								buffer = buf,
								desc = desc,
								silent = true,
							})
						end
					end
				end
			end

			-- FileType 时自动 attach
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("my_treesitter_textobjects", { clear = true }),
				callback = function(ev)
					attach(ev.buf)
				end,
			})

			-- 对已存在的 buffer 也跑一遍
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) then
					attach(buf)
				end
			end
		end,
	},
}
