local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" }) -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("kyazdani42/nvim-web-devicons")
	use("akinsho/bufferline.nvim")
	use("p00f/nvim-ts-rainbow") --colorized punctuation signs
	use("akinsho/toggleterm.nvim")

	--color schemes
	use({
		"nxvu699134/vn-night.nvim",
		"tiagovla/tokyodark.nvim",
		"ray-x/aurora",
		"ray-x/starry.nvim",
		"sainnhe/sonokai",
		"bluz71/vim-moonfly-colors",
		"lalitmee/cobalt2.nvim",
		"uloco/bluloco.nvim",
		"EdenEast/nightfox.nvim",
		"folke/tokyonight.nvim",
	})


	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "onsails/lspkind.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("lewis6991/nvim-treesitter-context")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		"windwp/nvim-ts-autotag",
		run = ":TSUpdate",
	})

	use({
		"mcauley-penney/tidy.nvim",
		config = function()
			require("tidy").setup()
		end,
	})

	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	--lualine
	--use({
	--	"nvim-lualine/lualine.nvim",
	--	requires = { "kyazdani42/nvim-web-devicons", opt = true },
	--	})

	use({
		"xeluxee/competitest.nvim",
		requires = "MunifTanjim/nui.nvim",
		config = function()
			require("competitest").setup()
		end,
	})

	use({
		"windwp/windline.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use({
		"gelguy/wilder.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use("ThePrimeagen/harpoon")

	use({
		"Kasama/nvim-custom-diagnostic-highlight",
		config = function()
			require("nvim-custom-diagnostic-highlight").setup({})
		end,
	})

	use({ "CRAG666/code_runner.nvim", requires = "nvim-lua/plenary.nvim" })

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	--Dashboard
	use({ "goolord/alpha-nvim", config = require("alpha").setup(require("core.config.screen").opts) })

	use({
		"folke/which-key.nvim", --keymapping tool
		config = function()
			require("which-key").setup({
				triggers_blacklist = {
					i = { "n" },
				},
			})
		end,
	})

	--fun and games
	use({
		"seandewar/killersheep.nvim",
		"ThePrimeagen/vim-be-good",
	})

	--Lines
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({ filetype_exclude = { "dashboard" } })
		end,
	})

	use({ "kevinhwang91/nvim-hlslens" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
