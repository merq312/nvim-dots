-- OPTIONS
vim.opt.termguicolors = true
vim.opt.encoding = 'utf-8'
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'popup'
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
vim.opt.fillchars = 'fold: '
vim.opt.fillchars = 'eob: '

vim.opt.number = true
vim.opt.showcmd = true
vim.opt.cursorline = false
vim.opt.wildmenu = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.hidden = true

vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.guifont = 'FiraCode NF:h9'

vim.g.coq_settings = { auto_start = true, keymap = { recommended = false } }

-- Autoformat on save
vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

vim.cmd [[packadd packer.nvim]]
-- Auto compile when there are changes in plugins.lua
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

-- KEYBINDS
require'keybinds'

-- PLUGINS
require'plugins'
require'configuration'

-- STATUSLINE
require'eviline'

-- THEMING
local theme = 'dark'
vim.opt.background = theme
vim.g.vscode_style = theme

vim.g.material_style = 'darker'
vim.cmd 'colorscheme material'
