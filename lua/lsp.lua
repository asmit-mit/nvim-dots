vim.lsp.enable({
  "clangd",
  "cmake",
  "cssls",
  "emmet_ls",
  "html",
  "jsonls",
  "lemminx",
  "lua_ls",
  "marksman",
  "pylsp",
  "rust_analyzer",
  "ts_ls",
  "vimls",
  "yamlls",
})

local opts = { noremap = true, silent = true }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    local keymap = vim.keymap.set

    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        prefix = "●",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))

    keymap("n", "gD", function() vim.lsp.buf.declaration() end,
      vim.tbl_extend("force", opts, { desc = "Go to declaration" }))

    keymap("n", "gy", function() Snacks.picker.lsp_type_definitions() end,
      vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

    keymap("n", "gS", function() Snacks.picker.lsp_symbols() end,
      vim.tbl_extend("force", opts, { desc = "List symbols" }))

    keymap("n", "gr", function() Snacks.picker.lsp_references() end,
      vim.tbl_extend("force", opts, { desc = "List references" }))

    keymap("n", "gI", function() Snacks.picker.lsp_implementations() end,
      vim.tbl_extend("force", opts, { desc = "Go to implementation" }))

    keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover information" }))

    keymap("n", "<leader>la", function() vim.lsp.buf.code_action() end,
      vim.tbl_extend("force", opts, { desc = "Show code actions" }))

    keymap("n", "<leader>lr", function() vim.lsp.buf.rename() end,
      vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

    keymap("n", "<leader>lk", function() vim.diagnostic.open_float() end,
      vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))

    keymap("n", "<leader>ln", function() vim.diagnostic.goto_next() end,
      vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))

    keymap("n", "<leader>lp", function() vim.diagnostic.goto_prev() end,
      vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))

    keymap("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format Buffer" })
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
