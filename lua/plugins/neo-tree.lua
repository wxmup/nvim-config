return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle reveal_force_cwd<cr>", desc = "文件树切换" },
		},
		config = function()
			require("neo-tree").setup({
				filesystem = {
					follow_current_file = { enabled = true },
					filtered_items = { visible = false, hide_dotfiles = false },
					window = {
						width = 34,
						mappings = {
							-- 可按需自定义：这里演示把 A/D/R 映射到增删改
							["A"] = "add",
							["D"] = "delete",
							["R"] = "rename",
						},
					},
				},
				default_component_configs = {
					indent = { with_markers = true },
					git_status = { symbols = { added = "A", modified = "M", deleted = "D" } },
				},
			})
		end,
	},
}
