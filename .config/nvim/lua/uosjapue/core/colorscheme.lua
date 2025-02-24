local status, _ = pcall(vim.cmd, "colorscheme kanagawa-wave")
if not status then
  print("colorscheme not found")
  return
end

-- require("kanagawa").load("wave")

-- Make BG transparent
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]
