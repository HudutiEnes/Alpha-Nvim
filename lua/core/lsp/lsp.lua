local lsp = require("lsp-zero").preset({})

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"rust_analyzer",
	"clangd",
})


require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	},
})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

lsp.setup()

--lsp.setup()
vim.diagnostic.config({
	underline = true,
	signs = true,
	virtual_text = {
		prefix = "",
		spacing = 5,
--        severity_sort = true,
		severity_limit = "Warning",
	},
    severity_sort = true,
	update_in_insert = true,
    float = {
        source = "always",
        border = "rounded",
    },
})


	--	float = {
	--		focusable = true,
	--		style = "minimal",
	--		border = "rounded",
	--		source = "always",
	--		header = "",
	--		prefix = "",
    --
    --
    --
--local cmp = require("cmp")
--local luasnip = require("luasnip")
--local lspkind = require("lspkind")
--local cmp_mappings = lsp.defaults.cmp_mappings({
--	["<C-b>"] = cmp.mapping.scroll_docs(-4),
--	["<C-f>"] = cmp.mapping.scroll_docs(4),
--	["<C-Space>"] = cmp.mapping.complete(),
--	["<C-e>"] = cmp.mapping.abort(),
--	["<Tab>"] = cmp.mapping.confirm({ select = true }),
--	["<CR>"] = cmp.mapping(function(fallback)
--		if cmp.visible() then
--			cmp.select_next_item()
--		elseif luasnip.expand_or_jumpable() then
--			luasnip.expand_or_jump()
--			-- this will auto complete if our cursor in next to a word and we press tab
--			-- elseif has_words_before() then
--			--     cmp.complete()
--		else
--			fallback()
--		end
--	end, { "i", "s" }),
--
--	["<S-Tab>"] = cmp.mapping(function(fallback)
--		if cmp.visible() then
--			cmp.select_prev_item()
--		elseif luasnip.jumpable(-1) then
--			luasnip.jump(-1)
--		else
--			fallback()
--		end
--	end, { "i", "s" }),
--})

--lsp.setup_nvim_cmp({
--	mapping = cmp_mappings,

--	snippet = {
--		expand = function(args)
--			luasnip.lsp_expand(args.body)
--		end,
--	},

--	sources = {
--		{ name = "path" },
--		{ name = "nvim_lsp", keyword_length = 3 },
--		{ name = "buffer", keyword_length = 3 },
--		{ name = "luasnip", keyword_length = 2 },
--		{ name = "property", keyword_length = 4 },
--	},
--	formatting = {
--		format = lspkind.cmp_format({
--			mode = "text_symbol", -- show only symbol annotations
--			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
--			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
--
--			symbol_map = {
--				Text = " ",
--				Method = " ",
--				Function = " ",
--				Constructor = "略 ",
--				Field = "ﰠ",
--				Variable = " ",
--				Class = " ",
--				Interface = " ",
--				Module = " ",
--				Property = " ",
--				Unit = "塞 ",
--				Value = " ",
--				Enum = " ",
--				Keyword = " ",
--				Snippet = " ",
--				Color = " ",
--				File = " ",
--				Reference = " ",
--				Folder = " ",
--				EnumMember = " ",
--				Constant = " ",
--				Struct = " ",
--				Event = " ",
--				Operator = " ",
--				TypeParameter = " ",
--			},
--
--			before = function(entry, vim_item)
--				return vim_item
--			end,
--		}),
--	},
--})
