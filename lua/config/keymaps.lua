-- 删除而不复制寄存器
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "cc", '"_cc')
vim.keymap.set("x", "c", '"_c')

-- 在命令行直接粘贴
-- vim.keymap.set(
-- 	{ "i", "c" },
-- 	"<C-v>",
-- 	"<C-r>*",
-- 	{ noremap = true, silent = true, desc = "Paste PRIMARY (*): middle-click style" }
-- )
-- vim.keymap.set("c", "<C-v>", '<C-r>=getreg("*")<CR>', { noremap = true, silent = true })

-- 更佳智能的i, 自动缩进并进入编辑模式
vim.keymap.set("n", "i", function()
	if #vim.fn.getline(".") == 0 then
		return [["_cc]]
	else
		return "i"
	end
end, { expr = true })

-- 粘贴后自动格式化
vim.keymap.set("n", "p", "p`[v`]=", { noremap = true, silent = true, desc = "Paste + reindent" })
vim.keymap.set("n", "P", "P`[v`]=", { noremap = true, silent = true, desc = "Paste + reindent (before)" })
