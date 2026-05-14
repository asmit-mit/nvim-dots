vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
  image = { enabled = true },
  bigfile = { enabled = false },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  indent = { enabled = true },
  input = { enabled = false },
  notifier = {
    timeout = 3000,
    width = { min = 20, max = 40 },
    height = { min = 1, max = 100 },
    margin = { top = 0, right = 1, bottom = 0 },
    padding = true,
    sort = { "level", "added" },
    level = vim.log.levels.TRACE,
    icons = {
      error = " ",
      warn = " ",
      info = " ",
      debug = " ",
      trace = " ",
    },
    keep = function(notif)
      return vim.fn.getcmdpos() > 0
    end,
    style = "compact",
    top_down = true,
    date_format = "%R",
    more_format = " ↓ %d lines ",
    refresh = 50,
  },
  picker = { layout = "default" },
  quickfile = { enabled = false },
  scope = { enabled = false },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = true },
    },
  },
})

local Snacks = require("snacks")

local snacks_keymaps = {
  -- find
  { "<leader>ff", function() Snacks.picker.smart() end,                                   "Smart Find Files", },
  { "<leader>fg", function() Snacks.picker.grep() end,                                    "Grep", },
  { "<leader>fb", function() Snacks.picker.buffers() end,                                 "Buffers", },
  { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, "Find Config File", },
  { "<leader>fr", function() Snacks.picker.recent() end,                                  "Recent", },
  -- git
  { "<leader>gb", function() Snacks.picker.git_branches() end,                            "Git Branches", },
  { "<leader>gl", function() Snacks.picker.git_log() end,                                 "Git Log", },
  { "<leader>gL", function() Snacks.picker.git_log_line() end,                            "Git Log Line", },
  { "<leader>gs", function() Snacks.picker.git_status() end,                              "Git Status", },
  { "<leader>gS", function() Snacks.picker.git_stash() end,                               "Git Stash", },
  { "<leader>gd", function() Snacks.picker.git_diff() end,                                "Git Diff (Hunks)", },
  { "<leader>gf", function() Snacks.picker.git_log_file() end,                            "Git Log File", },
  { "<leader>gB", function() Snacks.gitbrowse() end,                                      "Git Browse",                { "n", "v" }, },
  { "<leader>gg", function() Snacks.lazygit() end,                                        "Lazygit", },
  -- notif
  { "<leader>nh", function() Snacks.notifier.show_history() end,                          "Notification History", },
  { "<leader>nd", function() Snacks.notifier.hide() end,                                  "Dismiss All Notifications", },
  -- misc
  { "<leader>si", function() Snacks.picker.icons() end,                                   "Icons" },
}

for _, map in ipairs(snacks_keymaps) do
  local lhs, func, desc, mode = map[1], map[2], map[3], map[4] or "n"
  vim.keymap.set(mode, lhs, func, { desc = desc, silent = true })
end
