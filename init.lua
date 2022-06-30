-- OPTIONS
vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.mousemodel = "popup"
vim.cmd("set shortmess+=c")
vim.opt.guifont = "FiraCode NF:h11"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 2
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 1
vim.opt.fillchars = "fold: "
vim.opt.fillchars = "eob: "

vim.opt.number = true
vim.opt.showcmd = true
vim.opt.cursorline = false
vim.opt.wildmenu = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.hidden = true
vim.opt.completeopt = "menuone,noinsert,noselect"

vim.g.coq_settings = { auto_start = "shut-up", keymap = { recommended = false } }

-- Autoformat on save
vim.api.nvim_command([[autocmd BufWritePre * lua vim.lsp.buf.formatting_seq_sync()]])

-- Spell-check markdown files
-- vim.api.nvim_command([[autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us]])

vim.cmd([[packadd packer.nvim]])
-- Auto compile when there are changes in plugins.lua
vim.cmd("autocmd BufWritePost plugins.lua PackerCompile")

-- KEYBINDS
require("keybinds")

-- PLUGINS
require("plugins")
require("configuration")

-- THEMING
vim.opt.background = "dark"
vim.g.vscode_style = "dark"
vim.g.material_style = "darker"
vim.g.sonokai_style = "shusia"
vim.g.sonokai_disable_italic_comment = 1

vim.cmd("colorscheme gruvbox")
