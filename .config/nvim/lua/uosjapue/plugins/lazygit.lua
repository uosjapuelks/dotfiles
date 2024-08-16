vim.g.mapleader = " "
local status, lazygit = pcall(require, "lazygit")
if not status then
  return
end

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>")
