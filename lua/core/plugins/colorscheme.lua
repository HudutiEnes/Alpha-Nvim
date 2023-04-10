--local dracula = require("dracula")
--dracula.setup({
--    italic_comment = true,
--})

--vim.cmd [[colorscheme dracula]]
--vim.g.tokyodark_transparent_background = true
--vim.g.tokyodark_enable_italic_comment = true
--vim.g.tokyodark_enable_italic = false
--vim.g.tokyodark_color_gamma = "1.1"
--vim.cmd("colorscheme tokyodark")
require("tokyonight").setup({
    style = "storm",
    light_style = "day",
    transparent = true,
    terminal_colors = true,
})
vim.cmd([[colorscheme tokyonight]])
