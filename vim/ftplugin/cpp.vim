" Code format style
set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2

" let g:project_name=expand('%:p')
let g:project_path=fnamemodify('.', ':p')
let g:project_name=split(g:project_path, "/")[-1]

function! IsTestFile()
  return expand('%:t')=~"test" || expand('%:t')=~".hpp"
endfunction

" Shortcut key to bring up unit-test
" map <S-t> :vsplit %:s?src?tests?:r_test.cpp<CR>
map <expr> <S-t> IsTestFile() ? ':echom "Invalid operation!"<CR>':':vsplit %:s?src?tests?:r_test.cpp<CR>'



" Sane line joins
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif
