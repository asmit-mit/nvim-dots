vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.shiftwidth = 2
vim.opt.swapfile = false
vim.opt.autoindent = true
vim.opt.expandtab = true


vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true

vim.opt.signcolumn = "yes"
vim.opt.backspace = "indent,eol,start"

vim.opt.clipboard:append("unnamedplus")

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 5

vim.g.mapleader = " "

local undo_dir = vim.fn.stdpath("config") .. "/undo"

if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, "p")
end

vim.opt.undofile = true
vim.opt.undodir = undo_dir
vim.opt.undolevels = 50

local clean_old_undo = function()
  local cmd = "find " .. undo_dir .. " -type f -mtime +1 -delete"
  os.execute(cmd)
end

clean_old_undo()

