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

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

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
  },
})

require("mini.icons").setup()

require("mini.files").setup()

require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "▒", change = "▒", delete = "▒" },
    priority = 200,
  },
})
