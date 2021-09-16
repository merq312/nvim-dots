local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

opt.termguicolors = true
cmd 'set clipboard=unnamedplus'
cmd 'set mouse=a'
cmd 'set encoding=utf-8'
-- cmd 'set shell=pwsh.exe'
cmd 'set shortmess+=c'

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true

opt.number = true
opt.showcmd = true
opt.cursorline = false
opt.wildmenu = true
opt.breakindent = true
opt.linebreak = true
opt.hidden = true

opt.completeopt = 'menuone,noinsert,noselect'
opt.guifont = 'FiraMono NF' -- for Neovide

-- Autoformat on save
vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

cmd [[packadd packer.nvim]]
-- Auto compile when there are changes in plugins.lua
cmd 'autocmd BufWritePost plugins.lua PackerCompile'

-- KEYMAPPINGS
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Save buffer
map('n', '<Space><Space>', '<cmd>w<CR>')

-- Disable some defaults
map('n', '<S-up>', 'k')
map('n', '<S-down>', 'j')
map('v', '<S-up>', 'k')
map('v', '<S-down>', 'j')
map('i', '<S-up>', 'k')
map('i', '<S-down>', 'j')

-- Scroll paragraph
map('n', 'J', '}')
map('n', 'K', '{')

-- Scroll page
map('n', '<C-k>', '<C-y>')
map('n', '<C-j>', '<C-e>')

-- Disable macros
map('n', 'q', 'b')
map('n', 'Q', 'B')

-- Better indent
map('v', '<', '<gv')
map('v', '>', '>gv')

-- No search highlight
map('n', '<Esc>', '<cmd>noh<CR>')

-- exit terminal mode
cmd 'tnoremap <Esc> <C-\\><C-n>'

-- Nvimtree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')

-- completion
cmd 'inoremap <expr> <Tab>   pumvisible() ? "<C-n>" : "<Tab>"'
cmd 'inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"'

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>rg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

-- nvim_bufferline
map('n', '<A-,>', '<cmd>BufferLineCyclePrev<CR>')
map('n', '<A-.>', '<cmd>BufferLineCycleNext<CR>')
map('n', '<A-<>', '<cmd>BufferLineMovePrev<CR>')
map('n', '<A->>', '<cmd>BufferLineMoveNext<CR>')

-- finder
map('n', 'gh', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", {silent = true})

-- code action
map('n', '<leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", {silent = true})
map('v', '<leader>ca', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", {silent = true})

-- hover doc
map('n', 'L', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", {silent = true})
map('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {silent = true})
map('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {silent = true})

-- signature help
map('n', 'gs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", {silent = true})

-- rename
map('n', 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>", {silent = true})

-- preview definition
map('n', 'gd', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", {silent = true})

-- show diagnostics
map('n', '<leader>cd', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", {silent = true})
map('n', '<leader>cc', "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>", {silent = true})

-- jump diagnostic
map('n', '[g', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", {silent = true})
map('n', ']g', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", {silent = true})

-- float term
map('n', '<A-d>', "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>", {silent = true})
map('t', '<A-d>', "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>", {silent = true})

-- PLUGIN CONFIGURATION
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

require('nvim-autopairs').setup({})

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
      return npairs.esc("<cr>")
  else
    return npairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

require("toggleterm").setup({
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<c-p>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = 'pwsh.exe', -- change the default shell
})

local catppuccino = require("catppuccino")

catppuccino.setup({
  colorscheme = "soft_manilo",
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
})

-- catppuccino.load()

opt.background = "dark"
cmd 'colorscheme gruvbox'
