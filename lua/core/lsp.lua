local opts = { noremap = true, silent = true }

vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    local keymap = vim.keymap.set

    keymap("n", "<leader>ld", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    keymap("n", "<leader>lD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    keymap("n", "<leader>lR", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "List references" }))
    keymap("n", "<leader>ly", vim.lsp.buf.type_definition,
      vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
    keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover information" }))
    keymap("n", "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Show code actions" }))
    keymap("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    keymap("n", "<leader>lf", vim.lsp.buf.format, vim.tbl_extend("force", opts, { desc = "Format Buffer" }))

    keymap("n", "<leader>lk", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))
    keymap("n", "<leader>ln", function() vim.diagnostic.jump({ count = 1, float = true }) end,
      vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))
    keymap("n", "<leader>lp", function() vim.diagnostic.jump({ count = -1, float = true }) end,
      vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
  end,
})

vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'E501' },
        }
      }
    }
  }
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
})

vim.lsp.enable({
  "clangd",        -- clangd
  "cssls",         -- css-lsp
  "emmet_ls",      -- emmet-ls
  "html",          -- html-lsp
  "lua_ls",        -- lua-language-server
  "marksman",      -- marksman
  "pylsp",         -- python-lsp-server
  "rust_analyzer", -- rust-analyzer
  "mesonlsp",      -- mesonlsp
  "djls",          -- django-language-server
  "ts_ls",         -- typescript_language_server
  "cmake",         -- cmake-language-server
})
