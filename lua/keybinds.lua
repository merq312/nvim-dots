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
vim.cmd 'tnoremap <Esc> <C-\\><C-n>'

-- Nvimtree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')

-- completion
vim.cmd 'inoremap <expr> <Tab>   pumvisible() ? "<C-n>" : "<Tab>"'
vim.cmd 'inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"'

-- Telescope
map('n', 'ff', '<cmd>Telescope find_files<cr>')
map('n', 'fg', '<cmd>Telescope live_grep<cr>')
map('n', 'fb', '<cmd>Telescope buffers<cr>')
map('n', 'fh', '<cmd>Telescope help_tags<cr>')

-- nvim_bufferline
map('n', '<A-,>', '<cmd>BufferLineCyclePrev<CR>')
map('n', '<A-.>', '<cmd>BufferLineCycleNext<CR>')
map('n', '<A-<>', '<cmd>BufferLineMovePrev<CR>')
map('n', '<A->>', '<cmd>BufferLineMoveNext<CR>')

-- go-to definition
map('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", {silent = true})
map('n', 'gD', "<cmd>lua vim.lsp.buf.declaration()<CR>", {silent = true})

-- go-to implementation
map('n', 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", {silent = true})

-- hover
map('n', 'L', "<cmd>lua vim.lsp.buf.hover()<CR>", {silent = true})

-- finder
map('n', 'gh', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", {silent = true})

-- code action
map('n', '<leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", {silent = true})
map('v', '<leader>ca', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", {silent = true})

-- hover doc
-- map('n', 'L', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", {silent = true})
map('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {silent = true})
map('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {silent = true})

-- signature help
map('n', 'gs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", {silent = true})

-- rename
map('n', 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>", {silent = true})

-- preview definition
-- map('n', 'gd', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", {silent = true})

-- show diagnostics
map('n', '<leader>cd', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", {silent = true})
map('n', '<leader>cc', "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>", {silent = true})

-- jump diagnostic
map('n', '[g', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", {silent = true})
map('n', ']g', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", {silent = true})

-- float term
map('n', '<A-d>', "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>", {silent = true})
map('t', '<A-d>', "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>", {silent = true})
