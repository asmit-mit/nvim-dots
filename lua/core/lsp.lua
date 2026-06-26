local opts = { noremap = true, silent = true }

vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  signs = false,
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
    keymap("n", "<leader>lf", function() require("conform").format({ async = true }) end,
      vim.tbl_extend("force", opts, { desc = "Format buffer" }))
    keymap("n", "<leader>lq", vim.diagnostic.setqflist, vim.tbl_extend("force", opts, { desc = "Diagnostics to quickfix" }))

    keymap("n", "<leader>lx", function()
      local bufnr = vim.api.nvim_get_current_buf()
      if vim.diagnostic.is_enabled({ bufnr = bufnr }) then
        vim.diagnostic.enable(false, { bufnr = bufnr })
      else
        vim.diagnostic.enable(true, { bufnr = bufnr })
      end
    end, vim.tbl_extend("force", opts, { desc = "Toggle diagnostics" }))

    keymap("n", "<leader>lv", function()
      local cfg = vim.diagnostic.config()

      if cfg.virtual_text then
        vim.diagnostic.config({ virtual_text = false })
      else
        vim.diagnostic.config({ virtual_text = true })
      end
    end, vim.tbl_extend("force", opts, { desc = "Toggle virtual lines" }))

    keymap("n", "<leader>lk", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))
    keymap("n", "<leader>ln", function() vim.diagnostic.jump({ count = 1, float = true }) end,
      vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))
    keymap("n", "<leader>lp", function() vim.diagnostic.jump({ count = -1, float = true }) end,
      vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
  end,
})

vim.lsp.config('basedpyright', {
  settings = {
    analysis = {
      typechecking = "off"
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
  "basedpyright",  -- basedpyright
  "rust_analyzer", -- rust-analyzer
  "mesonlsp",      -- mesonlsp
  "djls",          -- django-language-server
  "ts_ls",         -- typescript_language_server
  "cmake",         -- cmake-language-server
})
