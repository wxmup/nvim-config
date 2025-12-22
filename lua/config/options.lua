local o = vim.opt

-- 把 主 Leader 和 本地 Leader 都设为空格。
-- 两行要尽量放在 任何按键映射之前
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- 告诉其它插件，渲染 Nerd Font 图标
vim.g.have_nerd_font = true

-- 启用 Neovim 内置 Lua 模块加载器（0.9+），加速 require()
vim.loader.enable()

-- 启用系统剪贴板同步（在ui启动之后输入时才同步，否则会拖慢启动速度）
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- 全局设置圆角，避免插件内部一个个设置
vim.o.winborder = "rounded"

-- 启用24位颜色
vim.o.termguicolors = true

-- 软换行时（wrap 为真才有意义）在合适的断点处换行，不把单词切开。
vim.o.linebreak = true
-- 启用断行缩进（代码长度超出行号自动换行显示）
vim.o.breakindent = true
vim.o.wrap = true

-- 缩进格数限制
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
-- 相对行号
o.number = true
o.relativenumber = true
-- 显示光标所在的行号
o.cursorline = true
o.cursorlineopt = "number" -- 仅显示行号不显示整行高亮

-- 如果为true,下一次打开文件仍然可以撤回到上一次的更改。因为更改历史被储存。
vim.o.undofile = true

-- 搜索体验
vim.o.ignorecase = true -- ✅ 小写搜索忽略大小写
vim.o.smartcase = true -- ✅ 但如果搜索里含大写，则区分大小写（聪明）

-- 让诊断提示、行内代码气泡、git 标记等反馈更快出现，同时会更频繁地写入 swap
vim.o.updatetime = 200

-- 等待映射按键序列的最大时间（默认是 1000ms）
vim.o.timeoutlen = 500

-- Configure how new splits should be opened
vim.o.splitright = true -- 竖向分屏，新窗口默认开在右边
vim.o.splitbelow = true -- 横向分屏，新窗口默认开在下面

-- 开启预览显示效果上的实时替换
vim.o.inccommand = "split"

-- 光标所在的上下面的行 各自为 10行
vim.o.scrolloff = 10

-- 分割行为
vim.o.splitkeep = "screen" --  分屏时尽量“保持视图稳定”，减少跳动

-- 鼠标
vim.o.mouse = "a" --  需要时可用鼠标（随时可关）

-- 细节优化
vim.opt.fillchars = { eob = " " } --  去掉空白区的“~”
-- vim.opt.whichwrap:append("<>[]hl") --  到行首/尾时允许左右键跨行

-- 状态栏设置
vim.o.ruler = false -- 关闭右下角 “行,列,进度”
vim.o.laststatus = 3 --  全局一条状态栏（好看、省空间）,如果参数是2则每个窗口各有一条
vim.o.showmode = false -- 关闭内置的当前输入模式显示

-- 禁止按下o时自动添加注释前缀
local grp = vim.api.nvim_create_augroup("NoAutoComment", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = grp,
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "o" })
	end,
})
