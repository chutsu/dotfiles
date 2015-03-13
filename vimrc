function! EditorAppearance()
    syntax on
    set laststatus=2
    set number
    set showtabline=2
    set t_Co=256
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
    autocmd BufRead /tmp/mutt-* call Mutt()

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
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType java setlocal tabstop=2 shiftwidth=2 softtabstop=2

    " highlight when code is over 80 columns
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
    set formatoptions+=a

    " do not highlight extra whitespace
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=None guibg=None

    " hardwrap ignore lines starting with variable "-", "=", "#", "\"
    set comments+=n:--,n:==,n:#,n:\

    " hardwrap shortcut keys
    nnoremap <F1> :set formatoptions+=a<CR>
    nnoremap <F2> :set formatoptions-=a<CR>
endfunction

function! Vundle()
    set nocompatible              " be iMproved, required
    filetype off                  " required

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    " The following are vim packages
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-surround'
    Plugin 'tomtom/tcomment_vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'derekwyatt/vim-fswitch'
    Plugin 'scrooloose/syntastic'
    Plugin 'bronson/vim-trailing-whitespace'
    Plugin 'petRUShka/vim-opencl'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'bling/vim-airline'
    Plugin 'vim-scripts/taglist.vim'
    Plugin 'kien/ctrlp.vim'
    Plugin 'vim-scripts/EasyGrep'
    Plugin 'klen/python-mode'
    Plugin 'shinokada/SWTC.vim'
    Plugin 'kris89/vim-multiple-cursors'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'junegunn/fzf'
    Plugin 'SirVer/ultisnips'
    Plugin 'vim-scripts/javaimp.vim'
    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'

    " All of your Plugins must be added before the following line'
    call vundle#end()            " required
    filetype plugin indent on    " required
    " To ignore plugin indent changes, instead use:
    " filetype plugin on

    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to
    " auto-approve removal

    " see :h vundle for more details or wiki for FAQ
    " Put your non-Plugin stuff after this line
endfunction


function! SyntasticOptions()
    " c specific settings
    let g:syntastic_c_config_file='.syntastic_config'
    let g:syntastic_enable_highlighting=1
    let g:syntastic_check_on_open=1
    let g:syntastic_enable_signs=1
    let g:syntastic_c_include_dirs=[
        \ 'include',
        \ '/usr/include',
        \ '/usr/local/include',
        \ '/usr/local/CrossPack-AVR/avr/include'
    \ ]
    let g:syntastic_c_checkers=['gcc']
    let g:syntastic_c_compiler = 'clang'
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

function! Airline()
    " let g:airline_powerline_fonts = 1
    " let g:airline_theme = "jellybeans"
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
    " let g:ycm_server_log_level="debug"
    let g:ycm_autoclose_preview_window_after_completion=1
endfunction

function! Taglist()
    let g:Tlist_WinWidth=50
    let g:Tlist_Use_Right_Window=1
    nnoremap <silent> <F6> :TlistToggle<CR>
endfunction

function! Mutt()
    set tw=72
    set fo+=aw
endfunction

function! PythonMode()
    let g:pymode_lint=1
    let g:pymode_folding=0
    let g:pymode_doc=0
    let g:pymode_lint_on_fly=0
    let g:pymode_rope_completion=0
    let g:pymode_options_colorcolumn=0

    " shortcut key to bring up corresponding unit test
    " map <S-t> :vsplit %:s?:h?tests?:r_tests.py<CR>
endfunction

function! CMode()
    " shortcut key to bring up corresponding unit test
    map <S-t> :vsplit %:s?src?tests?:r_test.c<CR>

    " header shortcuts
    call HeaderSwitchMappings()
endfunction

function! JavaInsertImport()
  exe "normal mz"
  let cur_class = expand("<cword>")
  try
    if search('^\s*import\s.*\.' . cur_class . '\s*;') > 0
      throw getline('.') . ": import already exist!"
    endif
    wincmd }
    wincmd P
    1
    if search('^\s*public.*\s\%(class\|interface\)\s\+' . cur_class) > 0
      1
      if search('^\s*package\s') > 0
        yank y
      else
        throw "Package definition not found!"
      endif
    else
      throw cur_class . ": class not found!"
    endif
    wincmd p
    normal! G
    " insert after last import or in first line
    if search('^\s*import\s', 'b') > 0
      put y
    else
      1
      put! y
    endif
    substitute/^\s*package/import/g
    substitute/\s\+/ /g
    exe "normal! 2ER." . cur_class . ";\<Esc>lD"
  catch /.*/
    echoerr v:exception
  finally
    " wipe preview window (from buffer list)
    silent! wincmd P
    if &previewwindow
      bwipeout
    endif
    exe "normal! `z"
  endtry
endfunction

function! JavaMode()
    map <F5> :call JavaInsertImport()<CR>
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
    " Trigger configuration. Do not use <tab> if you use
    " https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " snippet search path
    let g:UltisnipsSnippetsDir="~/vim/snippets/"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

    " set python version
    let g:UltiSnipsUsePythonVersion=2

    " au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
    " let g:UltiSnipsJumpForwardTrigger="<tab>"
    " let g:UltiSnipsListSnippets="<c-e>"

    " this mapping Enter key to <C-y> to chose the current highlight item
    " and close the selection list, same as other IDEs.
    " CONFLICT with some plugins like tpope/Endwise
    " inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endfunction

function! VimMarkDown()
    let g:vim_markdown_folding_disabled=1
endfunction



" MAIN
call Vundle()
call EditorAppearance()
call EditorBehaviour()
call CommandModeKeyMappings()
call DefaultCodingStyle()
call NavImproved()
call VimTabsKeyMappings()
call VimSplitsKeyMappings()
call EscapeCommonOperationTypos()

" PLUGIN SETTINGS
call Airline()
call SyntasticOptions()
call YouCompleteMe()
call NerdTree()
call Taglist()
call PythonMode()
call EasyGrep()
call Ultisnips()
call VimMarkDown()
