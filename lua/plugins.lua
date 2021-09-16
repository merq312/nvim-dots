-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

  use {
    'glepnir/galaxyline.nvim',
      branch = 'main',
      -- your statusline
      config = function() require'statusline' end,
      -- some optional icons
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use 'nvim-lua/completion-nvim'

  -- Use dependency and run lua function after load
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
    config = function() require'bufferline'.setup{} end
  }

  use {
    'glepnir/lspsaga.nvim',
    config = function() require'lspsaga'.init_lsp_saga() end
  }

  use {
    'Pocco81/TrueZen.nvim',
    config = function()
      require('true-zen').setup {
        misc = {
          ui_elements_commands = true,
        }
      }
    end
  }

  use {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use 'akinsho/toggleterm.nvim'
  use 'windwp/nvim-autopairs'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'b3nj5m1n/kommentary'
  use 'p00f/nvim-ts-rainbow'
  use 'onsails/lspkind-nvim'

  -- COLORSCHEMES
  use 'navarasu/onedark.nvim'
  use 'tomasiser/vim-code-dark'
  use 'Pocco81/Catppuccino.nvim'
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

end)
