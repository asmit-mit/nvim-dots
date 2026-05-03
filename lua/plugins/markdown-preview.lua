vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/iamcco/markdown-preview.nvim" })
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
  end,
})
