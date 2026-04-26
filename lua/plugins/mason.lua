vim.pack.add({
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require('mason-tool-installer').setup {
  ensure_installed = {
    "clangd",
    "css-lsp",
    "emmet-ls",
    "html-lsp",
    "lua-language-server",
    "marksman",
    "python-lsp-server",
    "rust-analyzer",
    "ts_query_ls",
    "mesonlsp",
    "cmake-language-server",
    "django-language-server",
    -- Formatters
    "clang-format",
    "djlint",
    "gersemi",
    "prettier",
    -- Debuggers
    "codelldb",
  },
  run_on_start = true,
  start_delay = 3000,
  integrations = {
    ['mason-nvim-dap'] = true,
  },
}
