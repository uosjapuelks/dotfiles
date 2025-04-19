return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"Exafunction/windsurf.nvim", -- Codeium AI
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		local codeium_ok, codeium = pcall(require, "codeium")
		codeium.setup({
			enable_cmp_source = false,
			virtual_text = {
				enabled = true,
				filetypes = {
					markdown = false,
					yaml = false,
					json = false,
					xml = false,
				},
				default_filetype_enabled = true,

				-- Set to true if never want completions shown automatically
				manual = true,
				idle_delay = 75, -- (ms)

				map_keys = true,
				key_bindings = {
					accept = "<C-Enter>",
					accept_word = "<C-'>",
					accept_line = "<C-;>",
					next = "<C-Down>",
					prev = "<C-Up>",
				},
			},
		})

		require("lazy").load({ plugins = { "windsurf.nvim" } })
		vim.keymap.set("i", "<F5>", function()
			local trigger_ai = function()
				-- trigger_ai
				require("codeium.virtual_text").cycle_or_complete()
			end
			trigger_ai()
		end, { silent = true, expr = true })

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
				{ name = "codeium" }, -- Codeium AI
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					maxwidth = 50,
					ellipsis_char = "...",
					symbol_map = { Codeium = "☻ " },
				}),
			},
		})
	end,
}
