local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<Esc>", function()
  if vim.v.hlsearch == 1 then
    vim.cmd("nohlsearch")
    return ""
  end
  return "<Esc>"
end, { expr = true, desc = "Clear search highlights" })

keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>s=", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sw", "<cmd>close<CR>", { desc = "Close current split" })

keymap("n", "<C-t>", "<cmd>tabnew<CR>", opts)
keymap("n", "<C-w>", "<cmd>tabclose<CR>", opts)
keymap("n", "<Tab>", "<cmd>tabn<CR>", opts)
keymap("n", "<S-Tab>", "<cmd>tabp<CR>", opts)

keymap("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tw", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap("n", "<leader>e", function()
  local MiniFiles = require("mini.files")
  local _ = MiniFiles.close()
      or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  vim.defer_fn(function()
    MiniFiles.reveal_cwd()
  end, 30)
end, { desc = "Open root directory" })

vim.keymap.del("n", "<C-W>d")
vim.keymap.del("n", "<C-W><C-D>")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    keymap(
      "n",
      "<leader>mp",
      "<cmd>MarkdownPreviewToggle<CR>",
      {
        buffer = true,
        desc = "Toggle Markdown Preview",
      }
    )
  end,
})

keymap("n", "<C-\\>", "<cmd>ToggleTerm<CR>", opts)
keymap("t", "<Esc>", "<C-\\><C-n>", opts)


-- Debugger keymaps
keymap("n", "<leader>dt", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })

-- Leader key mappings
keymap("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Continue" })
keymap("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
keymap("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
keymap("n", "<leader>du", "<cmd>DapStepOut<CR>", { desc = "Step Out" })

-- Function key mappings
keymap("n", "<F2>", "<cmd>DapContinue<CR>", { desc = "Continue" })
keymap("n", "<F3>", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
keymap("n", "<F4>", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
keymap("n", "<F5>", "<cmd>DapStepOut<CR>", { desc = "Step Out" })

-- dap view keymaps
keymap("n", "<leader>dv", "<cmd>DapViewToggle<CR>", { desc = "Toggle Dap View" })
keymap("n", "<leader>dq", "<cmd>DapTerminate<CR>", { desc = "Close Debug Session" })
keymap("n", "<leader>dw", "<cmd>DapViewWatch<CR>", { desc = "Dap Watch" })
keymap("n", "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Dap Hover" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-float",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<CR>", { noremap = true, silent = true })
  end
})


-- tmux navigation
local function smart_move(direction, tmux_cmd)
  local curwin = vim.api.nvim_get_current_win()
  vim.cmd('wincmd ' .. direction)
  if curwin == vim.api.nvim_get_current_win() then
    vim.fn.system('tmux select-pane ' .. tmux_cmd)
  end
end

keymap('n', '<C-h>', function() smart_move('h', '-L') end, { silent = true })
keymap('n', '<C-j>', function() smart_move('j', '-D') end, { silent = true })
keymap('n', '<C-k>', function() smart_move('k', '-U') end, { silent = true })
keymap('n', '<C-l>', function() smart_move('l', '-R') end, { silent = true })
