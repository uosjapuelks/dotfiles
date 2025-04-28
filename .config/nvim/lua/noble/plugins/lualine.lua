return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				icons_enabled = true,
				component_separators = "",
				section_separators = { left = "", right = "" },
				-- theme = my_lualine_theme,
				-- theme = "gruvbox_light",
				-- theme = "gruvbox_dark",
				-- theme = "gruvbox",
				theme = "auto",
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{
						function()
							local status = require("codeium.virtual_text").status()
							if status.state == "idle" then
								return "♿︎"
							end
							if status.state == "waiting" then
								return "⏲ waiting... "
							end
							if status.state == "completions" and status.total > 0 then
								return string.format("✆ %d/%d", status.current, status.total)
							end
							return " 0 "
						end,
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})

		require("codeium.virtual_text").set_statusbar_refresh(function()
			require("lualine").refresh()
		end)
	end,
}

-- local colors = {
-- 	blue = "#65D1FF",
-- 	green = "#3EFFDC",
-- 	violet = "#FF61EF",
-- 	yellow = "#FFDA7B",
-- 	red = "#FF4A4A",
-- 	fg = "#c3ccdc",
-- 	bg = "#112638",
-- 	inactive_bg = "#2c3043",
-- }

-- local my_lualine_theme = {
-- 	normal = {
-- 		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
-- 		b = { bg = colors.bg, fg = colors.fg },
-- 		c = { bg = colors.bg, fg = colors.fg },
-- 	},
-- 	insert = {
-- 		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
-- 		b = { bg = colors.bg, fg = colors.fg },
-- 		c = { bg = colors.bg, fg = colors.fg },
-- 	},
-- 	visual = {
-- 		a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
-- 		b = { bg = colors.bg, fg = colors.fg },
-- 		c = { bg = colors.bg, fg = colors.fg },
-- 	},
-- 	command = {
-- 		a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
-- 		b = { bg = colors.bg, fg = colors.fg },
-- 		c = { bg = colors.bg, fg = colors.fg },
-- 	},
-- 	replace = {
-- 		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
-- 		b = { bg = colors.bg, fg = colors.fg },
-- 		c = { bg = colors.bg, fg = colors.fg },
-- 	},
-- 	inactive = {
-- 		a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
-- 		b = { bg = colors.inactive_bg, fg = colors.semilightgray },
-- 		c = { bg = colors.inactive_bg, fg = colors.semilightgray },
-- 	},
-- }
