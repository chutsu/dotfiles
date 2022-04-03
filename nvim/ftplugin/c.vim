" If file is not a C file quit early
if (&ft != 'c')
  finish
endif

" Generate ctags
autocmd BufWritePost *
  \ call system('ctags -R --exclude=bin --exclude=deps --exclude=deps --exclude=build --exclude=docs --exclude=octave .')

command! -buffer CSwitchFile call ftplugin#c#SwitchFile()
nnoremap <buffer> <C-i> :call ftplugin#c#SwitchFile()<CR>

" Code format style
set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2

" Shortcut key to bring up unit-test
map <S-t> :vsplit %:s?src?tests?test_:r.c<CR>

" Sane line joins
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif
