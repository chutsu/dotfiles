set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2


if !exists('*CPPSwitch')
    function! CPPSwitch()
        let fext = expand('%:e')
        if fext == "hpp"
            find %:t:r.cpp
        else
            find %:t:r.hpp
        endif
    endfunction
endif

nmap <F8> :call CPPSwitch()<CR>
nmap <F9> :vsplit call CPPSwitch()<CR>
