if (&ft != 'cpp')
  finish
endif

" Code format style
set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2

" let g:project_name=expand('%:p')
let g:project_path=fnamemodify('.', ':p')
let g:project_name=split(g:project_path, "/")[-1]

" Key binding to switch between header and source
nmap <expr> <F8> ':call ftplugin#cpp#SwitchCPPFile()<CR>'

" " Key binding to bring up unit-test
" " map <S-t> :vsplit %:s?src?tests?:r_test.cpp<CR>
" map <expr> <S-t>
"   \ ftplugin#cpp#IsTestFile()
"   \ ? ':echom "Invalid operation!"<CR>':':vsplit %:s?src?tests?:r.cpp<CR>'
