-- General Editor Settings
vim.opt.path = vim.opt.path + ".,**"
vim.opt.joinspaces = false
vim.opt.list = true
vim.opt.number = true
vim.opt.sidescrolloff = 8
vim.opt.ignorecase = true    -- Ignore case when searching
vim.opt.smartcase = false		 -- Turn off smartcase when searching
vim.opt.smartindent = true
vim.opt.wildmenu = true
vim.opt.scrolloff = 10       -- Top / bottom padding when scrolling
vim.opt.cursorline = true
vim.opt.undolevels = 1000
vim.opt.history = 1000

-- Disable netrw
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

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
  {'kris89/vim-multiple-cursors'},
  {'tpope/vim-commentary'},
  {'farmergreg/vim-lastplace'},
  {'vim-airline/vim-airline'},
  {'rhysd/vim-clang-format'},
  {'nvim-tree/nvim-tree.lua'},
  {'tranvansang/octave.vim'}
})


-- -- Netrw File Manager
-- vim.g.netrw_banner = 0       -- Hide banner
-- vim.g.netrw_browse_split = 0 -- Open file in current split
-- vim.g.netrw_liststyle = 3    -- Tree-style view
-- vim.g.netrw_sort_sequence = '[/]$,*,.bak$,.o$,.info$,.swp$,.obj$'

-- Custom functions
function py_formatter()
  local file = vim.fn.expand('%:p')
  local cmd = "yapf3 --in-place " .. file
  vim.cmd("w") -- Save the current buffer
  vim.cmd("! " .. cmd) -- Run the formatting command using "!" to execute it in the shell
end


-- Nvim-tree
require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
        modified = false,
      }
    }
  },
  filters = {
    dotfiles = true,
  },
})
---- Nvim-tree auto close
vim.api.nvim_create_autocmd({"QuitPre"}, {
  callback = function() vim.cmd("NvimTreeClose") end,
})


-- Syntax
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"c"}, command = "setlocal commentstring=//\\ %s"})
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"cpp"}, command = "setlocal commentstring=//\\ %s"})
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"openscad"}, command = "setlocal commentstring=//\\ %s"})
-- vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"c"}, command = "ClangFormatAutoEnable"})


-- Color Scheme
---- General colors
vim.api.nvim_set_hl(0, "Normal", {ctermbg=None})
vim.api.nvim_set_hl(0, "LineNr", {ctermfg=249, ctermbg=236})
vim.api.nvim_set_hl(0, "Cursor", {ctermfg=255, ctermbg=16})
vim.api.nvim_set_hl(0, "CursorLine", {cterm=None, ctermbg=236})
vim.api.nvim_set_hl(0, "CursorLineNR", {cterm=None, ctermfg=None, ctermbg=240})
vim.api.nvim_set_hl(0, "Directory", {ctermfg=75})
vim.api.nvim_set_hl(0, "ErrorMsg", {ctermbg=196, ctermfg=white})
vim.api.nvim_set_hl(0, "VertSplit", {ctermfg=236})
vim.api.nvim_set_hl(0, "NonText", {ctermfg=235})
vim.api.nvim_set_hl(0, "Pmenu", {ctermfg=255, ctermbg=239})
vim.api.nvim_set_hl(0, "PmenuSel", {ctermfg=255, ctermbg=237})
vim.api.nvim_set_hl(0, "Search", {cterm=None, ctermfg=255, ctermbg=196})
vim.api.nvim_set_hl(0, "SpellBad", {ctermfg=196, ctermbg=None})
vim.api.nvim_set_hl(0, "ColorColumn", {ctermfg=196, ctermbg=None})
---- Syntax highlighting groups
vim.api.nvim_set_hl(0, "Comment", {ctermfg=105})
vim.api.nvim_set_hl(0, "Constant", {ctermfg=120})
vim.api.nvim_set_hl(0, "Identifier", {ctermfg=81})
vim.api.nvim_set_hl(0, "Statement", {ctermfg=198})
vim.api.nvim_set_hl(0, "Type", {ctermfg=81})
vim.api.nvim_set_hl(0, "Function", {ctermfg=81})
vim.api.nvim_set_hl(0, "Special", {ctermfg=198})
vim.api.nvim_set_hl(0, "Error", {ctermfg=196, ctermbg=None})
vim.api.nvim_set_hl(0, "PreProc", {ctermfg=105})
vim.api.nvim_set_hl(0, "String", {ctermfg=120})
vim.api.nvim_set_hl(0, "SignColumn", {ctermbg=236})
vim.api.nvim_set_hl(0, "WildMenu", {ctermbg=76})
---- Spell check colors
vim.api.nvim_set_hl(0, "SpellBad", {cterm=underline, ctermfg=196})
vim.api.nvim_set_hl(0, "SpellCap", {cterm=underline, ctermfg=196})
vim.api.nvim_set_hl(0, "SpellRare", {cterm=underline, ctermfg=196})
vim.api.nvim_set_hl(0, "SpellLocal", {cterm=underline, ctermfg=171, ctermbg=None})
---- Vim diff colors
vim.api.nvim_set_hl(0, "DiffAdd", {ctermfg=82, ctermbg=22})
vim.api.nvim_set_hl(0, "DiffDelete", {ctermfg=196, ctermbg=52})
vim.api.nvim_set_hl(0, "DiffChange", {ctermfg=226, ctermbg=58})
vim.api.nvim_set_hl(0, "DiffText", {ctermfg=196, ctermbg=52})


-- Keyboard Shortcuts
vim.keymap.set("n", "<F5>", ":so ~/.config/nvim/init.lua<CR>", {desc = "Reload config"})
vim.keymap.set("n", "<S-r>", ":!bash scripts/run.sh<CR>")
vim.keymap.set("n", "*", "*zz", {desc = "Search and center screen"})
vim.keymap.set("n", "n", "nzz", {desc = "Search and center screen"})
vim.keymap.set("n", "N", "Nzz", {desc = "Search and center screen"})
vim.keymap.set("n", ",/", ":nohlsearch<CR>", {desc = "Clear highlight search"})
vim.keymap.set("n", "<C-k>", ":call search('\\u\\|_')<CR>l", {desc = "Jump camelCase"})
vim.keymap.set("n", "<C-P>", ":lua require('fzf-lua').files()<CR>", {desc = "FZF files"})
vim.keymap.set("n", "<C-f>", ":NvimTreeToggle <CR>", {desc = "Open file explorer"})
vim.keymap.set({"n", "v"}, "w", "<Plug>CamelCaseMotion_w", {desc = "Jump camel case forward one word"})
vim.keymap.set({"n", "v"}, "b", "<Plug>CamelCaseMotion_b", {desc = "Jump camel case backward one word"})
vim.keymap.set({"n", "v"}, "e", "<Plug>CamelCaseMotion_e", {desc = "Jump camel case end of a word"})
vim.keymap.set({"n", "v"}, "f", function()
  if vim.bo.filetype == "python" then
    vim.cmd("silent lua py_formatter()")
  elseif vim.bo.filetype == "cpp" or vim.bo.filetype == "c" then
    vim.cmd("ClangFormat")
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
---- Tab Navigation
vim.keymap.set("n", "<C-h>", ":tabp<CR>", {desc = "Move to left tab"})
vim.keymap.set("n", "<C-l>", ":tabn<CR>", {desc = "Move to right tab"})
---- Split Navigation
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
-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--   pattern = {"c", "h", "cpp", "hpp"},
--   command = "ClangFormat"
-- })
