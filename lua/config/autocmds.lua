-- 记住文件最后的光标位置
local grp = vim.api.nvim_create_augroup("RestoreCursor", { clear = true })
vim.api.nvim_create_autocmd("BufReadPre", {
	group = grp,
	callback = function(args)
		vim.api.nvim_create_autocmd("FileType", {
			buffer = args.buf,
			once = true,
			callback = function()
				local ft = vim.bo[args.buf].filetype
				if ft:match("commit") or ft == "xxd" or ft == "gitrebase" or vim.wo.diff then
					return
				end
				local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
				local lnum = mark[1]
				if lnum >= 1 and lnum <= vim.api.nvim_buf_line_count(args.buf) then
					vim.cmd('normal! g`"')
				end
			end,
		})
	end,
})
