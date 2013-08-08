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

    " remove trailing whitespace automatically when saving
    autocmd FileType c,cpp,java,php,python
            \ autocmd BufWritePre <buffer> :%s/\s\+$//e

    " reload vimrc after update
    autocmd BufWritePost .vimrc so ~/.vimrc

    " recognize markdown files
    autocmd BufRead,BufNewFile *.md set filetype=markdown

    " plain text mode
    autocmd FileType text,markdown call PlainText()

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
endfunction

function! DefaultCodingStyle()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab " expand tabs as spaces
    autocmd FileType c setlocal tabstop=8 shiftwidth=8 softtabstop=8

    " highlight red when code is over 80 columns
    augroup vimrc_autocmds
        autocmd BufEnter * highlight OverLength ctermbg=darkgrey 
        autocmd BufEnter * match OverLength /\%80v.*/
    augroup END
endfunction

function! CommandModeKeyMappings()
    map <C-h> <C-w>h
    map <C-l> <C-w>l
    nmap <silent> ,/ :nohlsearch<CR>
    cmap w!! w !sudo tee % >/dev/null
    set pastetoggle=<F10>
    nnoremap <F3> :NERDTreeToggle<CR><CR>
    map <F12> :!dot % -Tps -o %:r.ps<CR>
    map <S-x> :wq<CR>
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
    nnoremap <F8> :vsplit<CR>:FSHere<CR>
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
    " do not highlight extra whitespace
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=None guibg=None

    " hardwrap ignore lines starting with variable "-", "=" or "#"
    set comments+=n:--,n:==,n:#

    augroup PROSE
        autocmd InsertEnter * set formatoptions+=a
        autocmd InsertLeave * set formatoptions-=a
    augroup END
endfunction

function! Pathogen()
    execute pathogen#infect()
endfunction

function! SyntasticOptions()
    " c specific settings
    let g:syntastic_enable_highlighting=1
    let g:syntastic_check_on_open=1
    let g:syntastic_enable_signs=1
    let g:syntastic_c_include_dirs=[
            \ 'include',
            \ '../include',
            \ '../*/include',
            \ '/usr/include',
            \ '/usr/local/include'
    \ ]

    " python specific settings
    let g:syntastic_python_checkers=['flake8']

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

    " if NerdTree is last thing open in vim, close vim completely
    autocmd bufenter * if (
            \ winnr("$") == 1
            \ && exists("b:NERDTreeType")
            \ && b:NERDTreeType == "primary")
            \ | q |
    \ endif
endfunction

function! YouCompleteMe()
    " force blocking compilation cycle
    nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
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
call NerdTree()
call YouCompleteMe()
