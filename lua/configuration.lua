local nvim_lsp = require("lspconfig")
local coq = require("coq")
local servers = { "rust_analyzer", "ccls", "tsserver" }
local shell = "pwsh.exe -NoLogo"

if vim.loop.os_uname().sysname == "Linux" then
	-- Enable additional lspsevers on Linux
	table.insert(servers, "intelephense")
	-- table.insert(servers, "tailwindcss")
	-- Use the appropriate shell in toggleterm
	shell = "fish"
end

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
		require("null-ls").builtins.formatting.deno_fmt,
	},
})

nvim_lsp.tsserver.setup({
	init_options = require("nvim-lsp-ts-utils").init_options,
	--
	on_attach = function(client, bufnr)
		local ts_utils = require("nvim-lsp-ts-utils")

		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = false,

			-- import all
			import_all_timeout = 5000, -- ms
			-- lower numbers = higher priority
			import_all_priorities = {
				same_file = 1, -- add to existing import statement
				local_files = 2, -- git files or files with relative path markers
				buffer_content = 3, -- loaded buffer content
				buffers = 4, -- loaded buffer names
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			-- inlay hints
			auto_inlay_hints = true,
			inlay_hints_highlight = "Comment",

			-- update imports on file move
			update_imports_on_move = false,
			require_confirmation_on_move = false,
			watch_dir = nil,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- no default maps, so you may want to define some here
		local opts = { silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
	end,
})

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

require("bufferline").setup()

require("lualine").setup()

require("gitsigns").setup()

require("indent_blankline").setup({
	char = "⋅",
	buftype_exclude = { "terminal" },
})

require("kommentary.config").configure_language("default", {
	prefer_single_line_comments = true,
})

require("nvim-tree").setup({
	auto_close = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	view = {
		side = "right",
		auto_resize = true,
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
	direction = "horizontal",
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
