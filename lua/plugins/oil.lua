vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("oil").setup({
  keymaps = {
    ["<C-r>"] = "actions.refresh",
    ["<C-l>"] = false,
    ["<C-h>"] = false,
  },
})
