function! EditorAppearance()
    syntax on
    set laststatus=2
    set number
    set showtabline=2
    set t_Co=256
    colorscheme molokai
    set cursorline
    set fillchars=  " split char
endfunction

function! EditorBehaviour()
    filetype plugin indent on
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
    set smarttab
    set hlsearch
    set incsearch
    set mouse=a  " enable mouse
    set scrolloff=10  " top/bottom padding when scrolling

    " remove trailing whitespace automatically when saving
    autocmd FileType c,cpp,java,php,python,javascript
            \ autocmd BufWritePre <buffer> :%s/\s\+$//e

    " reload vimrc after update
    autocmd BufWritePost .vimrc so ~/.vimrc

    " recognize files
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.pde set filetype=arduino
    autocmd BufRead,BufNewFile *.ino set filetype=arduino

    " plain text mode
    autocmd FileType text,markdown call PlainText()
    autocmd BufNewFile,BufRead *.tex call PlainText()

    " reselect block after indentation
    vnoremap < <gv
    vnoremap > >gv

    " restore cursor's last position in file
    autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

    " highlight non-ascii characters
    set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•

    " softwrap lines
    command! -range=% SoftWrap
                \ <line2>put _ |
                \ <line1>,<line2>g/.\+/ .;-/^$/ join |normal $x

    " scroll to top when jusing jump-to in ctags
    nnoremap <C-]> <C-]>zt
    nnoremap <C-t> <C-t>zt

endfunction

function! DefaultCodingStyle()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab " expand tabs as spaces
    autocmd FileType c setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4

    " highlight red when code is over 80 columns
    augroup vimrc_autocmds
        autocmd BufEnter * highlight OverLength ctermbg=darkgrey 
        autocmd BufEnter * match OverLength /\%80v.*/
    augroup END
endfunction

function! CommandModeKeyMappings()
    map <C-h> <C-w>h
    map <C-l> <C-w>l
    map <S-x> :wq<CR>
    cmap w!! w !sudo tee % >/dev/null
    nmap <silent> ,/ :nohlsearch<CR>

    nnoremap <F3> :NERDTreeToggle<CR><CR>
    set pastetoggle=<F10>
    map <F12> :!dot % -Tps -o %:r.ps<CR>

    " run script file
    map <S-r> :!clear && bash run.sh<CR>
endfunction

function! NavImproved()
    nnoremap j gj
    nnoremap k gk
    vnoremap j gj
    vnoremap k gk
endfunction

function! VimTabsKeyMappings()
    map <C-k> :tabr<cr>
    map <C-j> :tabl<cr>
    map <C-h> :tabp<cr>
    map <C-l> :tabn<cr>
endfunction

function! VimSplitsKeyMappings()
    map <S-k> :wincmd k<CR>
    map <S-j> :wincmd j<CR>
    map <S-h> :wincmd h<CR>
    map <S-l> :wincmd l<CR>
endfunction

function! HeaderSwitchMappings()
    nnoremap <F7> :vsplit<CR>:FSLeft<CR>
    nnoremap <F8> :FSHere<CR>
    nnoremap <F9> :vsplit<CR>:FSRight<CR>
    nnoremap <F4> :split<CR>:FSHere<CR><CR>:resize -10<CR>
endfunction

function! EscapeCommonOperationTypos()
    cmap Wq wq
    cmap WQ wq
    map <C-n> <TAB>
endfunction

function! GVimSpecific()
    set guioptions-=m   " remove menubar
    set guioptions-=T   " remove toolbar
    set guifont=Monospace:h7

    " remove scroll bars - right, left, bottom
    set guioptions-=r
    set guioptions-=l
    set go-=L
    set guioptions-=b
endfunction

function! PlainText()
    " spell checker
    set spell
    set spelllang=en_gb

    " do not highlight extra whitespace
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=None guibg=None

    " hardwrap ignore lines starting with variable "-", "=", "#", "\"
    set comments+=n:--,n:==,n:#,n:\

    " hardwrap shortcut keys
    nnoremap <F1> :set formatoptions+=a<CR>
    nnoremap <F2> :set formatoptions-=a<CR>
endfunction

function! Pathogen()
    execute pathogen#infect()
endfunction

function! SyntasticOptions()
    " c specific settings
    let g:syntastic_c_config_file = '.syntastic_config'
    let g:syntastic_enable_highlighting=1
    let g:syntastic_check_on_open=1
    let g:syntastic_enable_signs=1
    let g:syntastic_c_include_dirs=[
        \ 'include',
        \ '../include',
        \ '../dbg/include',
        \ '../munit/include',
        \ '../al/include',
        \ '../dstruct/include',
        \ '../evolve/include',
        \ '/usr/include',
        \ '/usr/local/include',
        \ '/usr/local/CrossPack-AVR/avr/include'
    \ ]

    let g:syntastic_cpp_include_dirs=[
        \ 'src'
    \ ]

    " python specific settings
    let g:syntastic_python_checkers=['flake8']
    " let g:syntastic_ignore_files = ['\.py$']

    " javascript specific settings
    let g:syntastic_javascript_checkers = ['jshint']

    " warning and error symbols
    let g:syntastic_warning_symbol='W'
    let g:syntastic_error_symbol='E'
    let g:syntastic_style_error_symbol='SE'
    let g:syntastic_style_warning_symbol='SW'
endfunction


function! Powerline()
    set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
endfunction

function! NerdTree()
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

function! YouCompleteMe()
    nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
endfunction

function! Taglist()
    let g:Tlist_WinWidth=50
    let g:Tlist_Use_Right_Window=1
    nnoremap <silent> <F6> :TlistToggle<CR>
endfunction

function! PythonMode()
    let g:pymode_lint = 1
    let g:pymode_folding = 0
    let g:pymode_doc = 0
    let g:pymode_lint_on_fly = 0
    let g:pymode_rope_completion = 0
endfunction





" MAIN
call Pathogen()
call EditorAppearance()
call EditorBehaviour()
call CommandModeKeyMappings()
call DefaultCodingStyle()
call NavImproved()
call VimTabsKeyMappings()
call VimSplitsKeyMappings()
call HeaderSwitchMappings()
call EscapeCommonOperationTypos()
call GVimSpecific()

" PLUGIN SETTINGS
call Powerline()
call SyntasticOptions()
call YouCompleteMe()
call NerdTree()
call Taglist()
call PythonMode()
