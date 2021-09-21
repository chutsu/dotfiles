function! Plugins()
  call plug#begin('~/.config/nvim/plugged')

  " Editing
  Plug 'vim-scripts/camelcasemotion'
  Plug 'kris89/vim-multiple-cursors'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'junegunn/vim-easy-align'
  Plug 'tpope/vim-surround'
  Plug 'vim-scripts/AnsiEsc.vim'
  Plug 'inside/vim-search-pulse'
  Plug 'tomtom/tcomment_vim'
  Plug 'preservim/nerdtree'
  Plug 'easymotion/vim-easymotion'

  " Visual
  Plug 'bling/vim-airline'

  " Code Formatter
  Plug 'rhysd/vim-clang-format'

  " Search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  " Syntax
  Plug 'jvirtanen/vim-octave'

  " Misc
  Plug 'voldikss/vim-browser-search'

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

  " Reload nvimrc
  map <F5> :source $MYVIMRC<CR>
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
  let g:netrw_liststyle = 1
  let g:netrw_altv = 1
  let g:netrw_keepdir = 1
  nnoremap ` :e .<CR>
endfunction

function! NerdTree()
  autocmd VimEnter * NERDTree | wincmd p

  nnoremap ` :NERDTreeToggle<CR><CR>
    " let g:NERDTreeDirArrows=0
    let g:NERDTreeWinSize=30 " set NerdTree size
    let g:NERDTreeWinPos='left'

    " if NerdTree is last thing open in vim, close vim completely
    autocmd bufenter * if (
            \ winnr("$") == 1
            \ && exists("b:NERDTreeType")
            \ && b:NERDTreeType == "primary")
            \ | q |
    \ endif
endfunction

function! VimEasyAlign()
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endfunction

function! FZF()
  nmap <C-p> :Files<CR>
  nmap <C-g> :Ag<cr>

  " [Buffers] Jump to the existing window if possible
  let g:fzf_buffers_jump=1
endfunction

function! ClangFormat()
  let g:clang_format#auto_format = 1
  let g:clang_format#detect_style_file = 1
  nmap <Leader>cf :ClangFormatAutoToggle<CR>
endfunction

function VimBrowserSearch()
  nmap <silent> <Leader>s <Plug>SearchNormal
  vmap <silent> <Leader>s <Plug>SearchVisual
endfunction

function EasyMotion()
  map <Leader> <Plug>(easymotion-prefix)
  map f <Plug>(easymotion-bd-w)
endfunction

call Plugins()
call EditorAppearance()
call EditorBehaviour()
call CommandModeKeyMappings()
call Navigation()

" call Netrw()
call NerdTree()
call VimEasyAlign()
call FZF()
call ClangFormat()
call VimBrowserSearch()
call EasyMotion()
