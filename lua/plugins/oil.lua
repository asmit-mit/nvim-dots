vim.pack.add({
  "https://github.com/JezerM/oil-lsp-diagnostics.nvim",
  "https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
  keymaps = {
    ["<C-r>"] = "actions.refresh",
    ["<C-l>"] = false,
    ["<C-h>"] = false,
  },
  columns = {
    "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
})

require("oil-lsp-diagnostics").setup({
  show_diagnostics = true,
})
