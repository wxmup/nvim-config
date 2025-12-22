return {
	"folke/flash.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },

	---@type Flash.Config
	opts = {
		label = {
			-- 显示标签的最小长度
			min_pattern_length = 2,
			-- 彩虹标签
			rainbow = {
				enabled = true,
				-- number between 1 and 9
				shade = 1,
			},
		},
	},

    -- stylua: ignore
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        -- Simulate nvim-treesitter incremental selection
        { "<c-space>", mode = { "n", "o", "x" },
            function()
                require("flash").treesitter({
                    actions = {
                        ["<c-space>"] = "next",
                        ["<BS>"] = "prev"
                    }
                }) 
            end, desc = "Treesitter Incremental Selection" },
    },
}
