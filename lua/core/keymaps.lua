local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Esc>", function()
  if vim.v.hlsearch == 1 then
    vim.cmd("nohlsearch")
    return ""
  end
  return "<Esc>"
end, { expr = true, desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>s=", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sw", "<cmd>close<CR>", { desc = "Close current split" })

vim.keymap.set("n", "<C-t>", "<cmd>tabnew<CR>", opts)
vim.keymap.set("n", "<C-w>", "<cmd>tabclose<CR>", opts)
vim.keymap.set("n", "<Tab>", "<cmd>tabn<CR>", opts)
vim.keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", opts)

vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tw", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", opts)

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", function()
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
    vim.keymap.set(
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

vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<CR>", opts)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)


-- Debugger keymaps
vim.keymap.set("n", "<leader>dt", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })

-- Leader key mappings
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Continue" })
vim.keymap.set("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<leader>du", "<cmd>DapStepOut<CR>", { desc = "Step Out" })

-- Function key mappings
vim.keymap.set("n", "<F2>", "<cmd>DapContinue<CR>", { desc = "Continue" })
vim.keymap.set("n", "<F3>", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
vim.keymap.set("n", "<F4>", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<F5>", "<cmd>DapStepOut<CR>", { desc = "Step Out" })

-- dap view keymaps
vim.keymap.set("n", "<leader>dv", "<cmd>DapViewToggle<CR>", { desc = "Toggle Dap View" })
vim.keymap.set("n", "<leader>dq", "<cmd>DapTerminate<CR>", { desc = "Close Debug Session" })
vim.keymap.set("n", "<leader>dw", "<cmd>DapViewWatch<CR>", { desc = "Dap Watch" })
vim.keymap.set("n", "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Dap Hover" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-float",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<CR>", { noremap = true, silent = true })
  end
})
