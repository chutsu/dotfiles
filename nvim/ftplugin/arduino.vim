" Generate ctags
autocmd BufWritePost *
  \ call system('ctags -R --exclude=bin --exclude=deps --exclude=deps --exclude=build --exclude=docs --exclude=octave .')

" Code format style
set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2

" map <F11> :e CMakeLists.txt<CR>
" map <F12> :e scripts/run.sh<CR>

nnoremap <F12> :tabnew<CR>:e scripts/run.sh<CR>
