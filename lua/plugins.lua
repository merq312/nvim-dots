return require("packer").startup(function()
	use("wbthomason/packer.nvim")

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })

	use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" })

	use({ "ms-jpq/coq_nvim", branch = "coq" })
	use({ "ms-jpq/coq.artifacts", branch = "artifacts" })
	use({ "ms-jpq/coq.thirdparty", branch = "3p" })

	use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" })

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
	})

	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})

	use("neovim/nvim-lspconfig")

	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	})

	use("akinsho/toggleterm.nvim")
	use("ggandor/lightspeed.nvim")
	use("tpope/vim-surround")
	use("mattn/emmet-vim")
	use("sindrets/diffview.nvim")

	use({
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		requires = { { "neovim/nvim-lspconfig" }, { "nvim-lua/plenary.nvim" }, { "jose-elias-alvarez/null-ls.nvim" } },
	})

	use({
		"simrat39/rust-tools.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})

	use("windwp/nvim-autopairs")
	use("lukas-reineke/indent-blankline.nvim")
	use("b3nj5m1n/kommentary")
	use("p00f/nvim-ts-rainbow")
	use("onsails/lspkind-nvim")
	use("yamatsum/nvim-cursorline")
	use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })
	use("vimwiki/vimwiki")
	use("github/copilot.vim")

	-- COLORSCHEMES
	use("rktjmp/lush.nvim")
	use("folke/lsp-colors.nvim")

	use("Mofiqul/vscode.nvim")
	use("ellisonleao/gruvbox.nvim")
	use("marko-cerovac/material.nvim")
	use("rebelot/kanagawa.nvim")
end)
