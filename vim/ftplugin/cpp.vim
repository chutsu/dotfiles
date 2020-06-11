if (&ft != 'cpp')
  finish
endif

" " Generate ctags
" autocmd BufWritePost *
"   \ call system('ctags -R --exclude=dep --exclude=deps --exclude=build --exclude=docs --exclude=octave .')

" Code format style
set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2

" let g:project_name=expand('%:p')
let g:project_path=fnamemodify('.', ':p')
let g:project_name=split(g:project_path, "/")[-1]

" Key binding to switch between header and source
nmap <expr> <C-i> ':call ftplugin#cpp#SwitchCPPFile()<CR>'
nnoremap <F12> :tabnew<CR>:e scripts/run.sh<CR>

" " Key binding to bring up unit-test
" " map <S-t> :vsplit %:s?src?tests?:r_test.cpp<CR>
" map <expr> <S-t>
"   \ ftplugin#cpp#IsTestFile()
"   \ ? ':echom "Invalid operation!"<CR>':':vsplit %:s?src?tests?:r.cpp<CR>'

