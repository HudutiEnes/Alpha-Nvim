--
-- Lua INIT
--

math.randomseed(os.time()) -- For random header.

-- To split our quote, artist and source.
-- And automatically center it for screen loader of the header.
local function split(s)
	local t = {}
	local max_line_length = vim.api.nvim_get_option("columns")
	local longest = 0 -- Value of longest string is 0 by default
	for far in s:gmatch("[^\r\n]+") do
		-- Break the line if it's actually bigger than terminal columns
		local line
		far:gsub("(%s*)(%S+)", function(spc, word)
			if not line or #line + #spc + #word > max_line_length then
				table.insert(t, line)
				line = word
			else
				line = line .. spc .. word
				longest = max_line_length
			end
		end)
		-- Get the string that is the longest
		if #line > longest then
			longest = #line
		end
		table.insert(t, line)
	end
	-- Center all strings by the longest
	for i = 1, #t do
		local space = longest - #t[i]
		local left = math.floor(space / 2)
		local right = space - left
		t[i] = string.rep(" ", left) .. t[i] .. string.rep(" ", right)
	end
	return t
end

-- Function to retrieve console output.
local function capture(cmd)
	local handle = assert(io.popen(cmd, "r"))
	local output = assert(handle:read("*a"))
	handle:close()
	return output
end

-- Create button for initial keybind.
--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 5,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "Keyword",
	}
	if keybind then
		keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end

	local function on_press()
		local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "normal", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

