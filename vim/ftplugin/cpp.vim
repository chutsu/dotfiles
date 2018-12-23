" Code format style
set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2

" let g:project_name=expand('%:p')
let g:project_path=fnamemodify('.', ':p')
let g:project_name=split(g:project_path, "/")[-1]

function! SwitchToSource()
  let l:header_file=expand('%:r')
  let l:cpp_file=expand(join(['src'] + split(l:header_file, '/')[2:-1], '/') . '.cpp')
  execute 'edit' l:cpp_file
endfunction

function! SwitchToHeader()
  let l:header_path="include/".g:project_name
  :e %:s?src?\=l:header_path?:r.hpp
endfunction

function! SwitchCPPFile()
  if expand('%:e') == 'hpp'
    call SwitchToSource()
    return
  endif

  if expand('%:e') == 'cpp'
    call SwitchToHeader()
    return
  endif

  echo 'Error! Not a recognized file!'
endfunction

function! CPPSwitch()
  nmap <expr> <F8> expand('%:t')=~"test" ? ':echom "Invalid operation!"<CR>':':call SwitchCPPFile()<CR>'
endfunction

" Key binding to switch between header and source
nmap <expr> <F8>
  \ expand('%:t')=~"test"
  \ ? ':echom "Invalid operation!"<CR>':':call ftplugin#cpp#SwitchCPPFile()<CR>'

" Key binding to bring up unit-test
" map <S-t> :vsplit %:s?src?tests?:r_test.cpp<CR>
map <expr> <S-t>
  \ ftplugin#cpp#IsTestFile()
  \ ? ':echom "Invalid operation!"<CR>':':vsplit %:s?src?tests?:r.cpp<CR>'

" Key binding to switch to previous buffer
map ` :bprevious<CR>

" Sane line joins
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

map <F11> :e CMakeLists.txt<CR>
map <F12> :e scripts/run.sh<CR>
