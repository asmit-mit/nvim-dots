vim.pack.add({
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/folke/noice.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/mfussenegger/nvim-dap.git" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
})


vim.cmd("colorscheme gruvbox")
vim.cmd(":hi statusline guibg=NONE")

require("oil").setup({
  keymaps = {
    ["<C-r>"] = "actions.refresh",
    ["<C-l>"] = false,
    ["<C-h>"] = false,
  },
})

require("which-key").setup({
  preset = "helix",
})

require("mini.ai").setup()

require("mini.move").setup({
  mappings = {
    left = "<S-h>",
    right = "<S-l>",
    down = "<S-j>",
    up = "<S-k>",

    line_left = "<S-h>",
    line_right = "<S-l>",
  },

  options = {
    reindent_linewise = true,
  },
})

require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.icons").setup()

local function lsp_status()
  local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #attached_clients == 0 then
    return ""
  end
  local names = {}
  for _, client in ipairs(attached_clients) do
    local name = client.name:gsub("language.server", "ls")
    table.insert(names, name)
  end
  return "LSP: " .. table.concat(names, ", ")
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        separator = { left = "", right = "" },
      },
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = {
      { lsp_status },
      { "filetype" },
    },
    lualine_y = { { "progress" } },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_c = { "filename" },
    lualine_x = { "location" },
  },
})

require("snacks").setup({
  image = { enabled = true },
  bigfile = { enabled = false },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  indent = { enabled = true },
  input = { enabled = false },
  notifier = {
    timeout = 3000,
    width = { min = 20, max = 40 },
    height = { min = 1, max = 100 },
    margin = { top = 0, right = 1, bottom = 0 },
    padding = true,
    sort = { "level", "added" },
    level = vim.log.levels.TRACE,
    icons = {
      error = " ",
      warn = " ",
      info = " ",
      debug = " ",
      trace = " ",
    },
    keep = function(notif)
      return vim.fn.getcmdpos() > 0
    end,
    style = "compact",
    top_down = true,
    date_format = "%R",
    more_format = " ↓ %d lines ",
    refresh = 50,
  },
  picker = { layout = "default" },
  quickfile = { enabled = false },
  scope = { enabled = false },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = true },
    },
  },
})

local Snacks = require("snacks")

local snacks_keymaps = {
  -- find
  { "<leader>ff", function() Snacks.picker.smart() end,                                   "Smart Find Files", },
  { "<leader>fg", function() Snacks.picker.grep() end,                                    "Grep", },
  { "<leader>fb", function() Snacks.picker.buffers() end,                                 "Buffers", },
  { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, "Find Config File", },
  { "<leader>fr", function() Snacks.picker.recent() end,                                  "Recent", },
  -- git
  { "<leader>gb", function() Snacks.picker.git_branches() end,                            "Git Branches", },
  { "<leader>gl", function() Snacks.picker.git_log() end,                                 "Git Log", },
  { "<leader>gL", function() Snacks.picker.git_log_line() end,                            "Git Log Line", },
  { "<leader>gs", function() Snacks.picker.git_status() end,                              "Git Status", },
  { "<leader>gS", function() Snacks.picker.git_stash() end,                               "Git Stash", },
  { "<leader>gd", function() Snacks.picker.git_diff() end,                                "Git Diff (Hunks)", },
  { "<leader>gf", function() Snacks.picker.git_log_file() end,                            "Git Log File", },
  { "<leader>gB", function() Snacks.gitbrowse() end,                                      "Git Browse",                { "n", "v" }, },
  { "<leader>gg", function() Snacks.lazygit() end,                                        "Lazygit", },
  -- buffers
  { "<leader>bl", function() Snacks.picker.lines() end,                                   "Buffer Lines", },
  { "<leader>bd", function() Snacks.bufdelete() end,                                      "Buffer Delete", },
  { "<leader>br", function() Snacks.rename.rename_file() end,                             "Buffer Rename", },
  -- notif
  { "<leader>nh", function() Snacks.notifier.show_history() end,                          "Notification History", },
  { "<leader>nd", function() Snacks.notifier.hide() end,                                  "Dismiss All Notifications", },
  -- misc
  { "<leader>:",  function() Snacks.picker.command_history() end,                         "Command History" },
  { "<leader>si", function() Snacks.picker.icons() end,                                   "Icons" },
  { "<leader>Z",  function() Snacks.zen.zoom() end,                                       "Toggle Zoom" },
  { "<c-/>",      function() Snacks.terminal() end,                                       "Toggle Terminal" },
  -- lsp stuff
  { "gy",         function() Snacks.picker.lsp_type_definitions() end,                    "Go to type definition" },
  { "gS",         function() Snacks.picker.lsp_symbols() end,                             "List symbols" },
  { "gr",         function() Snacks.picker.lsp_references() end,                          "List references" },
}

for _, map in ipairs(snacks_keymaps) do
  local lhs, func, desc, mode = map[1], map[2], map[3], map[4] or "n"
  vim.keymap.set(mode, lhs, func, { desc = desc, silent = true })
end

require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
  },
})

require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
  fuzzy = {
    implementation = "lua",
  },
  keymap = {
    preset = "default",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
  },
  snippets = {
    preset = "luasnip",
  },
  sources = {
    default = {
      "lsp",
      "snippets",
      "path",
      "buffer",
    },
  },
})

require("mason").setup({
  ensure_installed = {
    "clangd",
    "cmake",
    "cssls",
    "emmet_ls",
    "html",
    "jsonls",
    "lemminx",
    "lua_ls",
    "marksman",
    "pylsp",
    "rust_analyzer",
    "ts_ls",
    "vimls",
    "yamlls",
    "mesonlsp",
    "djlsp",
    -- Formatters
    "clang-format",
    "djlint",
    "gersemi",
    "markdownlint-cli2",
    "prettier",
    "xmlformatter",
    -- Debuggers
    "codelldb",
  },
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})



require("noice").setup()

require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    svelte = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    graphql = { "prettier" },
    cpp = { "clang-format" },
    c = { "clang-format" },
    java = { "clang-format" },
    cmake = { "gersemi" },
    xml = { "xmlformatter" },
  },
  formatters = {
    black = {
      prepend_args = { "--line-length", "100" },
    },
    isort = {
      prepend_args = { "--line-length", "100" },
    },
    ["clang-format"] = {
      prepend_args = {
        "--style={BasedOnStyle: LLVM, AlignAfterOpenBracket: BlockIndent, AlignConsecutiveAssignments: Consecutive}",
      },
    },
    djlint = {
      prepend_args = { "--indent", "2" },
    },
    prettier = {
      prepend_args = { "--print-width", "100" },
    },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },
})

local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local dapui = require("dapui")

mason_dap.setup({
  ensure_installed = { "codelldb" },
  automatic_installation = true,
  handlers = {
    function(config)
      require("mason-nvim-dap").default_setup(config)
    end,
  },
})

-- Configurations
dap.configurations = {
  cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopAtEntry = false,
      MIMode = "lldb",
    },
    {
      name = "Attach to lldbserver :1234",
      type = "codelldb",
      request = "launch",
      MIMode = "lldb",
      miDebuggerServerAddress = "localhost:1234",
      miDebuggerPath = "/usr/bin/lldb",
      cwd = "${workspaceFolder}",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
    },
  },
}

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
