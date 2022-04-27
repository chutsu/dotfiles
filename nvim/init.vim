function! Plugins()
  call plug#begin('~/.config/nvim/plugged')

  " Editing
  Plug 'vim-scripts/camelcasemotion'
  Plug 'kris89/vim-multiple-cursors'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'junegunn/vim-easy-align'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'vim-scripts/AnsiEsc.vim'
  Plug 'inside/vim-search-pulse'
  Plug 'preservim/nerdtree'
  Plug 'easymotion/vim-easymotion'
  Plug 'bling/vim-airline'

  " Search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'voldikss/vim-browser-search'

  " Programming Utils
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'rhysd/vim-clang-format'
  Plug 'dense-analysis/ale'
  Plug 'sirtaj/vim-openscad'

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
  set signcolumn=yes

  " Let terminal resize scale the internal windows
  autocmd VimResized * :wincmd =

  " " Highlight when code is over 81 columns
  " augroup vimrc_autocmds
  "   autocmd BufEnter * highlight OverLength ctermbg=darkgrey
  "   autocmd BufEnter * match OverLength /\%81v.*/
  " augroup END
endfunction

function! EditorBehaviour()
  filetype plugin indent on
  set exrc  " Neovim will execute .exrc, .vimrc, nvimrc found in cwd
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


  autocmd FileType python setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

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

  " Set comment string style
  autocmd FileType c setlocal commentstring=//\ %s
  autocmd FileType cpp setlocal commentstring=//\ %s
  autocmd FileType openscad setlocal commentstring=//\ %s

  " Keep search matches in the middle of the screen
  nnoremap n nzz
  nnoremap N Nzz

  " Reload nvimrc
  map <F5> :source ~/.config/nvim/init.vim<CR>
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
  map <S-r> :!bash scripts/run.sh<CR>
  nnoremap <F12> :e scripts/run.sh<CR>
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
  let NERDTreeShowHidden=1

  autocmd VimEnter * NERDTree | wincmd p
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

function! VimBrowserSearch()
  nmap <silent> <Leader>s <Plug>SearchNormal
  vmap <silent> <Leader>s <Plug>SearchVisual
endfunction

function! EasyMotion()
  map <Leader> <Plug>(easymotion-prefix)
  map f <Plug>(easymotion-bd-w)
endfunction

function! ALE()
  " Pylint
  let g:ale_python_pylint_executable = '/usr/bin/pylint3'
  " let g:ale_python_pylint_options = --indent-string='  '

	" " Display ALE Virtual Text
	" let g:ale_virtual_text_ns = nvim_create_namespace('ale_virtual_text')
  " let g:ale_virtualtext_prefix = '> '

  " YAPF
  let g:ale_python_yapf_executable = '/usr/bin/yapf3'
  let g:airline#extensions#ale#enabled = 1

  " C
  let g:ale_c_parse_makefile = 1
  let g:ale_c_cc_options = '-Wall -Wextra -I/usr/include/SDL2'


  " Fixer settings
  let g:ale_fix_on_save = 1
  let g:ale_fixers = {
  \ 'python': ['yapf'],
  \}

  " Linters
  let g:ale_linters_ignore = {
  \ 'javascript': ['eslint'],
  \}
endfunction

function! GitGutter()
  set updatetime=100
  let g:gitgutter_sign_added = '+'
  let g:gitgutter_sign_modified = '>'
  let g:gitgutter_sign_removed = '-'
  let g:gitgutter_sign_removed_first_line = '^'
  let g:gitgutter_sign_modified_removed = '<'

  let g:gitgutter_set_sign_backgrounds = 0
  highlight GitGutterAdd    ctermfg=46
  highlight GitGutterChange ctermfg=33
  highlight GitGutterDelete ctermfg=196
endfunction

" function DisplayALEVirtualText() abort
"   for l:buffer in keys(g:ale_buffer_info)
"     let l:buffer = str2nr(l:buffer)
"     call nvim_buf_clear_namespace(l:buffer, g:ale_virtual_text_ns, 0, -1)
"     let l:loclist = ale#engine#GetLoclist(l:buffer)
"     for l:err in reverse(copy(l:loclist))
"       let l:chunks = GetALEVirtualTextChunks(l:err)
"       call nvim_buf_set_virtual_text(l:buffer, g:ale_virtual_text_ns, l:err.lnum-1, l:chunks, {})
"     endfor
"   endfor
" endfunction
"
" function GetALEVirtualTextChunks(err) abort
"   let l:text = g:ale_virtualtext_prefix . substitute(a:err.text, '\r', '', 'g')
"   if a:err.type is# 'E'
"     let l:hl_group = 'ALEVirtualTextError'
"   elseif a:err.type is# 'W'
"     let l:hl_group = 'ALEVirtualTextWarning'
"   else
"     let l:hl_group = 'ALEVirtualTextInfo'
"   endif
"   return [[' ', ' '], [l:text, l:hl_group]]
" endfunction
"
" augroup ale_virtual_text
"   autocmd!
"   autocmd User ALELintPost call DisplayALEVirtualText()
" 	autocmd ColorScheme * highlight ALEVirtualTextError ctermfg=196 ctermbg=None
" 										\ | highlight ALEVirtualTextWarning ctermfg=226 ctermbg=None
" augroup END


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
call ALE()
call GitGutter()
