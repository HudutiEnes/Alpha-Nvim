
if vim.diagnostic then
  -- Customize how to show diagnostics:
  -- @see https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
  -- @see https://github.com/neovim/neovim/pull/16057 for new APIs
  vim.diagnostic.config {
    -- No virtual text (distracting!), show popup window on hover.
    virtual_text = false,
    underline = {
      -- Do not underline text when severity is low (INFO or HINT).
      severity = { min = vim.diagnostic.severity.WARN },
    },
    float = {
      source = 'always',
      focusable = true,
      focus = false,
      border = 'single',

      -- Customize how diagnostic message will be shown: show error code.
      format = function(diagnostic)
        -- See null-ls.nvim#632, neovim#17222 for how to pick up `code`
        local user_data
        user_data = diagnostic.user_data or {}
        user_data = user_data.lsp or user_data.null_ls or user_data
        local code = (
            -- TODO: symbol is specific to pylint (will be removed)
            diagnostic.symbol or diagnostic.code or
                user_data.symbol or user_data.code
            )
        if code then
          return string.format("%s (%s)", diagnostic.message, code)
        else return diagnostic.message
        end
      end,
    }
  }
  _G.LspDiagnosticsShowPopup = function()
    return vim.diagnostic.open_float(0, { scope = "cursor" })
  end
end

-- Show diagnostics in a pop-up window on hover
do
  _G.LspDiagnosticsPopupHandler = function()
    local current_cursor = vim.api.nvim_win_get_cursor(0)
    local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

    -- Show the popup diagnostics window,
    -- but only once for the current cursor location (unless moved afterwards).
    if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
      vim.w.lsp_diagnostics_last_cursor = current_cursor
      local _, winnr = _G.LspDiagnosticsShowPopup()
      if winnr ~= nil then
        -- opacity/alpha for diagnostics
        vim.api.nvim_win_set_option(winnr, "winblend", 20)
      end
    end
  end
  vim.cmd [[
  augroup LSPDiagnosticsOnHover
    autocmd!
    autocmd CursorHold *   lua _G.LspDiagnosticsPopupHandler()
  augroup END
  ]]
end

-- Redefine signs (:help diagnostic-signs)
do
  vim.fn.sign_define("DiagnosticSignError",  {text = "✘", texthl = "DiagnosticSignError"})
  vim.fn.sign_define("DiagnosticSignWarn",   {text = "", texthl = "DiagnosticSignWarn"})
  vim.fn.sign_define("DiagnosticSignInfo",   {text = "i", texthl = "DiagnosticSignInfo"})
  vim.fn.sign_define("DiagnosticSignHint",   {text = "", texthl = "DiagnosticSignHint"})
  vim.cmd [[
    hi DiagnosticSignError    guifg=#e6645f ctermfg=167
    hi DiagnosticSignWarn     guifg=#b1b14d ctermfg=143
    hi DiagnosticSignHint     guifg=#3e6e9e ctermfg=75
  ]]
end

-- Commands for temporarily turning on and off diagnostics (for the current buffer or globally)
do
  vim.cmd [[
    command! DiagnosticsDisable     :lua vim.diagnostic.disable(0)
    command! DiagnosticsEnable      :lua vim.diagnostic.enable(0)
    command! DiagnosticsDisableAll  :lua vim.diagnostic.disable()
    command! DiagnosticsEnableAll   :lua vim.diagnostic.enable()
  ]]
end
