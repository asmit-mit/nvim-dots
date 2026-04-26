vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

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

require("mini.ai").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.icons").setup()
