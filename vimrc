function Pathogen()
    runtime bundle/pathogen/autoload/pathogen.vim
    call pathogen#infect()
    filetype plugin indent on
endfunction

function EditorAppearance()
    syntax on
    set laststatus=2
    set number
    set showtabline=2
    set t_Co=256

    """ gvim specific
    set guioptions-=m   " remove menubar
    set guioptions-=T   " remove toolbar
    set guifont=Monospace:h9

    " remove scroll bars - right, left, bottom
    set guioptions-=r
    set guioptions-=l
    set go-=L
    set guioptions-=b
    """

    """ nerdtree specific
    let g:NERDTreeWinSize = 25
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

    color molokai


    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    set cursorline

    highlight clear CursorLine
    highlight LineNr ctermfg=white ctermbg=black
    highlight CursorLine ctermbg=235
    highlight CursorLineNr ctermfg=235
    highlight Folded ctermfg=white ctermbg=black

    " hide '~' on non-text lines
    highlight NonText ctermfg=black guifg=black

    " split
    set fillchars=
endfunction

function DefaultCodingStyle()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab " keep tabs as spaces
    autocmd FileType c setlocal tabstop=8 shiftwidth=8 softtabstop=8
    autocmd FileType java call CCodeFolding()
    autocmd FileType python call PythonCodeFolding()
endfunction

function EditorBehaviour()
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

    let g:SuperTabDefaultCompletionType = "context"
    "autocmd VimEnter * NERDTree

    " remove trailing whitespace automatically
    autocmd FileType c,cpp,java,php,python autocmd BufWritePre <buffer> :%s/\s\+$//e
endfunction

function PythonCodeFolding()
    set foldmethod=indent
    set foldnestmax=1
    set foldlevel=2
    set foldenable

    nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
    vnoremap <Space> zf
endfunction

function JavaCodeFolding()
    set foldmethod=syntax
    set foldenable

    set foldnestmax=2
    set foldlevel=1

    nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
    vnoremap <Space> zf
endfunction

function! CFoldLevel(lnum)
    let line = getline(a:lnum)
    if line =~ '^/\*'
        return '>1' " A new fold of level 1 starts here.
    else
        return '1' " This line has a foldlevel of 1.
    endif
endfunction

function! CFoldText()
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
    return '+---- ' . (v:foldend - v:foldstart) . ' Lines: ' . signature . ' '
endfunction

function! CCodeFolding()
    set foldenable
    set foldlevel=0
    set foldmethod=expr
    set foldexpr=CFoldLevel(v:lnum)
    set foldtext=CFoldText()
    set foldnestmax=1

    nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
    vnoremap <Space> zf
endfunction

function KeyMappings()
    map <C-h> <C-w>h
    map <C-l> <C-w>l
    nmap <silent> ,/ :nohlsearch<CR>
    cmap w!! w !sudo tee % >/dev/null
    set pastetoggle=<F10>
    nnoremap <F3> :NERDTreeToggle<CR>
endfunction

function TabKeyMappings()
    map <C-k> :tabr<cr>
    map <C-j> :tabl<cr>
    map <C-h> :tabp<cr>
    map <C-l> :tabn<cr>
endfunction

function SplitKeyMappings()
    map <S-k> :wincmd k<CR>
    map <S-j> :wincmd j<CR>
    map <S-h> :wincmd h<CR>
    map <S-l> :wincmd l<CR>
endfunction

function EscapeCommonOperationTypos()
    cmap W w
    cmap Wq wq
    cmap WQ wq
    map <C-n> <TAB>
endfunction

function SyntasticOptions()
    " let g:syntastic_c_include_dirs = [ '/usr/local/include', '/usr/local/mysql-5.5.24-osx10.6-x86_64/include' ]
endfunction



call Pathogen()
call EditorAppearance()
call DefaultCodingStyle()
call EditorBehaviour()
call KeyMappings()
call TabKeyMappings()
call SplitKeyMappings()
call EscapeCommonOperationTypos()
call SyntasticOptions()
