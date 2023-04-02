--vim: ft=lua tw=80

stds.nvim = {
    read_globals = {"jit"}
}
std = "lua51+nvim"

self = false

cache = true

ignore = {
    "631",
    "212/_.*",
    "121",
    "122"
}

read_globals = {
    "vim",
    "bufnr",
}

globals = {
    "vim.g",
    "vim.o",
    "vim.w",
    "vim.b",
    "vim.bo",
    "vim.wo",
    "vim.go",
    "vim.env",
    "vim.opt"
}
