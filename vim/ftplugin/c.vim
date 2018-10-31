" If file is not a C file quit early
if (&ft != 'c')
  finish
endif

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

  echo 'Error a recognized C++ File!'
endfunction

function! CPPSwitch()
  nmap <expr> <F8> expand('%:t')=~"test" ? ':echom "Invalid operation!"<CR>':':call SwitchCPPFile()<CR>'
endfunction

" Code format style
set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2

" Shortcut key to bring up unit-test
map <S-t> :vsplit %:s?src?tests?:r_test.c<CR>

" Sane line joins
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif
