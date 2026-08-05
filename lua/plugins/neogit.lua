vim.pack.add({
  "https://github.com/NeogitOrg/neogit.git",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/m00qek/baleia.nvim",
})

local neogit = require("neogit")
vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Open Neogit UI" })
