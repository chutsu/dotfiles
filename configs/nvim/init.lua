-- General Editor Settings
vim.opt.path = vim.opt.path + ".,**"
vim.opt.joinspaces = false
vim.opt.list = true
vim.opt.listchars = { tab = "> " }
vim.opt.number = true
vim.opt.sidescrolloff = 8
vim.opt.ignorecase = true    -- Ignore case when searching
vim.opt.smartcase = false    -- Turn off smartcase when searching
vim.opt.smartindent = true
vim.opt.wildmenu = true
vim.opt.scrolloff = 10       -- Top / bottom padding when scrolling
vim.opt.cursorline = true
vim.opt.undolevels = 1000
vim.opt.history = 1000

-- Disable netrw
-- vim.g.loaded_netrw = 0
-- vim.g.loaded_netrwPlugin = 0


-- Lazy nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Load plugins
require("lazy").setup({
  {'junegunn/fzf', build = './install --bin'},
  {'ibhagwan/fzf-lua', dependencies = 'junegunn/fzf'},
  {'bkad/CamelCaseMotion'},
  {'habamax/vim-rst'},
})


-- Netrw File Manager
vim.g.netrw_banner = 0       -- Hide banner
vim.g.netrw_browse_split = 0 -- Open file in current split
vim.g.netrw_liststyle = 3    -- Tree-style view
vim.g.netrw_sort_sequence = '[/]$,*,.bak$,.o$,.info$,.swp$,.obj$'


-- Status Line
local function git_branch()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  if string.len(branch) > 0 then
    return branch
  else
    return ":"
  end
end

local function statusline()
  local set_color_1 = "%#PmenuSel#"
  local branch = git_branch()
  local set_color_2 = "%#LineNr#"
  local file_name = " %f"
  local modified = "%m"
  local align_right = "%="
  local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
  local fileformat = " [%{&fileformat}]"
  local filetype = " %y"
  local percentage = " %p%%"
  local linecol = " %l:%c"

  return string.format(
    "%s %s %s%s%s%s%s%s%s%s%s",
    set_color_1,
    branch,
    set_color_2,
    file_name,
    modified,
    align_right,
    filetype,
    fileencoding,
    fileformat,
    percentage,
    linecol
  )
end

vim.opt.statusline = statusline()


-- Custom functions
function py_formatter()
  local file = vim.fn.expand('%:p')
  local cmd = "yapf3 --in-place " .. file
  vim.cmd("w") -- Save the current buffer
  vim.cmd("! " .. cmd) -- Run the formatting command using "!" to execute it in the shell
end

function clang_formatter()
  local file = vim.fn.expand('%:p')
  local cmd = "clang-format -i " .. file
  vim.cmd("w") -- Save the current buffer
  vim.cmd("! " .. cmd) -- Run the formatting command using "!" to execute it in the shell
end


-- Syntax
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"c"}, command = "setlocal commentstring=//\\ %s"})
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"cpp"}, command = "setlocal commentstring=//\\ %s"})
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"openscad"}, command = "setlocal commentstring=//\\ %s"})
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"python"}, command = "set tabstop=2"})
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"python"}, command = "set shiftwidth=2"})
-- vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"tex"}, command = "set textwidth=80"})
-- vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"tex"}, command = "set formatoptions+=a"})
-- vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"tex"}, command = "set formatlistpat-=\\[\\]"})
-- vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"tex"}, command = "set formatlistpat-=\\[\\]"})
-- vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"text"}, command = "set formatlistpat-=\\\\begin{equation*}"})
-- vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"text"}, command = "set formatlistpat-=\\\\begin{equation}"})
-- vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"text"}, command = "set formatlistpat-=\\\\begin{align*}"})
-- vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"text"}, command = "set formatlistpat-=\\\\begin{align}"})


