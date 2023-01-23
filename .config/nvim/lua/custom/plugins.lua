return function(use)
	use("jose-elias-alvarez/null-ls.nvim")
	use("windwp/nvim-autopairs")
	use("stevearc/dressing.nvim")
	use("rafamadriz/friendly-snippets")
	use("hrsh7th/cmp-buffer")
	use("onsails/lspkind.nvim")
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})
	use("lewis6991/impatient.nvim")
	use("hrsh7th/cmp-cmdline")
	use("NvChad/nvim-colorizer.lua")
	use("hrsh7th/cmp-path")
	use("folke/tokyonight.nvim")
	use("ray-x/lsp_signature.nvim")
	use("phha/zenburn.nvim")
	use("Mofiqul/adwaita.nvim")
	use("loctvl842/monokai-pro.nvim")
end
