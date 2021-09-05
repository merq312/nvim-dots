local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

opt.termguicolors = true
cmd 'set clipboard=unnamedplus'
cmd 'set mouse=a'
cmd 'set encoding=utf-8'

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true

opt.number = true
opt.showcmd = true
-- opt.cursorline = true
opt.wildmenu = true
opt.breakindent = true
opt.linebreak = true

-- cmd 'colorscheme catppuccino'

opt.completeopt = 'menuone,noselect'
opt.guifont = 'BlexMono NF'

vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

cmd [[packadd packer.nvim]]
cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

map('n', '<Space><Space>', '<cmd>w<CR>')

map('n', '<S-up>', 'k')
map('n', '<S-down>', 'j')
map('v', '<S-up>', 'k')
map('v', '<S-down>', 'j')
map('i', '<S-up>', 'k')
map('i', '<S-down>', 'j')

map('n', 'J', '5j')
map('n', 'K', '5k')

map('n', '<C-k>', '<C-y>')
map('n', '<C-j>', '<C-e>')

map('n', 'q', 'b')
map('n', 'Q', 'B')

map('v', '<', '<gv')
map('v', '>', '>gv')

map('n', '<Esc>', '<cmd>noh<CR>')

map('n', '<A-,>', '<cmd>BufferLineCyclePrev<CR>')
map('n', '<A-.>', '<cmd>BufferLineCycleNext<CR>')
map('n', '<A-<>', '<cmd>BufferLineMovePrev<CR>')
map('n', '<A->>', '<cmd>BufferLineMoveNext<CR>')

map('i', '<C-Space>', 'compe#complete()', {expr = true, silent = true})
-- map('i', '<CR>', "compe#confirm('<CR>')", {expr = true, silent = true})
map('i', '<C-e>', "compe#close('<C-e>')", {expr = true, silent = true})
map('i', '<C-f>', "compe#scroll({ 'delta': +4 })", {expr = true, silent = true})
map('i', '<C-d>', "compe#scroll({ 'delta': -4 })", {expr = true, silent = true})

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

require'plugins'
require'lspconfig'.tsserver.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.ccls.setup{}

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

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = '~/org/*',
  org_default_notes_file = '~/org/refile.org',
})

require('lspkind').init({})

local catppuccino = require("catppuccino")

catppuccino.setup({
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
    which_key = false,
    indent_blankline = true,
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

catppuccino.load()
