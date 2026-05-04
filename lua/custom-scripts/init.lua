local M = {}

local function load_modules()
  local path = vim.fn.stdpath("config") .. "/lua/custom-scripts"
  local files = vim.fn.readdir(path)

  table.sort(files)

  for _, file in ipairs(files) do
    if file ~= "init.lua" and file:match("%.lua$") then
      local module = "custom-scripts." .. file:gsub("%.lua$", "")
      require(module)
    end
  end
end

load_modules()

return M
