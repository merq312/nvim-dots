return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

  use {'famiu/feline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

  use {'ms-jpq/coq_nvim', branch = 'coq'}
  use {'ms-jpq/coq.artifacts', branch = 'artifacts'}

  use {'ms-jpq/coq.thirdparty', branch = '3p'}

  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

	use {
	  'nvim-telescope/telescope.nvim',
	  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use {
    'neovim/nvim-lspconfig',
    config = function() require'bufferline'.setup{
      -- options = {
      --   separator_style = "slant",
      -- }
    } end
  }

  use {
    'glepnir/lspsaga.nvim',
    config = function() require'lspsaga'.init_lsp_saga() end
  }

  use {
    'akinsho/toggleterm.nvim',
    config = function() require'toggleterm'.setup{
      size = 20,
      open_mapping = [[<c-p>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 1,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = 'horizontal',
      close_on_exit = true,
      shell = 'pwsh.exe',
    } end
  }

  use 'windwp/nvim-autopairs'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'b3nj5m1n/kommentary'
  use 'p00f/nvim-ts-rainbow'
  use 'onsails/lspkind-nvim'

  -- COLORSCHEMES
  use 'navarasu/onedark.nvim'
  use 'tomasiser/vim-code-dark'

  use {
    'Pocco81/Catppuccino.nvim',
    config = function() require'catppuccino'.setup{
      colorscheme = "dark_catppuccino",
      transparency = false,
      styles = {
        comments = "NONE",
        functions = "underline",
        keywords = "italic",
        strings = "NONE",
        variables = "NONE",
      },
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = "italic",
            hints = "italic",
            warnings = "italic",
            information = "italic",
          },
          underlines = {
            errors = "underline",
            hints = "underline",
            warnings = "underline",
            information = "underline",
          }
        },
        lsp_trouble = false,
        lsp_saga = true,
        gitgutter = false,
        gitsigns = true,
        telescope = true,
        nvimtree = {
          enabled = true,
          show_root = true,
        },
        indent_blankline = {
          enabled = false,
          colored_indent_levels = false,
        },
        which_key = false,
        dashboard = false,
        neogit = false,
        vim_sneak = false,
        fern = false,
        barbar = false,
        bufferline = true,
        markdown = false,
        ts_rainbow = true,
      }
    } end
  }

  use {'ellisonleao/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
  use 'merq312/github-nvim-theme'

end)
