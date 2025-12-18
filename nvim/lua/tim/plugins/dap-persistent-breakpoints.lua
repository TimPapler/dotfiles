return {
	"Weissle/persistent-breakpoints.nvim",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("persistent-breakpoints").setup({
			save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
			load_breakpoints_event = { "BufReadPost" },
			-- Automatically save breakpoints when changed
			on_attach = function()
				vim.cmd("silent! :PBLoad")
			end,
		})

		-- Override the default DAP breakpoint keybindings to use persistent breakpoints
		-- These save/load automatically
		vim.keymap.set("n", "<leader>db", function()
			require("persistent-breakpoints.api").toggle_breakpoint()
		end, { desc = "Toggle Breakpoint (Persistent)" })

		vim.keymap.set("n", "<leader>dB", function()
			require("persistent-breakpoints.api").set_conditional_breakpoint()
		end, { desc = "Set Conditional Breakpoint (Persistent)" })

		vim.keymap.set("n", "<leader>dC", function()
			require("persistent-breakpoints.api").clear_all_breakpoints()
		end, { desc = "Clear All Breakpoints" })
	end,
}
