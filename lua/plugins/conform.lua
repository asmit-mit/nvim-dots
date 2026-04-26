vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

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
    html = { "prettier" },
    css = { "prettier" },
    htmldjango = { "djlint" },
  },
  formatters = {
    black = {
      prepend_args = { "--line-length", "100" },
    },
    isort = {
      prepend_args = { "--line-length", "100" },
    },
    djlint = {
      prepend_args = { "--indent", "2" },
    },
    prettier = {
      prepend_args = { "--print-width", "100" },
    },
  },
})
