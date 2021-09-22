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
vim.opt.foldenable = false
vim.opt.foldlevel = 2
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 1
vim.opt.fillchars='fold: '

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

vim.g.coq_settings = {
  auto_start = true,
}

-- PLUGINS
require'plugins'
local lsp = require'lspconfig'
local coq = require('coq')

lsp.tsserver.setup{coq.lsp_ensure_capabilities()}
lsp.rust_analyzer.setup{coq.lsp_ensure_capabilities()}
lsp.ccls.setup{coq.lsp_ensure_capabilities()}

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

require('feline').setup({
  preset = 'noicon',
  colors = {
    fg = '#EBDBB2',
    bg = '#3B3735',
    black = '#1D2021',
    white = '#EBDBB2',
    cyan = '#8EC07C',
    skyblue = '#83A598',
    oceanblue = '#458588',
    red = '#FB4934',
    orange = '#FE8019',
    yellow = '#FABD2F',
    green = '#B8BB26',
  }
})

require('nvim-autopairs').setup({})

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      -- you can change <c-g><c-g> to <c-e> if you don't use other i_CTRL-X modes
      return npairs.esc('<c-g><c-g>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

vim.opt.background = 'dark'
vim.cmd 'colorscheme gruvbox'
