return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"wojciech-kulik/xcodebuild.nvim",
	},
	config = function()
		local dap = require("dap")

		-- Xcodebuild setup for Swift/iOS debugging
		local xcodebuild = require("xcodebuild.integrations.dap")
		xcodebuild.setup(true)

		-- General DAP keybindings (work across all languages)
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug Continue" })
		vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Debug Step Over" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug Step Into" })
		vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug Step Out" })
		vim.keymap.set("n", "<leader>dR", dap.repl.open, { desc = "Open Debug REPL" })
		vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug Run Last" })
		vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate Debug Session" })

		-- General DAP breakpoints (for non-Xcode debugging)
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint (DAP)" })
		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Set Conditional Breakpoint" })
		vim.keymap.set("n", "<leader>lp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, { desc = "Set Log Point" })

		-- Xcodebuild specific keybindings (prioritized for Swift/iOS)
		vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug (Xcode)" })
		vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building (Xcode)" })
		vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests (Xcode)" })
		vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests (Xcode)" })
		vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint (Xcode)" })
		vim.keymap.set(
			"n",
			"<leader>B",
			xcodebuild.toggle_message_breakpoint,
			{ desc = "Toggle Message Breakpoint (Xcode)" }
		)
		vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger (Xcode)" })
	end,
}
