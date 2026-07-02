--[=[return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},
}]=]
--[=[
return{
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},
}]=]
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "latte", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        integrations = {
          treesitter = true,
          telescope = true,
          cmp = true,
          gitsigns = true,
        },
           custom_highlights = function(C)
      return {
        Normal       = { bg = "#1B1B1B", fg = "#ffffff" }, -- latte is light theme
        --[=[NormalFloat  = { fg = "#000000", bg = "#ffffff" },
        CursorLine   = { bg = "#eeeeee" },
        CursorLineNr = { fg = "#000000" },]=]
      }
    end,
      })

      --vim.cmd.colorscheme("catppuccin")
    end,
  },
}
--[=[
return {
  {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}
}]=]
