vim.pack.add({
  "https://github.com/benomahony/oil-git.nvim",
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
    "permissions",
    "size",
    "mtime",
  },
})
