-- treat hip filetype as cpp
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.hip",
  command = "set filetype=cpp",
})

vim.treesitter.language.register("cpp", "hip")
