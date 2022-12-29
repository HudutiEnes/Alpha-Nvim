local opts = { noremap = true, silent = true }
local wk = require("which-key")
local window = require("core.utils.window")

wk.register({
	r = {
		function()
			common.reload_package("nvim")
		end,
		"Reload config",
	},
}, {
	prefix = "<tab>",
})

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Resize with arrows
wk.register({
	["C-left"] = { "<cmd>vertical resize -2<cr>" },
	["C-right"] = { "<cmd>vertical resize +2<cr>" },
})

--formatting
wk.register({
	["<leader>f"] = { "<esc>:lua vim.lsp.buf.format()<cr>", "Format file" },
})

--run code automatically
wk.register({
	["<leader>r"] = { "<cmd>RunCode<cr>", "Run code" },
})

-- Navigate buffers
wk.register({
	["<S-l>"] = { "<cmd>bnext<cr>", "Next Buffer" },
	["<S-h>"] = { "<cmd>bprevious<cr>", "Previous Buffer" },
})

-- Visual --
-- Move text up and down
wk.register({
	["<A-j>"] = { "<cmd>m .+1<cr>==", "Move text up" },
	["<A-k"] = { "<cmd>m .-2<cr>==", "Move text down" },
})
--keymap("v", "<A-j>", ":m .+1<CR>==", opts)

-- Visual Block --
-- Move text up and down
wk.register({
	["<A-j>"] = { "<cmd>move '>+1<cr>gv-gv", "Move text up" },
	["<A-k>"] = { "<cmd>move '<-2<cr>gv-gv", "Move text down" },
})
-- Terminal --
-- Better terminal navigation
--keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
--keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
--keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
--keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

wk.register({
	["<c-m>"] = { "<c-w>h", "Jump left window" },
	["<c-i>"] = { "<c-w>l", "Jump right window" },
	["<c-n>"] = { "<c-w>j", "Jump bottom window" },
	["<c-e>"] = { "<c-w>k", "Jump top window" },
	["<c-w><c-w>"] = { "<c-w>p", "Jump to last window" },
}, {})

wk.register({
	[",w"] = { "<cmd>silent w<cr>", "Save file" },
	[",wf"] = { "<esc>:w<cr>:lua vim.lsp.buf.format()<CR>", "Save and format" }, --keymap("i", "<F4>", "<Esc>:w<CR>:lua vim.lsp.buf.format()<CR>", opts)
	[",q"] = { "<cmd>q<cr>", "Close window" },
	[",wq"] = { "<cmd>wq<cr>", "Save and close" },
	[",Q"] = { "<cmd>tabclose<cr>", "Close tab" },
})

wk.register({
	["<tab>h"] = { window.split_left, "Split left" },
	["<tab>n"] = { window.split_bottom, "Split bottom" },
	["<tab>e"] = { window.split_top, "Split top" },
	["<tab>i"] = { window.split_right, "Split right" },
})

wk.register({
	["<A-n>"] = { "<cmd>NvimTreeToggle<cr>", "Nerdtree open" },
})

--hslens
wk.register({
	["n"] = { "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()zz<CR>" },
	["N"] = { "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()zz<CR>" },
	["*"] = { "*<Cmd>lua require('hlslens').start()zz<CR>" },
	["#"] = { "#<Cmd>lua require('hlslens').start()zz<CR>" },
	["g*"] = { "g*<Cmd>lua require('hlslens').start()zz<CR>" },
	["g#"] = { "g#<Cmd>lua require('hlslens').start()zz<CR>" },
})

wk.register({
	["<C-d>"] = { "<C-d>zz" },
	["C-u>"] = { "<C-u>zz" },
})

--Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>add", ":lua require('harpoon.mark').add_file()<CR>", term_opts)
