return {
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({})
	-- 	end,
	-- },
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			-- See Configuration section for options
			window = {
				-- layout = "float",
				-- width = 120, -- Fixed width in columns
				-- height = 30, -- Fixed height in rows
				-- border = "rounded", -- 'single', 'double', 'rounded', 'solid'
				title = "🤖 AI Assistant",
				zindex = 100, -- Ensure window stays on top
			},

			headers = {
				user = "👤 You: ",
				assistant = "🤖 Copilot: ",
				tool = "🔧 Tool: ",
			},
			separator = "━━",
			show_folds = false, -- Disable folding for cleaner look
		},
	},
}
