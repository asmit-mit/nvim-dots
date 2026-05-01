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

local function close_dap_terminals()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name:match("dap%-terminal") then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

dap.listeners.after.event_initialized["dapview_auto"] = function()
  vim.defer_fn(function()
    vim.cmd("DapViewOpen")
  end, 100)
end

dap.listeners.before.event_terminated["dapview_auto"] = function()
  vim.cmd("DapViewClose")
  close_dap_terminals()
end

dap.listeners.before.event_exited["dapview_auto"] = function()
  vim.cmd("DapViewClose")
  close_dap_terminals()
end
