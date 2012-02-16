" Autoload settings
runtime bundle/vim-pathogen/autoload/pathogen.vim

" Editor Appearance 
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set showtabline=2
highlight LineNr ctermfg=white
syntax on

" Editor Behaviour
set title
set visualbell
set noerrorbells
set history=1000
set undolevels=1000
set showmatch
set ignorecase

set autoindent
set copyindent
set shiftround
set backspace=indent,eol,start
set smartcase
set smarttab
set hlsearch
set incsearch
set pastetoggle=<F10>

" Key mappings
map <C-h> <C-w>h
map <C-l> <C-w>l
nmap <silent> ,/ :nohlsearch<CR>
cmap w!! w !sudo tee % >/dev/null
"" Escape common write and quit typos
cmap W w 
cmap Wq wq 
cmap WQ wq 
map <C-n> <TAB>

" Tab key mappings
map <S-k> :tabr<cr>
map <S-j> :tabl<cr>
map <S-h> :tabp<cr>
map <S-l> :tabn<cr>

" PAHTOGEN
call pathogen#infect()
filetype plugin indent on

" zen-coding
let g:user_zen_expandabbr_key = '<c-e>' 
let g:use_zen_complete_tag = 1


" Auto spellng correction
:iabbrev teh the
:iabbrev hte the
:iabbrev fiels files 