-- Color Scheme
---- General colors
vim.api.nvim_set_hl(0, "Normal", {bg=None})
vim.api.nvim_set_hl(0, "LineNr", {fg="#B2B2B2", bg="#303030"})
vim.api.nvim_set_hl(0, "Cursor", {fg="#FFFFFF", bg="#000000"})
vim.api.nvim_set_hl(0, "CursorLine", {bg="#303030"})
vim.api.nvim_set_hl(0, "CursorLineNR", {bg="#585858"})
vim.api.nvim_set_hl(0, "Directory", {fg="#5FAFFF"})
vim.api.nvim_set_hl(0, "ErrorMsg", {bg="#FF0000", fg="#FFFFFF"})
vim.api.nvim_set_hl(0, "VertSplit", {fg="#303030"})
vim.api.nvim_set_hl(0, "Pmenu", {fg="#FFFFFF", bg="#4E4E4E"})
vim.api.nvim_set_hl(0, "PmenuSel", {fg="#FFFFFF", bg="#3A3A3A"})
vim.api.nvim_set_hl(0, "Search", {fg="#FFFFFF", bg="#FF0000"})
vim.api.nvim_set_hl(0, "SpellBad", {fg="#FF0000"})
vim.api.nvim_set_hl(0, "ColorColumn", {fg="#FF0000"})
---- Syntax highlighting groups
vim.api.nvim_set_hl(0, "Comment", {fg="#8787FF"})
vim.api.nvim_set_hl(0, "Constant", {fg="#87D7AF"})
vim.api.nvim_set_hl(0, "Identifier", {fg="#5FD7FF"})
vim.api.nvim_set_hl(0, "Statement", {fg="#FF0087"})
vim.api.nvim_set_hl(0, "Type", {fg="#5FD7FF"})
vim.api.nvim_set_hl(0, "Function", {fg="#5FD7FF"})
vim.api.nvim_set_hl(0, "NonText", {fg="#8787FF"})
vim.api.nvim_set_hl(0, "Special", {fg="#FF0087"})
vim.api.nvim_set_hl(0, "Error", {fg="#FF0000"})
vim.api.nvim_set_hl(0, "PreProc", {fg="#8787FF"})
vim.api.nvim_set_hl(0, "String", {fg="#87FF87"})
vim.api.nvim_set_hl(0, "SignColumn", {bg="#303030"})
vim.api.nvim_set_hl(0, "WildMenu", {bg="#5FD700"})
---- Spell check colors
vim.api.nvim_set_hl(0, "SpellBad", {fg="#FF0000"})
vim.api.nvim_set_hl(0, "SpellCap", {fg="#FF0000"})
vim.api.nvim_set_hl(0, "SpellRare", {fg="#FF0000"})
vim.api.nvim_set_hl(0, "SpellLocal", {fg="#D75FFF"})
---- Vim diff colors
vim.api.nvim_set_hl(0, "DiffAdd", {fg="#5FFF00", bg="#005F00"})
vim.api.nvim_set_hl(0, "DiffDelete", {fg="#FF0000", bg="#5F0000"})
vim.api.nvim_set_hl(0, "DiffChange", {fg="#FF00D7", bg="#5F5F00"})
vim.api.nvim_set_hl(0, "DiffText", {fg="#FF0000", bg="#5F0000"})


-- Keyboard Shortcuts
vim.keymap.set("n", "<F5>", ":so ~/.config/nvim/init.lua<CR>", {desc = "Reload config"})
vim.keymap.set("n", "<S-r>", ":!bash scripts/run.sh<CR>")
vim.keymap.set("n", "*", "*zz", {desc = "Search and center screen"})
vim.keymap.set("n", "n", "nzz", {desc = "Search and center screen"})
vim.keymap.set("n", "N", "Nzz", {desc = "Search and center screen"})
vim.keymap.set("n", ",/", ":nohlsearch<CR>", {desc = "Clear highlight search"})
vim.keymap.set("n", "<C-k>", ":call search('\\u\\|_')<CR>l", {desc = "Jump camelCase"})
vim.keymap.set("n", "<C-P>", ":lua require('fzf-lua').files()<CR>", {desc = "FZF files"})
vim.keymap.set("n", "<C-f>", ":e .<CR>", {desc = "Open file explorer"})
vim.keymap.set({"n", "v"}, "w", "<Plug>CamelCaseMotion_w", {desc = "Jump camel case forward one word"})
vim.keymap.set({"n", "v"}, "b", "<Plug>CamelCaseMotion_b", {desc = "Jump camel case backward one word"})
vim.keymap.set({"n", "v"}, "e", "<Plug>CamelCaseMotion_e", {desc = "Jump camel case end of a word"})
vim.keymap.set({"n", "v"}, "F", function()
  if vim.bo.filetype == "python" then
    vim.cmd("silent lua py_formatter()")
  elseif vim.bo.filetype == "cpp" or vim.bo.filetype == "c" then
    vim.cmd("silent lua clang_formatter()")
  else
    error("Formatter not confgured!")
  end
end)
vim.keymap.set("n", "<C-i>", function()
  -- Jump between C / C++ source / header
  local fpath = vim.fn.expand('%')
  local fname = vim.fn.expand('%:t:r')
  local fext = "." .. vim.fn.expand('%:e')

  if fext == ".c" then
    vim.cmd("find " .. fname .. ".h")
  elseif fext == ".cpp" then
    vim.cmd("find " .. fname .. ".hpp")
  elseif fext == ".h" then
    vim.cmd("find " .. fname .. ".c")
  elseif fext == ".hpp" then
    vim.cmd("find " .. fname .. ".cpp")
  else
    error("[" .. fpath .. "] is not a valid C / C++ source / header file?")
  end
end)


-- Tab Navigation
vim.keymap.set("n", "<C-h>", ":tabp<CR>", {desc = "Move to left tab"})
vim.keymap.set("n", "<C-l>", ":tabn<CR>", {desc = "Move to right tab"})

-- Split Navigation
vim.keymap.set("n", "<S-h>", ":wincmd h<CR>", {desc = "Move to left split"})
vim.keymap.set("n", "<S-j>", ":wincmd j<CR>", {desc = "Move to lower split"})
vim.keymap.set("n", "<S-k>", ":wincmd k<CR>", {desc = "Move to upper split"})
vim.keymap.set("n", "<S-l>", ":wincmd l<CR>", {desc = "Move to right split"})


-- Auto Actions
---- Remove trailing whitespace
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*"},
  command = [[%s/\s\+$//e]],
})
