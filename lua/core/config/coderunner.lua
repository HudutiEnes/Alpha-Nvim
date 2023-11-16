require("code_runner").setup({
	mode = "float",
	focus = false,
	startinsert = true,
	float = {
		close_key = "<ESC>",
		border = "rounded",
	},
	-- put here the commands by filetype
	filetype = {
		--java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		--python = "python3 -u",
		--typescript = "deno run",
		--rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
		cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
	},
})
