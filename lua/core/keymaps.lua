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
-- vim.keymap.set("n", "-", function()
--   require("mini.files").open()
-- end, { desc = "Open parent directory" })

vim.keymap.del("n", "<C-W>d")
vim.keymap.del("n", "<C-W><C-D>")

vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview", })

vim.keymap.set("n", "<leader>/", "<cmd>terminal<CR>", opts)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
