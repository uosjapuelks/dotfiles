vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- ====================================
-- increment/decrement numbers
-- ====================================
keymap.set("n", "<leader>k", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>j", "<C-x>", { desc = "Decrement number" }) -- decrement

-- ====================================
-- window management
-- ====================================
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- ====================================
-- Debugger -> dap
-- ====================================
keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>")
keymap.set("n", "<leader>dn", "<cmd>DapStepOver<cr>")
keymap.set("n", "<leader>di", "<cmd>DapStepInto<cr>")
keymap.set("n", "<leader>do", "<cmd>DapStepOut<cr>")
keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>") -- Add breakpoint at line
keymap.set("n", "<leader>dr", "<cmd>DapContinue<cr>") -- Start or Continue debugger
keymap.set("n", "<leader>dt", "<cmd>DapTerminate<cr>") -- Terminate debugger

-- ====================================
-- nvim-ros2 keymaps
-- ====================================
keymap.set("n", "<leader>li", ":Telescope ros2 interfaces<CR>", { desc = "[ROS 2]: List interfaces" })
keymap.set("n", "<leader>ln", ":Telescope ros2 nodes<CR>", { desc = "[ROS 2]: List nodes" })
keymap.set("n", "<leader>la", ":Telescope ros2 actions<CR>", { desc = "[ROS 2]: List actions" })
keymap.set("n", "<leader>lt", ":Telescope ros2 topics<CR>", { desc = "[ROS 2]: List topics" })
keymap.set("n", "<leader>ls", ":Telescope ros2 services<CR>", { desc = "[ROS 2]: List services" })
