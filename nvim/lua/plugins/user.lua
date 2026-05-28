-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
	{
		"pocco81/auto-save.nvim"
	},
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		opts = {
			open_mapping = [[<c-t>]],
			direction = "float",
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		},
	},
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                hidden = true,
                ignored = true,
                sources = {
                    files = {
                        hidden = true,
                        ignored = true,
                        -- exclude = {
                        -- "**/.git/*",
                        -- },
                    },
                },
            },
        },
    },
    {
        "tpope/vim-surround"
    }
}
