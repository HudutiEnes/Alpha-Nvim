local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
        
npairs.setup({
    fast_wrap = {
        map = '<c-t>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
    },
})


local ts_conds = require('nvim-autopairs.ts-conds')


-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'})),

    Rule(' ', ' ')
        :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ '()', '{}', '[]' }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({ '(  )', '{  }', '[  ]' }, context)
        end),
    Rule('', ' )')
        :with_pair(cond.none())
        :with_move(function(opts)
            return opts.char == ')'
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key(')'),
    Rule('', ' }')
        :with_pair(cond.none())
        :with_move(function(opts)
            return opts.char == '}'
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key('}'),
    Rule('', ' ]')
        :with_pair(cond.none())
        :with_move(function(opts)
            return opts.char == ']'
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key(']'),

    -- Add curly braces on arrow on javascript
    Rule(
        '%(.*%)%s*%=>$',
        ' {}',
        { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }
    ):use_regex(true):set_end_pair_length(1),

    -- Auto add space on =
    Rule('=', '', { '-sh' })
        :with_pair(cond.not_inside_quote())
        :with_pair(function(opts)
            if vim.o.filetype == 'rust' then
                return false
            end

            local last_char = opts.line:sub(opts.col - 1, opts.col - 1)

            if last_char:match('[%w%=%s]') then
                return true
            end
            return false
        end)
        :replace_endpair(function(opts)
            local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
            local next_char = opts.line:sub(opts.col, opts.col)
            next_char = next_char == ' ' and '' or ' '
            if prev_2char:match('%w$') then
                return '<bs> =' .. next_char
            end
            if prev_2char:match('%=$') then
                return next_char
            end
            if prev_2char:match('=') then
                return '<bs><bs>=' .. next_char
            end
            return ''
        end)
        :set_end_pair_length(0)
        :with_move(cond.none())
        :with_del(cond.none()),
            
})
