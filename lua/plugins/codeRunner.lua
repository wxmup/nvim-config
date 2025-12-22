-- 按 F5 保存文件并编译代码并执行二进制文件
return {
    "CRAG666/code_runner.nvim",
    main = "code_runner",                      -- 指定 setup 入口模块
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    opts = {
        -- 选择运行模式 'term' 或 'float'
        mode = "float",
        -- 焦点设置
        focus = true,
        startinsert = false,
        term = { position = "bot", size = 10 },
        float = {
            border = "rounded",
            height = 0.8,
            width  = 0.8,
            x = 0.5, y = 0.5,
            border_hl = "FloatBorder",
            -- float_hl = "Normal",
            blend = 0,
        },
        filetype = {
            c = {
                -- 进入文件目录 -> 创建 out -> 编译到 out -> 运行 out 下的可执行文件
                "cd $dir &&",
                "mkdir -p out &&",
                "clang -Wall -Wextra -O2 -o out/$fileNameWithoutExt $fileName &&",
                "./out/$fileNameWithoutExt",
            },
            cpp = {
                "cd $dir &&",
                "mkdir -p out &&",
                "clang++ -std=c++17 -Wall -Wextra -O2 -o out/$fileNameWithoutExt $fileName &&",
                "./out/$fileNameWithoutExt",
            },
        },
    },
    keys = {
        { "<F5>",       "<cmd>w<CR><cmd>RunCode<CR>",  desc = "Save and Run Code" },
        { "<S-F5>",     "<cmd>RunClose<CR>",           desc = "Stop Running" },
        { "<C-F5>",     "<cmd>w<CR><cmd>RunFile<CR>",  desc = "Save and Run File" },
        { "<leader>rc", "<cmd>w<CR><cmd>RunCode<CR>",  desc = "Save and Run Code" },
        { "<leader>rf", "<cmd>w<CR><cmd>RunFile<CR>",  desc = "Save and Run File" },
        { "<leader>rp", "<cmd>RunProject<CR>",         desc = "Run Project" },
        { "<leader>rx", "<cmd>RunClose<CR>",           desc = "Close Runner" },
    },
}
