return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		"stevearc/oil.nvim", -- (optional) to manage project files
		"nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
	},
	config = function()
		-- Auto-generate buildServer.json for better LSP support
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "swift",
			callback = function()
				-- Generate buildServer.json if missing
				local root_dir = vim.fn.getcwd()
				local build_server_path = root_dir .. "/buildServer.json"
				if vim.fn.filereadable(build_server_path) == 0 then
					vim.defer_fn(function()
						-- Check if the command exists before executing
						if vim.fn.exists(":XcodebuildGenerateBuildServerConfig") > 0 then
							vim.cmd("XcodebuildGenerateBuildServerConfig")
						end
					end, 500) -- Increased delay to ensure plugin is loaded
				end
			end,
			once = true,
		})

		require("xcodebuild").setup({
			show_build_progress_bar = true,

			logs = {
				auto_open_on_success_tests = false,
				auto_open_on_failed_tests = false,
				auto_open_on_success_build = false,
				auto_open_on_failed_build = false,
				auto_focus = false,
				auto_close_on_app_launch = true,
				only_summary = true,
				notify = function(message, severity)
					if vim.trim(message) ~= "" then
						-- Use snacks.nvim's notify instead of fidget
						Snacks.notify(message, {
							level = severity,
							title = "Xcodebuild",
						})
					end
				end,
				notify_progress = function(message)
					-- Use snacks.nvim's notify for progress messages
					-- Create/update notification with a consistent ID
					Snacks.notify(message, {
						id = "xcodebuild_progress", -- Use consistent ID to update the same notification
						title = "Xcodebuild",
						level = "info",
						timeout = message:find("Finished") or message:find("Failed") and 3000 or 0, -- Auto-dismiss after 3s when done
					})
				end,
			},
			code_coverage = {
				enabled = false,
			},
			integrations = {
				pymobiledevice = {
					enabled = true,
				},
				nvim_tree = {
					enabled = false,
				},
				neo_tree = {
					enabled = false,
				},
			},
		})

		vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show Xcodebuild Actions" })
		vim.keymap.set(
			"n",
			"<leader>xf",
			"<cmd>XcodebuildProjectManager<cr>",
			{ desc = "Show Project Manager Actions" }
		)

		vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
		vim.keymap.set("n", "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", { desc = "Build For Testing" })
		vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })
		vim.keymap.set("n", "<leader>xR", "<cmd>XcodebuildBuildDebug<cr>", { desc = "Build & Debug" })

		vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
		vim.keymap.set("v", "<leader>xt", "<cmd>XcodebuildTestSelected<cr>", { desc = "Run Selected Tests" })
		vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })

		vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })

		vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
		vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
		-- Removed Telescope quickfix keybinding as requested

		vim.keymap.set("n", "<leader>xx", "<cmd>XcodebuildQuickfixLine<cr>", { desc = "Quickfix Line" })
		vim.keymap.set("n", "<leader>xa", "<cmd>XcodebuildCodeActions<cr>", { desc = "Show Code Actions" })

		-- Build server configuration for better LSP support
		vim.keymap.set(
			"n",
			"<leader>xg",
			"<cmd>XcodebuildGenerateBuildServerConfig<cr>",
			{ desc = "Generate BuildServer Config" }
		)
		vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildCleanDerivedData<cr>", { desc = "Clean Derived Data" })

		vim.api.nvim_create_autocmd("User", {
			pattern = { "XcodebuildBuildFinished", "XcodebuildTestsFinished" },
			callback = function(event)
				if event.data.cancelled then
					return
				end

				if event.data.success then
					require("trouble").close()
				elseif not event.data.failedCount or event.data.failedCount > 0 then
					if next(vim.fn.getqflist()) then
						require("trouble").open("quickfix")
					else
						require("trouble").close()
					end

					require("trouble").refresh()
				end
			end,
		})
	end,
}
