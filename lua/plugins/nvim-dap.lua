vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap.git",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
})

local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local dapui = require("dapui")

mason_dap.setup({
  automatic_installation = true,
  handlers = {
    function(config)
      require("mason-nvim-dap").default_setup(config)
    end,
  },
})

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
}

dap.configurations.c = dap.configurations.cpp

dapui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "" })

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

-- Debugger keymaps
vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })

-- Leader key mappings
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })

-- Function key mappings
vim.keymap.set("n", "<F2>", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<F3>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<F4>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F5>", dap.step_out, { desc = "Step Out" })

vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
vim.keymap.set("n", "<leader>dq", function()
  dap.terminate()
  dapui.close()
end, { desc = "Terminate" })
vim.keymap.set("n", "<leader>db", dap.list_breakpoints, { desc = "List Breakpoints" })
vim.keymap.set("n", "<leader>de", function() dap.set_exception_breakpoints({ "all" }) end,
  { desc = "Set Exception Breakpoints" })
