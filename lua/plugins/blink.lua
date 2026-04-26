vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = "v1.10.2", 
  },
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/neovim/nvim-lspconfig",
})

require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
  fuzzy = {
    implementation = "prefer_rust_with_warning",
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
