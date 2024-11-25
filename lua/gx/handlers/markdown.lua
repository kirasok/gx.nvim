local helper = require("gx.helper")

---@type GxHandler
local M = {
  -- every filetype and filename
  name = "markdown",
  filetype = { "markdown" },
  filename = nil,
}

-- navigate to neovim github plugin url
function M.handle(mode, line, _)
  local pattern = "!?%[[%a%d%s.,?!:;@_{}~]*%]%((https?://[a-zA-Z0-9_/%-%.~@\\+#=?&]+)%)"
  local url = helper.find(line, mode, pattern)
  if url then
    return url
  end

  pattern = "!?%[[%a%d%s.,?!:;@_{}~]*%]%((.+)%)"
  url = helper.find(line, mode, pattern)
  if not url then
    return
  end
  local buf_path = vim.api.nvim_buf_get_name(0)
  local _, _, folder = buf_path:find("(.+/).*%.md")
  return folder .. url
end

return M
