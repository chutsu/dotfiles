function! Startup()
  " Specify a directory for plugins
  " - For Neovim: stdpath('data') . '/plugged'
  " - Avoid using standard Vim directory names like 'plugin'
  call plug#begin('~/.config/nvim/plugged')

  Plug 'junegunn/vim-easy-align'
  Plug 'tpope/vim-surround'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'bling/vim-airline'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'kris89/vim-multiple-cursors'
  Plug 'vim-scripts/camelcasemotion'
  Plug 'vim-scripts/EasyGrep'
  Plug 'vim-scripts/AnsiEsc.vim'
  Plug 'inside/vim-search-pulse'
  Plug 'tomtom/tcomment_vim'
  Plug 'jvirtanen/vim-octave'

  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-media-files.nvim'

  call plug#end()
endfunction

function! EditorAppearance()
  syntax on
  set number
  set laststatus=2
  set showtabline=2
  set t_Co=256
  colorscheme eyecandy
  set cursorline
  set encoding=utf-8

  " Let terminal resize scale the internal windows
  autocmd VimResized * :wincmd =

  " Highlight when code is over 81 columns
  augroup vimrc_autocmds
    autocmd BufEnter * highlight OverLength ctermbg=darkgrey
    autocmd BufEnter * match OverLength /\%81v.*/
  augroup END
endfunction

function! EditorBehaviour()
  filetype plugin indent on
  set autoread
  set backupdir=/tmp
  set directory=/tmp
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
  set expandtab
  set smarttab
  set hlsearch
  set incsearch
  set mouse=a  " enable mouse
  set scrolloff=10  " top/bottom padding when scrolling

  " " Load git repo specific vim settings if any
  " let git_settings = system("git config --get vim.settings")
  " if strlen(git_settings)
  "     filetype plugin off
  "     exe "set" git_settings
  " endif

  " Correct filetype recognition
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd BufNewFile,BufReadPost *.launch set filetype=xml
  autocmd BufNewFile,BufReadPost *.h set filetype=c
  autocmd BufNewFile,BufReadPost *.c set filetype=c

  " Remove trailing whitespaces
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  au BufWinEnter * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhitespace /\s\+$/
  au BufWinLeave * call clearmatches()

  " Reselect block after indentation
  vnoremap < <gv
  vnoremap > >gv

  " Fix stupid typos
  map w ,w
  map b ,b

  " Restore cursor's last position in file
  autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

  " Highlight non-ascii characters
  set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•

  " Softwrap lines
  command! -range=% SoftWrap
      \ <line2>put _ |
      \ <line1>,<line2>g/.\+/ .;-/^$/ join |normal $x

  " Scroll to top when using jump-to in ctags
  nnoremap <C-]> <C-]>zt
  nnoremap <C-t> <C-t>zt

  " Keep search matches in the middle of the screen
  nnoremap n nzz
  nnoremap N Nzz
endfunction

function! CommandModeKeyMappings()
  map <C-h> <C-w>h
  map <C-l> <C-w>l
  cmap Wq wq
  cmap WQ wq
  cmap w!! w !sudo tee % >/dev/null
  nmap <silent> ,/ :nohlsearch<CR>

  " Toggle paste mode
  set pastetoggle=<F10>

  " Run script file
  map <S-r> :!bash ~/run.sh<CR>
endfunction

function! Navigation()
  nnoremap j gj
  nnoremap k gk

  " Tabs
  map <C-k> :tabr<cr>
  map <C-j> :tabl<cr>
  map <C-h> :tabp<cr>
  map <C-l> :tabn<cr>

  " Splits
  map <S-k> :wincmd k<CR>
  map <S-j> :wincmd j<CR>
  map <S-h> :wincmd h<CR>
  map <S-l> :wincmd l<CR>
endfunction

function! Netrw()
  let g:netrw_banner = 0
  let g:netrw_browse_split = 0
  let g:netrw_winsize = 25
  let g:netrw_liststyle = 3
  let g:netrw_altv = 1
  let g:netrw_keepdir = 0
  nnoremap ` :Explore<CR>
endfunction

function! VimEasyAlign()
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endfunction

function! FZF()
    nmap <C-p> :FZF<CR>

    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump=1
endfunction

function! Telescope()
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
endfunction

call Startup()
call EditorAppearance()
call EditorBehaviour()
call CommandModeKeyMappings()
call Navigation()

call Netrw()
call VimEasyAlign()
call FZF()
call Telescope()
