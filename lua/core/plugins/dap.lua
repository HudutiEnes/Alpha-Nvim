M.dap = {
    config = function()
    local dap = require "dap"

    dap.configurations.cpp = {
        name = "C/C++: g++ build and debug active file",
        type = "cppdbg",
        request = "launch",
        program = "${fileDirname}/${fileBasenameNoExtension}"
        cppPath = function ()
            return '/usr/bin/gdb'
        end;

    },
    end,
}
