local nvim_lsp = require("lspconfig")
local coq = require("coq")
local servers = { "rust_analyzer", "ccls", "tsserver", "volar", "pyright" }
-- local shell = "pwsh.exe -NoLogo"
local shell = "zsh"

-- if vim.loop.os_uname().sysname == "Linux" then
-- end

for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({ coq.lsp_ensure_capabilities() })
end

require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.eslint.with({
			only_local = "node_modules/.bin",
		}),
		require("null-ls").builtins.code_actions.eslint.with({
			only_local = "node_modules/.bin",
		}),
		require("null-ls").builtins.formatting.prettierd,
		require("null-ls").builtins.formatting.black,
	},
})

require("typescript").setup({})

require("rust-tools").setup({})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
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
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		colors = {}, -- table of hex strings
		termcolors = {}, -- table of colour name strings
	},
})

require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
	},
})

require("bufferline").setup({
	highlights = {
		buffer_selected = {
			bold = true,
		},
	},
})

require("lualine").setup({
	options = { section_separators = "", component_separators = "" },
})

require("gitsigns").setup()

require("indent_blankline").setup({
	char = "⋅",
	buftype_exclude = { "terminal" },
})

require("kommentary.config").configure_language("default", {
	prefer_single_line_comments = true,
})

require("nvim-tree").setup({
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	view = {
		width = 40,
		side = "right",
	},
})

require("toggleterm").setup({
	size = 20,
	open_mapping = [[<c-p>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "tab",
	close_on_exit = true,
	shell = shell,
})

require("lspkind").init({})

require("trouble").setup({})

require("nvim-autopairs").setup({})

local remap = vim.api.nvim_set_keymap
local npairs = require("nvim-autopairs")

npairs.setup({ map_bs = false })

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.CR = function()
	if vim.fn.pumvisible() ~= 0 then
		if vim.fn.complete_info({ "selected" }).selected ~= -1 then
			return npairs.esc("<c-y>")
		else
			-- you can change <c-g><c-g> to <c-e> if you don't use other i_CTRL-X modes
			return npairs.esc("<c-g><c-g>") .. npairs.autopairs_cr()
		end
	else
		return npairs.autopairs_cr()
	end
end
remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

MUtils.BS = function()
	if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
		return npairs.esc("<c-e>") .. npairs.autopairs_bs()
	else
		return npairs.autopairs_bs()
	end
end
remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })

require("lspsaga").init_lsp_saga({})

require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = true,
	italic = false, -- will make italic comments and special strings
	inverse = true, -- invert background for search, diffs, statuslines and errors
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	contrast = "hard", -- can be "hard" or "soft"
	overrides = {},
})

require("todo-comments").setup({})

require("better_escape").setup({
	mapping = { "jk", "jj" }, -- a table with mappings to use
	timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
	clear_empty_lines = false, -- clear line after escaping if there is only whitespace
	keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
})

-- Disable cursorline from nvim-cursorline
-- vim.g.cursorline_timeout = -1

-- Windows / Linux
-- vim.cmd("let g:vimwiki_list = [{'path': '$HOME/Dropbox/wiki'}]")
-- MacOS
vim.cmd("let g:vimwiki_list = [{'path': '$HOME/Library/CloudStorage/Dropbox/wiki'}]")

vim.cmd("let g:vimwiki_ext = '.md'")
vim.cmd("let g:vimwiki_global_ext = 0")