-- All custom headers
Headers = {

	--{
	--   [[                               /^\                                 ]],
	--   [[            L L               /   \               L L              ]],
	--   [[         __/|/|_             /  .  \             _|\|\__           ]],
	--   [[        /_| [_[_\           /     .-\           /_]_] |_\          ]],
	--   [[       /__\  __`-\_____    /    .    \    _____/-`__  /__\         ]],
	--   [[      /___] /=@>  _   {>  /-.         \  <}   _  <@=\ [___\        ]],
	--   [[     /____/     /` `--/  /      .      \  \--` `\     \____\       ]],
	--   [[    /____/  \____/`-._> /               \ <_.-`\____/  \____\      ]],
	--   [[   /____/    /__/      /-._     .   _.-  \      \__\    \____\     ]],
	--   [[  /____/    /__/      / MADE    .         \      \__\    \____\    ]],
	--   [[ |____/_  _/__/      /          . BY       \      \__\_  _\____|   ]],
	--   [[  \__/_ ``_|_/      /      -._  .        _.-\      \_|_`` _\___/   ]],
	--   [[    /__`-`__\      <_  ENES   `-;           _>      /__`-`__\      ]],
	--   [[       `-`           `-._       ;       _.-`           `-`         ]],
	--   [[                         `-._   ;   _.-`                           ]],
	--   [[                             `-._.-`                               ]],
	--},

	--  {
	--  [[        Config by Enes     ]],
	--  [[            .  .           ]],
	--  [[            |\_|\          ]],
	--  [[            | a_a\         ]],
	--  [[            | | "]         ]],
	--  [[        ____| '-\___       ]],
	--  [[       /.----.___.-'\      ]],
	--  [[      //        _    \     ]],
	--  [[     //   .-. (~v~) /|     ]],
	--  [[    |'|  /\:  .--  / \     ]],
	--  [[   // |-/  \_/____/\/~|    ]],
	--  [[  |/  \ |  []_|_|_] \ |    ]],
	--  [[  | \  | \ |___   _\ ]_}   ]],
	--  [[  | |  '-' /   '.'  |      ]],
	--  [[  | |     /    /|:  |      ]],
	--  [[  | |     |   / |:  /\     ]],
	--  [[  | |     /  /  |  /  \    ]],
	--  [[  | |    |  /  /  |    \   ]],
	--  [[  \ |    |/\/  |/|/\    \  ]],
	--  [[   \|\ |\|  |  | / /\/\__\ ]],
	--  [[    \ \| | /   | |__       ]],
	--  [[         / |   |____)      ]],
	--  [[         |_/               ]],
	--},

	--  {
	--  [[                       ,---.           ,---.                           ]],
	--  [[                      / /"`.\.--"""--./,'"\ \                          ]],
	--  [[                      \ \    _       _    / /                          ]],
	--  [[                       `./  / __   __ \  \,'                           ]],
	--  [[                        /    /_O)_(_O\    \                            ]],
	--  [[                        |  .-'  ___  `-.  |                            ]],
	--  [[                     .--|       \_/       |--.                         ]],
	--  [[                   ,'    \   \   |   /   /    `.                       ]],
	--  [[                  /       `.  `--^--'  ,'       \                      ]],
	--  [[               .-"""""-.    `--.___.--'     .-"""""-.                  ]],
	--  [[  .-----------/         \------------------/         \--------------.  ]],
	--  [[  | .---------\         /----------------- \         /------------. |  ]],
	--  [[  | |          `-`--`--'                    `--'--'-'             | |  ]],
	--  [[  | |                                                             | |  ]],
	--  [[  | |                                                             | |  ]],
	--  [[  | |                                                             | |  ]],
	--  [[  | |                                                             | |  ]],
	--  [[  | |      " The most important thing is to keep learning,        | |  ]],
	--  [[  | |        to enjoy challenge, and to tolerate ambiguity."      | |  ]],
	--  [[  | |                                                             | |  ]],
	--  [[  | |                                                             | |  ]],
	--  [[  | |                                                             | |  ]],
	--  [[  | |                                                             | |  ]],
	--  [[  | |                                                             | |  ]],
	--  [[  | |                                                             | |  ]],
	--  [[  | |_____________________________________________________________| |  ]],
	--  [[  |_________________________________________________________________|  ]],
	--  [[                     )__________|__|__________(                        ]],
	--  [[                    |            ||            |                       ]],
	--  [[                    |____________||____________|                       ]],
	--  [[                      ),-----.(      ),-----.(                         ]],
	--  [[                    ,'   ==.   \    /  .==    `.                       ]],
	--  [[                   /            )  (            \                      ]],
	--  [[                   `==========='    `==========='                      ]],

	--},

	--  {
	--   [[          _nnnn_       ,.............,   ]],
	--   [[         dGGGGMMb     ; Config made  ;   ]],
	--   [[        @p~qp~~qMb    |   on  Linux  |   ]],
	--   [[        M|@||@) M|   _;..............'   ]],
	--   [[        @,----.JM| -'                    ]],
	--   [[       JS^\__/  qKL                      ]],
	--   [[      dZP        qKRb                    ]],
	--   [[     dZP          qKKb                   ]],
	--   [[    fZP            SMMb                  ]],
	--   [[    HZM            MMMM                  ]],
	--   [[    FqM            MMMM                  ]],
	--   [[  __| ".        |\dS"qML                 ]],
	--   [[  |    `.       | `' \Zq                 ]],
	--   [[ _)      \.___.,|     .'                 ]],
	--   [[ \____   )MMMMMM|   .'                   ]],
	--   [[      `-'       `--'                     ]],

	--  },

	--{
	--    [[              _.++. .+.         ]],
	--    [[            .'///|\Y/|\;        ]],
	--    [[           : :   _ | _ |        ]],
	--    [[          /  `-.' `:' `:        ]],
	--    [[         /|i, :     ;   ;.      ]],
	--    [[        ,     |     |   |`\     ]],
	--    [[        ||Ii  :     |   |  ;    ]],
	--    [[        ;      \--gg;-gg; i:    ]],
	--    [[        ||Ii    `._,gg.'   |    ]],
	--    [[        '       .' `**'`. i;    ]],
	--    [[         `.\`   `. .'`..' /     ]],
	--    [[          |`-._      __.-'      ]],
	--    [[          :           `.        ]],
	--    [[         /i,\  ,        \       ]],
	--    [[        /    ; :         \      ]],
	--    [[       :Ii  _:  \         ;     ]],
	--    [[       ;   (     ;        :     ]],
	--    [[       :i'( _,  /         ;     ]],
	--    [[        ;. `"--'         /      ]],
	--    [[        :i\Ii'         .'       ]],
	--    [[        |  ;  :__.--:*"         ]],
	--    [[        |Ii|  :  ;  :           ]],
	--    [[        ;  |  |  |  |           ]],
	--    [[       /Y  |  |  |  |           ]],
	--    [[   .=-'Y  /|  ;  |  |           ]],
	--    [[  :E    .' ;  L__:-***-.-***-.  ]],
	--    [[   `=--' .'       _   , ;   , ; ]],
	--    [[        '----.__.__J--'"`*--'"  ]],
	--  },

	{
		[[               _..-'(                       )`-.._                ]],
		[[            ./'. '||\\.       (\_/)       .//||` .`\.             ]],
		[[         ./'.|'.'||||\\|..    )O O(    ..|//||||`.`|.`\.          ]],
		[[      ./'..|'.|| |||||\`````` '`"'` ''''''/||||| ||.`|..`\.       ]],
		[[    ./'.||'.|||| ||||||||||||.     .|||||||||||| |||||.`||.`\.    ]],
		[[   /'|||'.|||||| ||||||||||||{     }|||||||||||| ||||||.`|||`\    ]],
		[[  '.|||'.||||||| ||||||||||||{     }|||||||||||| |||||||.`|||.`   ]],
		[[ '.||| ||||||||| |/'   ``\||``     ''||/''   `\| ||||||||| |||.`  ]],
		[[ |/' \./'     `\./         \!|\   /|!/         \./'     `\./ `\|  ]],
		[[ V    V         V          }' `\ /' `{          V         V    V  ]],
		[[ `    `         `               V               '         '    '  ]],
	},

	--{
	--   [[   _________         .    . ]],
	--   [[  (..       \_    ,  |\  /| ]],
	--   [[   \       O  \  /|  \ \/ / ]],
	--   [[    \______    \/ |   \  /  ]],
	--   [[       vvvv\    \ |   /  |  ]],
	--   [[       \^^^^  ==   \_/   |  ]],
	--   [[        `\_   ===    \.  |  ]],
	--   [[        / /\_   \ /      |  ]],
	--   [[        |/   \_  \|      /  ]],
	--   [[               \________/   ]],
	-- },

	-- {
	--  [[                            .d$$b       ]],
	--  [[                          .' TO$;\      ]],
	--  [[                         /  : TP._;     ]],
	--  [[                        / _.;  :Tb|     ]],
	--  [[                       /   /   ;j$j     ]],
	--  [[                   _.-"       d$$$$     ]],
	--  [[                 .' ..       d$$$$;     ]],
	--  [[                /  /P'      d$$$$P. |\  ]],
	--  [[               /   "      .d$$$P' |\^"l ]],
	--  [[             .'           `T$P^"""""  : ]],
	--  [[         ._.'      _.'                ; ]],
	--  [[      `-.-".-'-' ._.       _.-"    .-"  ]],
	--  [[    `.-" _____  ._              .-"     ]],
	--  [[   -(.g$$$$$$$b.              .'        ]],
	--  [[     ""^^T$$$P^)            .(:         ]],
	--  [[       _/  -"  /.'         /:/;         ]],
	--  [[    ._.'-'`-'  ")/         /;/;         ]],
	--  [[ `-.-"..--""   " /         /  ;         ]],
	--  [[.-" ..--""        -'          :         ]],
	--  [[..--""--.-"         (\      .-(\        ]],
	--  [[  ..--""              `-\(\/;`          ]],
	--  [[    _.                      :           ]],
	--  [[                            ;`-         ]],
	--  [[                           :\           ]],
	-- }
}

--
-- Sections for Alpha.
--

local default_header = {
	type = "text",
	val = Headers[math.random(#Headers)],
	opts = {
		position = "center",
		hl = "Type",
		-- wrap = "overflow";
	},
}

local footer = {
	type = "text",
	-- Change 'rdn' to any program that gives you a random quote.
	-- https://github.com/BeyondMagic/scripts/blob/master/quotes/rdn
	-- Which returns one to three lines, being each divided by a line break.
	-- Or just an array: { "I see you:", "Above you." }
	val = split(capture("rdn")),
	opts = {
		position = "center",
		hl = "Number",
	},
}

local buttons = {
	type = "group",
	val = {
		button("e", "  New Buffer", ":tabnew<CR>"),
		button("f", "  Find file", ":Telescope find_files<CR>"),
		button("h", "  Recently opened files", ":Telescope oldfiles<CR>"),
		button("g", "  Open Last Session", ":source ~/.config/nvim/session.vim<CR>"),
		button("l", "  Marks", ":Telescope marks<CR>"),
	},
	opts = {
		spacing = 1,
	},
}

local section = {
	header = default_header,
	buttons = buttons,
	footer = footer,
}

--
-- Centering handler of ALPHA
--

local ol = { -- occupied lines
	icon = #default_header.val, -- CONST: number of lines that your header will occupy
	message = 1 + #footer.val, -- CONST: because of padding at the bottom
	length_buttons = #buttons.val * 2 - 1, -- CONST: it calculate the number that buttons will occupy
	neovim_lines = 3, -- CONST: 2 of command line, 1 of the top bar
	padding_between = 2, -- STATIC: can be set to anything, padding between keybinds and header
}

local left_terminal_value = vim.api.nvim_get_option("lines")
	- (ol.length_buttons + ol.message + ol.padding_between + ol.icon + ol.neovim_lines)
local top_padding = math.floor(left_terminal_value / 2)
local bottom_padding = left_terminal_value - top_padding

--
-- Set alpha sections
--

local opts = {
	layout = {
		{ type = "padding", val = top_padding },
		section.header,
		{ type = "padding", val = ol.padding_between },
		section.buttons,
		section.footer,
		{ type = "padding", val = bottom_padding },
	},
	opts = {
		margin = 5,
	},
}

return {
	button = button,
	section = section,
	opts = opts,
}
