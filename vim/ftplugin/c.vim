" If file is not a C file quit early
if (&ft != 'c')
  finish
endif

" function! CSwitch()
"   nmap <expr> <F8> expand('%:t')=~"test" ? ':echom "Invalid operation!"<CR>':':call CSwitchFile()<CR>'
" endfunction

"map <F8> :call CSwitchFile()<CR>
command -buffer CSwitchFile call ftplugin#c#SwitchFile()
nnoremap <buffer> <F8> :call ftplugin#c#SwitchFile()<CR>


" Code format style
set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2

" Shortcut key to bring up unit-test
map <S-t> :vsplit %:s?src?tests?:r_test.c<CR>

" Key binding to switch to previous buffer
map ` :bprevious<CR>

" Sane line joins
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

map <F11> :e CMakeLists.txt<CR>
map <F12> :e scripts/run.sh<CR>
