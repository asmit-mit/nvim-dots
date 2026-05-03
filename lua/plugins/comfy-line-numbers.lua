vim.pack.add({ "https://github.com/mluders/comfy-line-numbers.nvim" })

require('comfy-line-numbers').setup({
  up_key = 'k',
  down_key = 'j',

  hidden_file_types = { 'undotree' },
  hidden_buffer_types = { 'terminal', 'nofile' }
})
