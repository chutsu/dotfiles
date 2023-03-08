-- General Editor Settings
vim.opt.joinspaces = false
vim.opt.list = true
vim.opt.number = true
vim.opt.sidescrolloff = 8
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.wildmenu = true
vim.opt.scrolloff = 20       -- Top / bottom padding when scrolling
vim.opt.cursorline = true


-- Netrw File Manager
vim.g.netrw_banner = 0       -- Hide banner
vim.g.netrw_browse_split = 0 -- Open file in current split
vim.g.netrw_liststyle = 3    -- Tree-style view


-- Color Scheme
---- General colors
vim.api.nvim_set_hl(0, "Normal", {ctermbg=235})
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
vim.api.nvim_set_hl(0, "Search", {ctermfg=234, ctermbg=255})
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
vim.keymap.set("n", "<S-r>", ":!bash scripts/run.sh<CR>", {silent = true})
vim.keymap.set("n", "*", "*zz", {desc = "Search and center screen"})


-- Actions
---- Remove trailing whitespace
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*"},
  command = [[%s/\s\+$//e]],
})
