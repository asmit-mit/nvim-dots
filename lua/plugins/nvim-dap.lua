vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap.git",
  "https://github.com/igorlfs/nvim-dap-view.git",
  "https://github.com/theHamsta/nvim-dap-virtual-text.git",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
})

local dap = require("dap")

require("mason-nvim-dap").setup({
  automatic_installation = true,
  handlers = {
    function(config)
      require("mason-nvim-dap").default_setup(config)
    end,
  },
})

require("dap-view").setup({
  winbar = {
    base_sections = {
      breakpoints = { label = "Breakpoints", keymap = "B" },
      scopes = { label = "Scopes", keymap = "S" },
      exceptions = { label = "Exceptions", keymap = "E" },
      watches = { label = "Watches", keymap = "W" },
      threads = { label = "Stack Trace", keymap = "T" },
      repl = { label = "REPL", keymap = "R" },
    },
    controls = {
      enabled = true,
      position = "right",
      buttons = {
        "play",
        "step_into",
        "step_over",
        "step_out",
        "step_back",
        "run_last",
        "terminate",
        "disconnect",
      },
    },
  },
  windows = {
    size = 0.3,
    position = "below",
    terminal = {
      size = 0.25,
      position = "left",
      hide = {},
    },
  },
  switchbuf = "useopen,split",
})

require("nvim-dap-virtual-text").setup({
  virt_text_pos = 'eol',
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

vim.fn.sign_define("DapBreakpoint", { text = "" })

-- Debugger keymaps
vim.keymap.set("n", "<leader>dt", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })

-- Leader key mappings
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Continue" })
vim.keymap.set("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<leader>du", "<cmd>DapStepOut<CR>", { desc = "Step Out" })

-- Function key mappings
vim.keymap.set("n", "<F2>", "<cmd>DapContinue<CR>", { desc = "Continue" })
vim.keymap.set("n", "<F3>", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
vim.keymap.set("n", "<F4>", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<F5>", "<cmd>DapStepOut<CR>", { desc = "Step Out" })

-- view keymaps
vim.keymap.set("n", "<leader>dv", "<cmd>DapViewOpen<CR>", { desc = "Open Dap View" })
vim.keymap.set("n", "<leader>dq", "<cmd>DapViewClose<CR>", { desc = "Close Dap View" })
vim.keymap.set("n", "<leader>dw", "<cmd>DapViewWatch<CR>", { desc = "Dap Watch" })
vim.keymap.set("n", "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Dap Hover" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-float",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<CR>", { noremap = true, silent = true })
  end
})
