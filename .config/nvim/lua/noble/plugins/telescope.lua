return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  branch = "0.1.x",
  dependencies = {
    {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      build = (build_cmd ~= "cmake") and "make"
        or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      enabled = build_cmd ~= nil,
    config = function(plugin)
      LazyVim.on_load("telescope.nvim", function()
        local telescope, err = pcall(require("telescope").load_extension, "fzf")
        if not telescope then
          local lib = plugin.dir .. "/build/libfzf." .. (LazyVim.is_win() and "dll" or "so")
          if not vim.uv.fs_stat(lib) then
            LazyVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
            require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
              LazyVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
            end)
          else
            LazyVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
          end
        end
      end)
     end,
    },
  },
  config = function()
     local telescope = require("telescope")
     local actions = require("telescope.actions")
     telescope.setup({
       defaults = {
         path_display = { "smart" },
         mappings = {
           i = {
             ["<C-k>"] = actions.move_selection_previous, -- move to prev result
             ["<C-j>"] = actions.move_selection_next, -- move to next result
             ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
           },
         },
       },
     })

    telescope.load_extension("fzf")

     -- set keymaps
     local keymap = vim.keymap -- for conciseness
 
     keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
     keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
     keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
     keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
     keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

   end,
}
-- return {
--   "nvim-telescope/telescope.nvim",
--   branch = "0.1.x",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
--     "nvim-tree/nvim-web-devicons",
--   },
--   config = function()
--   end,
-- }
