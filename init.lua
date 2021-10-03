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
vim.opt.fillchars='fold: '

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
local nvim_lsp = require'lspconfig'
local servers = { 'tsserver', 'rust_analyzer', 'ccls' }
local coq = require('coq')

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {coq.lsp_ensure_capabilities()}
end

require('rust-tools').setup({})

require'nvim-treesitter.configs'.setup{
  highlight = {
    enable = true,
  },
  autopairs = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {}, -- table of hex strings
    termcolors = {} -- table of colour name strings
  }
}

require('telescope').setup{
  defaults = {
    layout_strategy = "vertical",
  }
}

require("indent_blankline").setup{
  char = "⋅",
  buftype_exclude = {"terminal"},
}

require('kommentary.config').configure_language("default",{
  prefer_single_line_comments = true,
})

require'nvim-tree'.setup{
  auto_close = true,
  lsp_diagnostics = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    side = 'right',
    auto_resize = true,
  }
}

require('lspkind').init({})

require('feline').setup({
  preset = 'noicon',
  colors = {
-- VSCODE LIGHT
    -- fg = '#343434',
    -- bg = '#FFFFFF',
    -- black = '#343434',
    -- white = '#FFFFFF',
    -- oceanblue = '#03589C',
    -- skyblue = '#ADD6FF',
-- VSCODE DARK
    fg = '#D4D4D4',
    bg = '#1E1E1E',
    oceanblue = '#264F78',
    skyblue = '#264F78',
-- GRUVBOX
    -- black = '#1D2021',
    -- fg = '#EBDBB2',
    -- bg = '#3B3735',
    -- black = '#1D2021',
    -- white = '#EBDBB2',
    -- cyan = '#8EC07C',
    -- skyblue = '#83A598',
    -- oceanblue = '#458588',
    -- red = '#FB4934',
    -- orange = '#FE8019',
    -- yellow = '#FABD2F',
    -- green = '#B8BB26',
  }
})

require('nvim-autopairs').setup({})

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false })

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

local catppuccino = require'catppuccino'.setup({
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
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = true,
    },
    indent_blankline = {
      enabled = true,
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

local theme = 'dark'
vim.opt.background = theme
vim.g.vscode_style = theme
vim.cmd 'colorscheme vscode'
