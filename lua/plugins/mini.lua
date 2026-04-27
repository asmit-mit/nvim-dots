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

require("mini.pairs").setup({
  modes = { insert = true, command = true, terminal = false },
  skip_ts = { "string" },
  skip_unbalanced = true,
})

require("mini.surround").setup({
  mappings = {
    add = "gsa",
    delete = "gsd",
    highlight = "gsh",
    replace = "gsr",
  }
})

require("mini.icons").setup()
