function! EditorAppearance()
    syntax on
    set laststatus=2
    set number
    set showtabline=2
    set t_Co=256
    " colorscheme molokai
    colorscheme eyecandy
    set cursorline
    set fillchars=" split char
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
    " autocmd BufWritePost .vimrc so ~/.vimrc

    " correct filetype recognition
    autocmd BufRead,BufNewFile *.h set filetype=c
    autocmd FileType c call CMode()
    autocmd FileType java call JavaMode()

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
    autocmd FileType java setlocal tabstop=2 shiftwidth=2 softtabstop=2

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
    map <F12> :tabnew run.sh<CR>

    " run script file
    map <S-r> :!clear && bash run.sh<CR>

    " Show syntax highlighting groups for word under cursor
    nmap <C-G> :call <SID>SynStack()<CR>
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

function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

function! Multiple_cursors_before()
    echo 'Disabled autocomplete'
    let g:ycm_auto_trigger = 0  " switch off YCM temporarily
endfunction

function! Multiple_cursors_after()
    echo 'Enabled autocomplete'
    let g:ycm_auto_trigger = 1  " turn YCM back on
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
    " let g:syntastic_mode_map = {'mode': 'passive'}

    " c specific settings
    let g:syntastic_c_config_file='.syntastic_config'
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

    " java specific settings
    let g:syntastic_java_javac_classpath='./bin/classes:'


    " python specific settings
    let g:syntastic_python_checkers=['flake8']
    " let g:syntastic_ignore_files = ['\.py$']

    " html specific settings
    let g:syntastic_html_checkers=['']  " disable syntastic for html files

    " javascript specific settings
    let g:syntastic_javascript_checkers = ['jshint']

    " warning and error symbols
    let g:syntastic_warning_symbol       = 'W'
    let g:syntastic_error_symbol         = 'E'
    let g:syntastic_style_error_symbol   = 'SE'
    let g:syntastic_style_warning_symbol = 'SW'
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
    let g:ycm_server_keep_logfiles=1
    let g:ycm_server_log_level="debug"
    let g:ycm_autoclose_preview_window_after_completion=1
endfunction

function! Taglist()
    let g:Tlist_WinWidth=50
    let g:Tlist_Use_Right_Window=1
    nnoremap <silent> <F6> :TlistToggle<CR>
endfunction

function! PythonMode()
    let g:pymode_lint=1
    let g:pymode_folding=0
    let g:pymode_doc=0
    let g:pymode_lint_on_fly=0
    let g:pymode_rope_completion=0

    " shortcut key to bring up corresponding unit test
    " map <S-t> :vsplit %:s?:h?tests?:r_tests.py<CR>
endfunction

function! CMode()
    " shortcut key to bring up corresponding unit test
    map <S-t> :vsplit %:s?src?tests?:r_test.c<CR>
endfunction

function! JavaMode()

endfunction

function! EasyGrep()
    let g:EasyGrepRecursive=1
    let g:EasyGrepReplaceWindowMode=2
endfunction

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

function! Ultisnips()
    " Track the engine.
    " Plugin 'SirVer/ultisnips'

    " Snippets are separated from the engine. Add this if you want them:
    " Plugin 'honza/vim-snippets'

    " Trigger configuration. Do not use <tab> if you use
    " https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

    " set python version
    let g:UltiSnipsUsePythonVersion=2

    au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsListSnippets="<c-e>"

    " this mapping Enter key to <C-y> to chose the current highlight item
    " and close the selection list, same as other IDEs.
    " CONFLICT with some plugins like tpope/Endwise
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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

" PLUGIN SETTINGS
call Powerline()
call SyntasticOptions()
call YouCompleteMe()
call NerdTree()
call Taglist()
call PythonMode()
call EasyGrep()
call Ultisnips()
