vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.shiftwidth = 2
vim.opt.swapfile = false
vim.opt.autoindent = true
vim.opt.expandtab = true


vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true

vim.opt.signcolumn = "yes"
vim.opt.backspace = "indent,eol,start"

vim.opt.clipboard:append("unnamedplus")

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 5

vim.g.mapleader = " "

local undo_dir = vim.fn.stdpath("config") .. "/undo"

if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, "p")
end

vim.opt.undofile = true
vim.opt.undodir = undo_dir
vim.opt.undolevels = 50

local clean_old_undo = function()
  local cmd = "find " .. undo_dir .. " -type f -mtime +1 -delete"
  os.execute(cmd)
end

clean_old_undo()

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>s=", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sw", "<cmd>close<CR>", { desc = "Close current split" })

vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tw", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", opts)

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

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
})

vim.lsp.enable({
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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    local keymap = vim.keymap.set

    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        prefix = "●",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))

    keymap("n", "gD", function() vim.lsp.buf.declaration() end,
      vim.tbl_extend("force", opts, { desc = "Go to declaration" }))

    keymap("n", "gy", function() Snacks.picker.lsp_type_definitions() end,
      vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

    keymap("n", "gS", function() Snacks.picker.lsp_symbols() end,
      vim.tbl_extend("force", opts, { desc = "List symbols" }))

    keymap("n", "gr", function() Snacks.picker.lsp_references() end,
      vim.tbl_extend("force", opts, { desc = "List references" }))

    keymap("n", "gI", function() Snacks.picker.lsp_implementations() end,
      vim.tbl_extend("force", opts, { desc = "Go to implementation" }))

    keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover information" }))

    keymap("n", "<leader>la", function() vim.lsp.buf.code_action() end,
      vim.tbl_extend("force", opts, { desc = "Show code actions" }))

    keymap("n", "<leader>lr", function() vim.lsp.buf.rename() end,
      vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

    keymap("n", "<leader>lk", function() vim.diagnostic.open_float() end,
      vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))

    keymap("n", "<leader>ln", function() vim.diagnostic.goto_next() end,
      vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))

    keymap("n", "<leader>lp", function() vim.diagnostic.goto_prev() end,
      vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
  end,
})

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

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

vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'E501' },
        }
      }
    }
  }
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
})
