--local Option = require('core.utils.option')

local v = vim.opt

    ----------------------------------------------------------------------
    --                         CURSOR MOVEMENTS                         --
    ----------------------------------------------------------------------
    -- when moving the cursor, this will set the column to first not empty
    -- character
    v.startofline = true


    ----------------------------------------------------------------------
    --                              EDITOR                              --
    ----------------------------------------------------------------------
    -- tabstop
    v.tabstop = 4

    -- number of spaces to use  for indentation
    v.shiftwidth = 4

    -- remove highlighting after search is done
    v.hlsearch = false

    -- code folding
    v.foldenable = true
    v.foldcolumn = '1'
    v.foldlevel = 99
    v.foldlevelstart = 99

    -- don't wrap the text when lines can't fit the window
    v.wrap = false



    -- 'backup' 'writebackup'	action	~
    -- off	     off	no backup made
    -- off	     on		backup current file, deleted afterwards (default)
    -- on	     off	delete old backup, backup current file
    -- on	     on		delete old backup, backup current file
    v.backup = false
    v.writebackup = false
    v.swapfile = false

    --enable unlimited undo's
    v.undofile = true
    v.undodir = os.getenv("HOME").."/vim/undodir"

    -- write changes to swap file after "n" ms
    -- for some reason when the updatetime is high, autocompletion in coc nvim
    -- takes a long time
    v.updatetime = 30


    -- open completion menu even for single item
    -- do not auto insert items from completion menu
    -- @warning - preview is removed. when it's on, default lsp opens a vertical tab
    v.completeopt = 'menuone,noselect'

    -- stop showing the current mode
    v.showmode = false

    -- show global status bar
    v.laststatus = 3

    -- @TODO now sure how this is working. need to find out
    v.showcmd = false

    -- stop showing the current line and cursor position in the status bar
    v.ruler = false

    -- set the font for GUI clients like neovide
    v.guifont = 'Recursive Monospace Casual, Cascadia Code, FiraCode, Nerd Font:h19'

    -- highlight the current cursor line.
    v.cursorline = true

    -- wrap line
    -- breakindent = false,

    -- wrap line custom character to show
    v.showbreak = '↳'

    -- operator pending timeout
    v.timeoutlen = 500

    -- vim try to keep 15 lines below and above when scrolling
    -- if buffer cannot display more than 15 lines, cursor will stay in center
    -- and scroll the buffer
    v.scrolloff = 15

    -- height of the cmd to hidden
    v.cmdheight = 0

    -- add spell diagnostics
    v.spell = true

    v.spelloptions = 'camel'

    ----------------------------------------------------------------------
    --                             EDITING                              --
    ----------------------------------------------------------------------
    v.smartcase = true
    v.ignorecase = true

    -- shows the effects of a command incrementally
    v.inccommand = 'nosplit'

    -- where to place the new split windows
    v.splitright = true
    v.splitbelow = true

    -- hide unsaved file when closing the buffer
    -- usually vim doesn't allow closing unsaved buffer unless you force it
    -- but with hidden option, buffer will be hidden when you close it
    -- vim will prompt you to save when closing vim editor
    v.hidden = true


    ----------------------------------------------------------------------
    --                                UI                                --
    ----------------------------------------------------------------------
    v.termguicolors = true

    ----------------------------------------------------------------------
    --                              OTHER                               --
    ----------------------------------------------------------------------
    -- assign unnamedplus register to clipboard
    -- anything in the clipboard can be pasted directly
    -- any yanked text will be copied to clipboard
    v.clipboard = 'unnamedplus'


    ----------------------------------------------------------------------
    --                              EDITOR                              --
    ----------------------------------------------------------------------
    -- shows the number bar in left hand side of the window
    v.number = true

    -- shows numbers relative to the current cursor position
    v.relativenumber = true

    -- code folding method to syntax
    -- common methods will be used such as curly braces
    -- foldmethod = 'syntax',

    -- error signs and warnings will be displayed in the number line
    -- usually it adds new column when signs, moving buffer to right side.
    -- adding a column create weird effect that's little bit hard for the eye
    v.signcolumn = 'yes:1'


    -- set the tab size to length of 4 spaces
    -- shiftwidth set the indentation length
    v.shiftwidth = 4
