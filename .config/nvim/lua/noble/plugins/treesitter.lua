return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")
		vim.defer_fn(function()
			---@diagnostic disable-next-line: missing-fields
			treesitter.setup({
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"csv",
					"dockerfile",
					"gitcommit",
					"gitignore",
					"go",
					"html",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
				},
				-- Autoinstall languages not installed. Defaults to false
				auto_install = true,
				highlight = {
					enable = true,
					disable = function(lang, bufnr) -- Disable in large files
						return vim.api.nvim_buf_line_count(bufnr) > 50000
					end,
					additional_vim_regex_highlighting = false,
				},

				indent = { enable = true, disable = { "python", "cpp" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end, 0)
	end,
}
