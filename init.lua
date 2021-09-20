-- OPTIONS
vim.opt.termguicolors = true
vim.cmd 'set clipboard=unnamedplus'
vim.cmd 'set mouse=a'
vim.cmd 'set encoding=utf-8'
-- vim.cmd 'set shell=pwsh.exe'
vim.cmd 'set shortmess+=c'

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.foldmethod = 'indent'
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 2

vim.opt.number = true
vim.opt.showcmd = true
vim.opt.cursorline = false
vim.opt.wildmenu = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.hidden = true

vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.guifont = 'FiraMono NF'

-- Autoformat on save
vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

vim.cmd [[packadd packer.nvim]]
-- Auto compile when there are changes in plugins.lua
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

-- KEYBINDS
require'keybinds'

-- PLUGINS
require'plugins'
require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.rust_analyzer.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.ccls.setup{on_attach=require'completion'.on_attach}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  }
}

require('telescope').setup{
  defaults = {
    layout_strategy = "vertical",
  }
}

require("indent_blankline").setup {
    char = "⋅",
    buftype_exclude = {"terminal"},
}

require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})

require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {}, -- table of hex strings
    termcolors = {} -- table of colour name strings
  }
}

require('lspkind').init({})

require('feline').setup()

require('nvim-autopairs').setup({})

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      require'completion'.confirmCompletion()
      return npairs.esc("<c-y>")
    else
      vim.api.nvim_select_popupmenu_item(0 , false , false ,{})
      require'completion'.confirmCompletion()
      return npairs.esc("<c-n><c-y>")
    end
  else
    return npairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

vim.cmd 'colorscheme github_dark_default'
