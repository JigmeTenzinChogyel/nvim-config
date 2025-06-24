return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

    require('dapui').setup()
    require('dap-go').setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		map("n", "<F5>", dap.continue, opts)
		map("n", "<F10>", dap.step_over, opts)
		map("n", "<F11>", dap.step_into, opts)
		map("n", "<F12>", dap.step_out, opts)
		map("n", "<Leader>b", dap.toggle_breakpoint, opts)
		map("n", "<Leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, opts)
		map("n", "<Leader>lp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, opts)
		map("n", "<Leader>dr", dap.repl.open, opts)
		map("n", "<Leader>dl", dap.run_last, opts)
	end,
}
