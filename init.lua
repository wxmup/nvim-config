-- 查找/lua/config/option.lua，这里定义了对neovim的配置，
-- leader键的设置要求比options.lua比lazy.lua更早运行。
-- 所以这个代码要放到最前面
require("config.options")

-- 清空浮动阴影
require("config.noFloatShader")

-- 导入neovide的设置
require("config.myNeovide")

-- 导入autocmd
require("config.autocmds")

-- 这段代码会去找~/.config/nvim/lua/config/lazy.lua
require("config.lazy")

-- load custom keymap
require("config.keymaps")

-- 原生api实现的lsp特性
require("config.nativeLsp")
