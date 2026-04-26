local M = {}

local function load_modules()
  local path = vim.fn.stdpath("config") .. "/lua/plugins"
  local files = vim.fn.readdir(path)

  table.sort(files)

  for _, file in ipairs(files) do
    if file ~= "init.lua" and file:match("%.lua$") then
      local module = "plugins." .. file:gsub("%.lua$", "")
      require(module)
    end
  end
end

load_modules()

return M
