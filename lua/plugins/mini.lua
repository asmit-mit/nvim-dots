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
  },
})

require("mini.icons").setup()

require("mini.files").setup()

require("mini.diff").setup({
  view = {
    -- Visualization style. Possible values are 'sign' and 'number'.
    -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
    style = "sign",

    -- Signs used for hunks with 'sign' view
    signs = { add = "▒", change = "▒", delete = "▒" },

    priority = 199,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Apply hunks inside a visual/operator region
    apply = "gh",

    -- Reset hunks inside a visual/operator region
    reset = "gH",

    -- Hunk range textobject to be used inside operator
    -- Works also in Visual mode if mapping differs from apply and reset
    textobject = "gh",

    -- Go to hunk range in corresponding direction
    goto_prev = "<leader>g[",
    goto_next = "<leader>g]",
  },

  options = {
    -- Diff algorithm. See `:h vim.diff()`.
    algorithm = "histogram",

    -- Whether to use "indent heuristic". See `:h vim.diff()`.
    indent_heuristic = true,

    -- The amount of second-stage diff to align lines
    linematch = 60,

    -- Whether to wrap around edges during hunk navigation
    wrap_goto = true,
  },
})
