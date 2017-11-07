set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2

map <S-t> :vsplit %:s?src?tests?:r_test.cpp<CR>
