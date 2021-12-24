local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Save buffer
map("n", "<Space><Space>", "<cmd>w<CR>")

-- Close buffer
map("n", "<C-d>", "<cmd>bd<CR>")

-- Disable some defaults
map("n", "<S-up>", "k")
map("n", "<S-down>", "j")
map("v", "<S-up>", "k")
map("v", "<S-down>", "j")
map("i", "<S-up>", "k")
map("i", "<S-down>", "j")

-- Scroll paragraph
map("n", "J", "}")
map("n", "K", "{")
map("v", "J", "}")
map("v", "K", "{")

-- Scroll page
map("n", "<C-k>", "<C-y>")
map("n", "<C-j>", "<C-e>")

-- Disable macros
map("n", "q", "b")
map("n", "Q", "B")

-- Better indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- No search highlight
map("n", "<Esc>", "<cmd>noh<CR>")

-- exit terminal mode
vim.cmd("tnoremap <Esc> <C-\\><C-n>")

-- lightspeed
vim.cmd("nmap ,s <Plug>Lightspeed_S")
vim.cmd("nmap .s <Plug>Lightspeed_s")
vim.cmd("vmap ,s <Plug>Lightspeed_S")
vim.cmd("vmap .s <Plug>Lightspeed_s")

-- nvim_bufferline
map("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>")
map("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>")
map("n", "<A-<>", "<cmd>BufferLineMovePrev<CR>")
map("n", "<A->>", "<cmd>BufferLineMoveNext<CR>")

-- Nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")

-- Telescope
-- map('n', 'fn', '<cmd>Telescope keymaps<cr>')
map("n", "<leader>f", "<cmd>Telescope find_files<cr>")
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>b", "<cmd>Telescope buffers<cr>")
map("n", "<leader>o", "<cmd>Telescope oldfiles<cr>")

-- map('n', 'ft', '<cmd>Telescope tags<cr>') -- ctags
map("n", "<leader>t", "<cmd>Telescope treesitter<cr>")

-- show git diffs
map("n", "gs", "<cmd>Telescope git_status<cr>")

-- go-to definition
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>")

-- hover
map("n", "L", "<cmd>lua vim.lsp.buf.hover()<CR>")

-- jump diagnostics
map("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")

-- code action
map("n", "<leader>ca", "<cmd>CodeActionMenu<CR>")
