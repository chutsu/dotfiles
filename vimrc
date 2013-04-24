function! Vundle()
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Bundle  'tpope/vim-fugitive.git'
    Bundle  'tpope/vim-pathogen.git'
    Bundle  'tomtom/tlib_vim.git'
    Bundle  'MarcWeber/vim-addon-mw-utils.git'
    Bundle  'bsl/obviousmode.git'
    Bundle  'tpope/vim-surround.git'
    Bundle  'tpope/vim-markdown.git'
    Bundle  'tomtom/tcomment_vim.git'
    Bundle  'scrooloose/nerdtree.git'
    Bundle  'suan/vim-instant-markdown.git'
    Bundle  'seebi/dircolors-solarized.git'
    Bundle  'derekwyatt/vim-fswitch.git'
    Bundle  'scrooloose/syntastic.git'
    Bundle  'bronson/vim-trailing-whitespace.git'
    Bundle  'terryma/vim-multiple-cursors.git'
    Bundle  'skammer/vim-css-color.git'
    Bundle  'Lokaltog/vim-powerline.git'
endfunction

function! Powerline()
    set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
endfunction

function! EditorAppearance()
    syntax on
    set laststatus=2
    set number
    set showtabline=2
    set t_Co=256

    """ gvim specific
    set guioptions-=m   " remove menubar
    set guioptions-=T   " remove toolbar
    set guifont=Monospace:h7

    " remove scroll bars - right, left, bottom
    set guioptions-=r
    set guioptions-=l
    set go-=L
    set guioptions-=b
    """

    """ nerdtree specific
    let g:NERDTreeWinSize=30 
    autocmd bufenter * if (
            \ winnr("$") == 1
            \ && exists("b:NERDTreeType")
            \ && b:NERDTreeType == "primary")
            \ | q |
    \ endif

    " colorscheme xoria256
    colorscheme molokai
    set cursorline

    " split
    set fillchars=

endfunction

function! EditorBehaviour()
    set backupdir=/tmp
    set directory=/tmp
    set title
    set visualbell
    set noerrorbells
    set history=1000
    set undolevels=1000
    set showmatch
    set ignorecase
    filetype plugin indent on
    set autoindent
    set copyindent
    set shiftround
    set backspace=indent,eol,start
    set smartcase
    set smarttab
    set hlsearch
    set incsearch

    " remove trailing whitespace automatically
    autocmd FileType c,cpp,java,php,python
            \ autocmd BufWritePre <buffer> :%s/\s\+$//e

    " reload vimrc after update 
    au BufWritePost .vimrc so ~/.vimrc

    " reselect block after indentation
    vnoremap < <gv
    vnoremap > >gv
endfunction

function! EditorSettings()
endfunction

function! DefaultCodingStyle()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab " expand tabs as spaces
    autocmd FileType c setlocal tabstop=8 shiftwidth=8 softtabstop=8

    " highlight red when code is over 80 columns
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endfunction

function! CodeFolding()
    " autocmd FileType c call CCodeFolding() 
    " autocmd FileType java call JavaCodeFolding()
    " autocmd FileType python call PythonCodeFolding()

    autocmd InsertEnter * if !exists('w:last_fdm')
            \ | let w:last_fdm=&foldmethod
            \ | setlocal foldmethod=manual
            \ | endif
    autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
            \ | let &l:foldmethod=w:last_fdm
            \ | unlet w:last_fdm
            \ | endif
    nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
    vnoremap <Space> zf
endfunction

function! CHeaderDisplay()

endfunction



function! PythonCodeFolding()
    set foldmethod=indent
    set foldnestmax=1
    set foldlevel=2
    set foldenable
endfunction

function! JavaCodeFolding()
    set foldmethod=syntax
    set foldenable
    set foldnestmax=2
    set foldlevel=1
    set foldlevelstart=99
endfunction

function! CCodeFolding()
    set foldmethod=syntax
    set foldenable
    set foldlevel=0
    set foldnestmax=1
    set foldtext=FoldText()
    set foldlevelstart=20

    nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
    vnoremap <Space> zf
endfunction

function! FoldText()
    " Look through all of the folded text for the function signature.
    let signature = ''
    let i = v:foldstart
    while signature == '' && i < v:foldend
    let line = getline(i)
    if line =~ '\w\+(.*)$'
        let signature = line
    endif
    let i = i + 1
    endwhile

    " Return what the fold should show when folded.
    return '+----- ' . (v:foldend - v:foldstart) . ' lines' . '-----'
endfunction

function! KeyMappings()
    map <C-h> <C-w>h
    map <C-l> <C-w>l
    nmap <silent> ,/ :nohlsearch<CR>
    cmap w!! w !sudo tee % >/dev/null
    set pastetoggle=<F10>
    nnoremap <F3> :NERDTreeToggle<CR><CR>
    map <F12> :!dot % -Tps -o %:r.ps<CR>
    map <S-x> :wq<CR>
endfunction

function! TabKeyMappings()
    map <C-k> :tabr<cr>
    map <C-j> :tabl<cr>
    map <C-h> :tabp<cr>
    map <C-l> :tabn<cr>
endfunction

function! SplitKeyMappings()
    map <S-k> :wincmd k<CR>
    map <S-j> :wincmd j<CR>
    map <S-h> :wincmd h<CR>
    map <S-l> :wincmd l<CR>
endfunction

function! HeaderSwitchMappings()
    nnoremap <F7> :FSLeft<CR>
    nnoremap <F8> :FSHere<CR>
    nnoremap <F9> :FSRight<CR>
    nnoremap <F4> :split<CR>:FSHere<CR><CR>:resize -10<CR>
endfunction

function! EscapeCommonOperationTypos()
    cmap W w
    cmap Wq wq
    cmap WQ wq
    map <C-n> <TAB>
endfunction

function! SyntasticOptions()
    " c specific settings
    let g:syntastic_enable_highlighting=1
    let g:syntastic_check_on_open=1
    let g:syntastic_enable_signs=1
    let g:syntastic_c_include_dirs=[
            \ 'include',
            \ '../include',
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

" MAIN
call Vundle()
call Powerline()
call EditorAppearance()
call EditorBehaviour()
call EditorSettings()
call DefaultCodingStyle()
call CodeFolding()
call KeyMappings()
call TabKeyMappings()
call SplitKeyMappings()
call HeaderSwitchMappings()
call EscapeCommonOperationTypos()
call SyntasticOptions()
